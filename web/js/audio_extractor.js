// Global variables for MediaRecorder
let mediaRecorder = null;
let recordedChunks = [];

// Log when script loads
console.log('Audio extractor script loaded');

/**
 * Starts recording audio from the video element
 * @param {string} videoUrl - URL of the video to extract audio from
 */
function startRecordingAudio(videoUrl) {
  console.log('startRecordingAudio called with:', videoUrl);
  const videoEl = document.getElementById('myVideo');
  if (!videoEl) {
    console.error("Video element not found!");
    return false;
  }

  try {
    // Set the video source and load it
    videoEl.src = videoUrl;
    videoEl.load();

    // Wait for the video to be loaded before starting recording
    videoEl.onloadedmetadata = () => {
      try {
        const stream = videoEl.captureStream();
        recordedChunks = [];

        mediaRecorder = new MediaRecorder(stream, { mimeType: 'audio/webm' });

        mediaRecorder.ondataavailable = (e) => {
          if (e.data.size > 0) {
            recordedChunks.push(e.data);
          }
        };

        mediaRecorder.onstart = () => {
          console.log("MediaRecorder started");
          videoEl.play(); // Start playing the video
        };
        
        mediaRecorder.onstop = () => {
          console.log("MediaRecorder stopped");
          videoEl.pause(); // Pause the video
          videoEl.currentTime = 0; // Reset video position
        };

        mediaRecorder.start();
        return true;
      } catch (err) {
        console.error("Error capturing audio from video:", err);
        return false;
      }
    };

    videoEl.onerror = (e) => {
      console.error("Error loading video:", e);
      return false;
    };

    return true; // Return true to indicate we started the loading process
  } catch (err) {
    console.error("Error setting up video:", err);
    return false;
  }
}

/**
 * Stops recording and returns the audio URL
 */
function stopRecordingAudio() {
  return new Promise((resolve, reject) => {
    if (!mediaRecorder) {
      reject("No active MediaRecorder");
      return;
    }

    mediaRecorder.onstop = () => {
      try {
        const audioBlob = new Blob(recordedChunks, { type: 'audio/webm' });
        const audioUrl = URL.createObjectURL(audioBlob);
        
        // Clean up
        mediaRecorder = null;
        recordedChunks = [];
        
        console.log("Recording stopped, created URL:", audioUrl);
        resolve(audioUrl);
      } catch (err) {
        reject(err);
      }
    };

    mediaRecorder.stop();
  });
}

// Make functions available to Flutter - with verification
try {
  window.startRecordingAudio = startRecordingAudio;
  window.stopRecordingAudio = stopRecordingAudio;
  console.log('Audio extraction functions attached to window successfully');
} catch (error) {
  console.error('Failed to attach functions to window:', error);
} 