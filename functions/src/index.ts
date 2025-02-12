import {onCall, HttpsOptions} from "firebase-functions/v2/https";
import * as logger from "firebase-functions/logger";
import * as admin from "firebase-admin";
import * as Pitchfinder from "pitchfinder";
import * as WavDecoder from "wav-decoder";
import fetch from "node-fetch";
// Initialize Firebase Admin
admin.initializeApp();

// Start writing functions
// https://firebase.google.com/docs/functions/typescript

export const generateTabFromAudio = onCall(
  {
    enforceAppCheck: false, // disable app check
    allowInvalidAppCheckToken: true, // allow invalid tokens
  } as HttpsOptions,
  async (request) => {
    try {
      logger.info("Starting tab generation", {structuredData: true});
      const {documentId} = request.data;
      if (!documentId) {
        throw new Error("Document ID is required");
      }

      // Get the video document from Firestore
      const videoDoc = await admin
        .firestore()
        .collection("videos")
        .doc(documentId)
        .get();

      if (!videoDoc.exists) {
        throw new Error("Video document not found");
      }

      const videoData = videoDoc.data();
      if (!videoData?.mp3url) {
        throw new Error("WAV URL not found in video document");
      }

      // Download the WAV file
      logger.info("Downloading WAV file", {
        url: videoData.mp3url,
        timestamp: new Date().toISOString(),
      });
      const response = await fetch(videoData.mp3url, {
        headers: {
          "Accept": "audio/wav",
        },
      });

      if (!response.ok) {
        logger.error("Failed to download WAV file", {
          status: response.status,
          statusText: response.statusText,
          headers: response.headers,
        });
        throw new Error(`Failed to download WAV file: ${response.statusText}`);
      }

      // Get the buffer directly from response
      const arrayBuffer = await response.arrayBuffer();
      // Convert ArrayBuffer to Node.js Buffer for WAV decoder
      const nodeBuffer = Buffer.from(arrayBuffer);
      // Decode WAV file using sync method as shown in example
      logger.info("Decoding WAV file");
      let decoded;
      try {
        // We're passing a proper Node.js Buffer from arrayBuffer
        decoded = WavDecoder.decode.sync(nodeBuffer);
      } catch (decodeError) {
        logger.error("Failed to decode WAV file", {
          error: decodeError,
          bufferLength: nodeBuffer.length,
        });
        throw new Error("Failed to decode WAV file.");
      }

      // Get a single channel of sound as shown in example
      const float32Array = decoded.channelData[0];

      // Initialize pitch detection exactly as shown in example
      // eslint-disable-next-line new-cap
      const detectPitch = Pitchfinder.YIN();

      // Get frequencies with timing information
      logger.info("Detecting pitches");
      const frequencies = Pitchfinder.frequencies(detectPitch, float32Array, {
        tempo: 120,
        quantization: 4,
      });

      logger.info("Pitch detection complete", {
        numberOfFrequencies: frequencies.length,
      });

      return {
        success: true,
        message: "Pitch detection completed",
        frequencies: frequencies,
        sampleRate: decoded.sampleRate,
        duration: float32Array.length / decoded.sampleRate,
      };
    } catch (error: unknown) {
      if (error instanceof Error) {
        logger.error("Error in generateTabFromAudio", {
          error: error.message,
          stack: error.stack,
        });
        throw new Error(error.message);
      }
      throw new Error("An unknown error occurred");
    }
  }
);
