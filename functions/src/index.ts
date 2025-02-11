/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

import {onCall, HttpsOptions} from "firebase-functions/v2/https";
import * as logger from "firebase-functions/logger";
import * as admin from "firebase-admin";

// Initialize Firebase Admin
admin.initializeApp();

// Start writing functions
// https://firebase.google.com/docs/functions/typescript

export const generateTabFromAudio = onCall({
  enforceAppCheck: false, // disable app check
  allowInvalidAppCheckToken: true, // allow invalid tokens
} as HttpsOptions, async (request) => {
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
      throw new Error("MP3 URL not found in video document");
    }

    // Log the MP3 URL for verification
    logger.info("Found MP3 URL", {mp3url: videoData.mp3url});

    return {
      success: true,
      message: "MP3 URL found successfully",
      mp3url: videoData.mp3url,
    };
  } catch (error: unknown) {
    if (error instanceof Error) {
      logger.error("Error in generateTabFromAudio", error);
      throw new Error(error.message);
    }
    throw new Error("An unknown error occurred");
  }
});
