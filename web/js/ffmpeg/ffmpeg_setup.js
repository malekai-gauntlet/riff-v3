/**
 * FFmpeg Setup and Initialization Module
 * 
 * This file handles the setup and initialization of FFmpeg for audio extraction in the browser.
 * It provides two main functions:
 * 1. initFFmpeg(): Initializes the FFmpeg instance
 * 2. extractAudio(): Extracts audio from a video file
 * 
 * The initialization process:
 * 1. Load FFmpeg modules from CDN
 * 2. Create FFmpeg instance
 * 3. Load FFmpeg core
 * 4. Make functions available to Flutter
 */

// Global FFmpeg instance
let ffmpeg = null;

// Debug logging function with timestamp
function debugLog(message, isError = false) {
    const timestamp = new Date().toISOString();
    const prefix = `[FFmpeg Setup ${timestamp}]`;
    
    if (isError) {
        console.error(`${prefix} ❌ ${message}`);
    } else {
        console.log(`${prefix} ℹ️ ${message}`);
    }
}

/**
 * Initializes the FFmpeg instance.
 * This function should be called before any FFmpeg operations.
 * 
 * Returns:
 * - true: if initialization is successful
 * - false: if FFmpeg is already initialized
 * 
 * Throws:
 * - Error: if initialization fails
 */
async function initFFmpeg() {
    try {
        debugLog('Starting FFmpeg initialization process...');
        
        if (ffmpeg) {
            debugLog('FFmpeg already initialized, skipping...');
            return false;
        }

        debugLog('Checking if FFmpeg modules are available in window...');
        if (!window.FFmpeg) {
            debugLog('FFmpeg not found in window object, attempting to load from CDN...', true);
        }

        // Load FFmpeg modules
        debugLog('Loading FFmpeg core module...');
        const ffmpegModule = await import('https://unpkg.com/@ffmpeg/ffmpeg@0.12.7/dist/umd/ffmpeg.js');
        debugLog('FFmpeg core module loaded successfully');

        debugLog('Loading FFmpeg utilities module...');
        const utilModule = await import('https://unpkg.com/@ffmpeg/util@0.12.1/dist/umd/util.js');
        debugLog('FFmpeg utilities module loaded successfully');

        // Create FFmpeg instance
        debugLog('Creating new FFmpeg instance...');
        ffmpeg = new ffmpegModule.FFmpeg();
        
        // Load FFmpeg core
        debugLog('Loading FFmpeg core...');
        await ffmpeg.load();
        debugLog('✅ FFmpeg core loaded successfully!');
        
        return true;
    } catch (error) {
        debugLog(`FFmpeg initialization failed: ${error.message}`, true);
        debugLog(`Error stack: ${error.stack}`, true);
        throw error;
    }
}

/**
 * Extracts audio from a video file.
 * 
 * Parameters:
 * - videoArrayBuffer: ArrayBuffer containing the video data
 * 
 * Returns:
 * - ArrayBuffer containing the extracted audio data
 * 
 * Process:
 * 1. Initialize FFmpeg if not already initialized
 * 2. Write video data to FFmpeg's virtual filesystem
 * 3. Execute FFmpeg command to extract audio
 * 4. Read the output audio file
 * 5. Clean up temporary files
 */
async function extractAudio(videoArrayBuffer) {
    try {
        debugLog('Starting audio extraction process...');
        
        // Ensure FFmpeg is initialized
        debugLog('Checking FFmpeg initialization...');
        if (!ffmpeg) {
            debugLog('FFmpeg not initialized, initializing now...');
            await initFFmpeg();
        }

        // Write video file to FFmpeg's filesystem
        debugLog('Writing video file to FFmpeg filesystem...');
        await ffmpeg.writeFile('input.mp4', new Uint8Array(videoArrayBuffer));
        debugLog('Video file written successfully');

        // Extract audio using FFmpeg command
        debugLog('Executing FFmpeg command for audio extraction...');
        await ffmpeg.exec([
            '-i', 'input.mp4',    // Input video file
            '-vn',                // No video
            '-acodec', 'libmp3lame', // Use MP3 codec
            '-q:a', '2',          // High quality
            'output.mp3'          // Output audio file
        ]);
        debugLog('FFmpeg command executed successfully');

        // Read the output file
        debugLog('Reading extracted audio file...');
        const data = await ffmpeg.readFile('output.mp3');
        debugLog('Audio file read successfully');

        // Clean up
        debugLog('Cleaning up temporary files...');
        await ffmpeg.deleteFile('input.mp4');
        await ffmpeg.deleteFile('output.mp3');
        debugLog('Temporary files cleaned up');

        debugLog('✅ Audio extraction completed successfully!');
        return data.buffer;
    } catch (error) {
        debugLog(`Audio extraction failed: ${error.message}`, true);
        debugLog(`Error stack: ${error.stack}`, true);
        throw error;
    }
}

// Make functions available to Flutter
debugLog('Making FFmpeg functions available to Flutter...');
window.extractAudioFromVideo = extractAudio;
window.initializeFFmpeg = initFFmpeg;

// Log successful script load
debugLog('✅ FFmpeg setup script loaded and initialized successfully!'); 