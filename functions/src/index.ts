import {onCall, HttpsOptions} from "firebase-functions/v2/https";
import * as logger from "firebase-functions/logger";
import {getFirestore} from "firebase-admin/firestore";
import * as admin from "firebase-admin";
import axios from "axios";
import {frequencyToNote} from "./utils/frequency_converter";

// Initialize Firebase Admin SDK if not already initialized
// This is required for Firestore access
if (!admin.apps.length) {
  admin.initializeApp();
}

// Get Firestore instance for database operations
const db = getFirestore();

// URL of the Python server that performs pitch detection
// This server analyzes WAV files and returns frequency data
const PITCH_DETECTION_SERVER =
"https://2d1c-24-153-157-38.ngrok-free.app/";

/**
 * Cloud Function that generates guitar tabs from audio files
 * 1. Downloads WAV file from provided URL
 * 2. Sends to pitch detection server for frequency analysis
 * 3. Converts frequencies to guitar notes and positions
 * 4. Stores results in Firestore as guitar tablature
 */
export const generateTabFromAudio = onCall(
  {
    // Disable app check for testing purposes
    enforceAppCheck: false,
    allowInvalidAppCheckToken: true,
  } as HttpsOptions,
  async (request) => {
    try {
      // Extract WAV URL and AI Tabs document ID from the request
      const {wavurl, aiTabsDocumentId} = request.data;
      
      // Validate required parameters
      if (!wavurl) {
        throw new Error("WAV URL is required");
      }
      if (!aiTabsDocumentId) {
        throw new Error("AI Tabs document ID is required");
      }

      // Step 1: Download the WAV file from Firebase Storage
      logger.info("Downloading WAV file");
      const audioResponse = await axios.get(wavurl, {
        responseType: "arraybuffer",
      });

      // Step 2: Prepare the WAV file for pitch detection
      const formData = new FormData();
      const audioBlob = new Blob([audioResponse.data],
        {type: "audio/wav"});
      formData.append("audio", audioBlob, "audio.wav");

      // Step 3: Send to pitch detection server and get frequency analysis
      logger.info("Analyzing audio");
      const {data} = await axios.post(
        `${PITCH_DETECTION_SERVER}/analyze`,
        formData,
        {
          headers: {"Content-Type": "multipart/form-data"},
        }
      );

      // Step 4: Transform frequency results into guitar tab format
      // Each frequency becomes a measure with note positions
      const measures: Record<string, any> = {};
      data.results.forEach((result: {frequency: number}, index: number) => {
        // Convert frequency to guitar note and position
        const noteInfo = frequencyToNote(result.frequency);
        if (!noteInfo || !noteInfo.positions.length) {
          return;
        }

        // Get the first available position for this note
        const position = noteInfo.positions[0];
        
        // Calculate measure index and position within measure using same logic as migration
        const measureIndex = Math.floor(index / 27);  // Integer division by 27 (not 26)
        const positionInMeasure = index - (measureIndex * 27);  // Remainder calculation matching migration
        
        // Create measure if it doesn't exist
        const measureKey = measureIndex.toString();
        if (!measures[measureKey]) {
          measures[measureKey] = {
            index: measureIndex,
            strings: {},
            timeSignature: "4/4",
          };
        }

        // Add note to the appropriate measure
        const currentMeasure = measures[measureKey];
        if (!currentMeasure.strings["0"]) {
          currentMeasure.strings["0"] = { notes: {} };
        }

        // Add the note with the correct position
        const noteKey = Object.keys(currentMeasure.strings["0"].notes).length.toString();
        currentMeasure.strings["0"].notes[noteKey] = {
          duration: 1,
          fret: position.fret,
          position: positionInMeasure,  // Use the calculated position within measure
          string: position.string,
        };
      });

      // Step 5: Update the Firestore document with the generated tab
      await db.collection("ai_tabs").doc(aiTabsDocumentId).update({
        // Store measures in content.sections array
        "content.sections": [{
          name: "Intro",
          measures: measures,
        }],
        // Set default metadata
        "content.difficulty": "medium",
        // Standard guitar tuning
        tuning: {
          "0": "E",  // Low E string
          "1": "A",
          "2": "D",
          "3": "G",
          "4": "B",
          "5": "e",  // High E string
        },
        updated_at: admin.firestore.FieldValue.serverTimestamp(),
      });

      // Return success response with measure count
      return {
        success: true,
        message: "Tab generated successfully",
        measureCount: Object.keys(measures).length,
      };
    } catch (error) {
      // Log and rethrow any errors that occur
      logger.error("Error analyzing audio", error);
      throw new Error(error instanceof Error ?
        error.message : "Analysis failed");
    }
  }
);
