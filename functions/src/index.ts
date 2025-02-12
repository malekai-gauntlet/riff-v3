import {onCall, HttpsOptions} from "firebase-functions/v2/https";
import * as logger from "firebase-functions/logger";
import axios from "axios";
import {frequencyToNote} from "./utils/frequency_converter";

const PITCH_DETECTION_SERVER =
"https://d0fd-2600-1700-291-4b60-b455-5342-b03c-f1aa.ngrok-free.app";

export const generateTabFromAudio = onCall(
  {
    enforceAppCheck: false,
    allowInvalidAppCheckToken: true,
  } as HttpsOptions,
  async (request) => {
    try {
      const {documentId} = request.data;
      if (!documentId) {
        throw new Error("WAV URL is required");
      }

      // Download WAV file
      logger.info("Downloading WAV file");
      const audioResponse = await axios.get(documentId, {
        responseType: "arraybuffer",
      });

      // Create form data and send to pitch detection server
      const formData = new FormData();
      const audioBlob = new Blob([audioResponse.data],
        {type: "audio/wav"});
      formData.append("audio", audioBlob, "audio.wav");

      // Get pitch analysis
      logger.info("Analyzing audio");
      const {data} = await axios.post(
        `${PITCH_DETECTION_SERVER}/analyze`,
        formData,
        {
          headers: {"Content-Type": "multipart/form-data"},
        }
      );

      // Map results and add note information
      return {
        ...data,
        results: data.results.map((r: {frequency: number}) => ({
          ...r,
          note: frequencyToNote(r.frequency),
        })),
      };
    } catch (error) {
      logger.error("Error analyzing audio", error);
      throw new Error(error instanceof Error ?
        error.message : "Analysis failed");
    }
  }
);
