import 'package:flutter/material.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:ui_web' as ui;
import 'package:flutter/foundation.dart' show kIsWeb;

/// A screen that displays guitar tabs using AlphaTab in an IFrame for web
class StaticTabViewScreen extends StatefulWidget {
  final String title;
  final String artist;

  const StaticTabViewScreen({
    super.key,
    required this.title,
    required this.artist,
  });

  @override
  State<StaticTabViewScreen> createState() => _StaticTabViewScreenState();
}

class _StaticTabViewScreenState extends State<StaticTabViewScreen> {
  final String viewId = 'alphatab-view-${DateTime.now().millisecondsSinceEpoch}';
  
  @override
  void initState() {
    super.initState();
    // Register the view factory
    if (kIsWeb) {
      // This is the web platform (JavaScript)
      ui.platformViewRegistry.registerViewFactory(
        viewId,
        (int viewId) {
          final iframe = html.IFrameElement()
            ..style.border = 'none'
            ..style.height = '100%'
            ..style.width = '100%'
            ..srcdoc = _getHtmlContent();
          
          return iframe;
        },
      );
    }
  }

  String _getHtmlContent() {
    // This returns the complete HTML content with AlphaTab setup
    return '''
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title>AlphaTab Tutorial</title>
    <!-- Replace Font Awesome JS with CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <!-- Add error handling for AlphaTab script -->
    <script>
      window.onerror = function(msg, url, line) {
        console.error('Error: ' + msg + '\\nurl: ' + url + '\\nline: ' + line);
        return false;
      };
    </script>
    <script 
      src="https://cdn.jsdelivr.net/npm/@coderline/alphatab@latest/dist/alphaTab.js" 
      onerror="console.error('Failed to load AlphaTab script')"
    ></script>
    <style type="text/css">
      body {
        font-family: Arial, Helvetica, sans-serif;
        font-size: 12px;
        margin: 0;
        padding: 0;
        background: #fff;
        color: #000;
      }

      .at-wrap {
        width: 100vw;
        height: 100vh;
        margin: 0;
        display: flex;
        flex-direction: column;
        overflow: hidden;
        position: relative;
      }

      .at-content {
        position: relative;
        overflow: hidden;
        flex: 1 1 auto;
        background: #fff;
      }

      /** Sidebar **/
      .at-sidebar {
        position: absolute;
        top: 0;
        left: 0;
        bottom: 0;
        max-width: 70px;
        width: auto;
        display: flex;
        align-content: stretch;
        z-index: 1001;
        overflow: hidden;
        border-right: 1px solid rgba(0, 0, 0, 0.1);
        background: #000000;
      }

      .at-sidebar:hover {
        max-width: 400px;
        transition: max-width 0.2s;
        overflow-y: auto;
      }

      .at-viewport {
        overflow-y: auto;
        position: absolute;
        top: 0;
        left: 70px;
        right: 0;
        bottom: 0;
        padding: 20px;
        background: #fff;
      }

      /** Overlay **/
      .at-overlay {
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        z-index: 1002;
        backdrop-filter: blur(3px);
        background: rgba(255, 255, 255, 0.8);
        display: flex;
        justify-content: center;
        align-items: flex-start;
      }

      .at-overlay-content {
        margin-top: 20px;
        background: #436d9d;
        color: #fff;
        box-shadow: 0px 5px 10px 0px rgba(0, 0, 0, 0.3);
        padding: 20px;
        border-radius: 8px;
      }

      /** Track selector **/
      .at-track {
        display: flex;
        position: relative;
        padding: 5px;
        transition: background 0.2s;
        cursor: pointer;
        color: #fff;
      }

      .at-track:hover {
        background: rgba(255, 255, 255, 0.1);
      }

      .at-track > .at-track-icon,
      .at-track > .at-track-details {
        display: flex;
        flex-direction: column;
        justify-content: center;
      }

      .at-track > .at-track-icon {
        flex-shrink: 0;
        font-size: 32px;
        opacity: 0.5;
        transition: opacity 0.2s;
        width: 64px;
        height: 64px;
        margin-right: 5px;
        align-items: center;
      }

      .at-sidebar-divider {
        height: 1px;
        background: rgba(255, 255, 255, 0.1);
        margin: 10px 5px;
      }

      .at-sidebar-speed {
        display: flex;
        position: relative;
        padding: 5px;
        color: #fff;
        transition: background 0.2s;
      }

      .at-sidebar-speed > div {
        display: flex;
        width: 100%;
        gap: 5px;
      }

      .at-sidebar-speed .speed-icon {
        flex-shrink: 0;
        width: 64px;
        height: 64px;
        display: flex;
        justify-content: center;
        align-items: center;
      }

      .at-sidebar-speed i {
        font-size: 24px;
        opacity: 0.8;
      }

      .at-sidebar-speed select {
        width: auto;
        max-width: 65px;
        background: #333;
        color: #fff;
        border: 1px solid rgba(255, 255, 255, 0.2);
        padding: 5px;
        border-radius: 4px;
        align-self: center;
      }

      .at-track-name {
        font-weight: bold;
        margin-bottom: 5px;
      }

      .at-track:hover > .at-track-icon {
        opacity: 0.8;
      }

      .at-track.active {
        background: rgba(255, 255, 255, 0.05);
      }

      .at-track.active > .at-track-icon {
        color: #4972a1;
        opacity: 1;
      }

      /** Controls **/
      .at-controls {
        flex: 0 0 auto;
        display: flex;
        justify-content: space-between;
        background: #000000;
        color: #fff;
        padding: 8px;
      }

      .at-controls > div {
        display: flex;
        justify-content: flex-start;
        align-items: center;
      }

      .at-controls .btn {
        color: #fff;
        border: none;
        padding: 5px 10px;
        cursor: pointer;
        background: none;
        font-size: 16px;
      }

      .at-controls .btn:hover {
        background: rgba(255, 255, 255, 0.1);
      }

      .at-controls .btn.active {
        background: #4972a1;
      }

      .at-controls .btn.disabled {
        opacity: 0.5;
        cursor: not-allowed;
      }

      .at-song-info {
        margin: 0 8px;
      }

      .at-song-title {
        font-weight: bold;
      }

      .at-song-position {
        margin-left: 8px;
        font-family: monospace;
      }

      .at-speed select,
      .at-zoom select,
      .at-layout select {
        width: fit-content;
        min-width: 70px;
        background: #333;
        color: #fff;
        border: 1px solid rgba(255, 255, 255, 0.2);
        padding: 5px;
        margin-left: 5px;
      }

      /** Cursors and Highlights **/
      .at-cursor-bar {
        background: rgba(255, 242, 0, 0.25);
      }

      .at-selection div {
        background: rgba(64, 64, 255, 0.1);
      }

      .at-cursor-beat {
        background: rgba(64, 64, 255, 0.75);
        width: 3px;
      }

      .at-highlight * {
        fill: #0078ff;
        stroke: #0078ff;
      }

      /* Update the main tab rendering area */
      .at-main {
        color: #000;
        background: #fff;
      }

      /* Make sure SVG elements are black */
      .at-main svg text,
      .at-main svg path,
      .at-main svg rect {
        fill: #000;
        stroke: #000;
      }
    </style>
</head>
<body>
    <div class="at-wrap">
      <div class="at-overlay">
        <div class="at-overlay-content">
          Loading music sheet...
        </div>
      </div>
      <div class="at-content">
        <div class="at-sidebar">
          <div class="at-sidebar-content">
            <div class="at-track-list"></div>
            <div class="at-sidebar-divider"></div>
            <div class="at-sidebar-speed">
              <div>
                <div class="speed-icon">
                  <i class="fas fa-tachometer-alt"></i>
                </div>
                <select class="at-speed-select">
                  <option value="0.25">25%</option>
                  <option value="0.5">50%</option>
                  <option value="0.75">75%</option>
                  <option value="0.9">90%</option>
                  <option value="1" selected>100%</option>
                  <option value="1.1">110%</option>
                  <option value="1.25">125%</option>
                  <option value="1.5">150%</option>
                  <option value="2">200%</option>
                </select>
              </div>
            </div>
          </div>
        </div>
        <div class="at-viewport">
          <div class="at-main"></div>
        </div>
      </div>
      <div class="at-controls">
        <div class="at-controls-left">
          <a class="btn at-player-stop disabled">
            <i class="fas fa-step-backward"></i>
          </a>
          <a class="btn at-player-play-pause disabled">
            <i class="fas fa-play"></i>
          </a>
          <span class="at-player-progress">0%</span>
          <div class="at-song-info">
            <span class="at-song-title"></span> -
            <span class="at-song-artist"></span>
          </div>
          <div class="at-song-position">00:00 / 00:00</div>
        </div>
        <div class="at-controls-right">

          <!-- Commenting out zoom control
          <div class="at-zoom">
            <i class="fas fa-search"></i>
            <select>
              <option value="25">25%</option>
              <option value="50">50%</option>
              <option value="75">75%</option>
              <option value="90">90%</option>
              <option value="100" selected>100%</option>
              <option value="110">110%</option>
              <option value="125">125%</option>
              <option value="150">150%</option>
              <option value="200">200%</option>
            </select>
          </div>
          -->
          <div class="at-layout">
            <select>
              <option value="horizontal">Horizontal</option>
              <option value="page" selected>Page</option>
            </select>
          </div>
        </div>
      </div>
    </div>

    <template id="at-track-template">
      <div class="at-track">
        <div class="at-track-icon">
          <i class="fas fa-guitar"></i>
        </div>
        <div class="at-track-details">
          <div class="at-track-name"></div>
        </div>
      </div>
    </template>

    <script type="text/javascript">
      // load elements
      const wrapper = document.querySelector(".at-wrap");
      const main = wrapper.querySelector(".at-main");

      // initialize alphatab
      const settings = {
        file: "https://www.alphatab.net/files/canon.gp",
        player: {
          enablePlayer: true,
          soundFont: "https://cdn.jsdelivr.net/npm/@coderline/alphatab@latest/dist/soundfont/sonivox.sf2",
          scrollElement: wrapper.querySelector('.at-viewport')
        },
      };
      const api = new alphaTab.AlphaTabApi(main, settings);

      // overlay logic
      const overlay = wrapper.querySelector(".at-overlay");
      api.renderStarted.on(() => {
        overlay.style.display = "flex";
      });
      api.renderFinished.on(() => {
        overlay.style.display = "none";
      });

      // track selector
      function createTrackItem(track) {
        const trackItem = document
          .querySelector("#at-track-template")
          .content.cloneNode(true).firstElementChild;
        trackItem.querySelector(".at-track-name").innerText = track.name;
        
        // Set appropriate icon based on instrument name
        const iconElement = trackItem.querySelector(".at-track-icon i");
        const trackName = track.name.toLowerCase();
        if (trackName.includes('drum') || trackName.includes('kit')) {
          iconElement.className = 'fas fa-drum';
        } else if (trackName.includes('cello')) {
          // Using string instrument icon for cello
          iconElement.className = 'fas fa-scroll';  // Scroll-like shape similar to cello
        } else if (trackName.includes('violin')) {
          // Using string instrument icon for violin
          iconElement.className = 'fas fa-scroll';  // Scroll-like shape similar to violin
        } else if (trackName.includes('bass')) {
          iconElement.className = 'fas fa-guitar';  // Bass guitar
        } else if (trackName.includes('piano')) {
          iconElement.className = 'fas fa-music';  // Piano/keyboard
        } else {
          iconElement.className = 'fas fa-guitar';  // Default to guitar
        }
        
        trackItem.track = track;
        trackItem.onclick = (e) => {
          e.stopPropagation();
          api.renderTracks([track]);
        };
        return trackItem;
      }
      const trackList = wrapper.querySelector(".at-track-list");
      api.scoreLoaded.on((score) => {
        // clear items
        trackList.innerHTML = "";
        // generate a track item for all tracks of the score
        score.tracks.forEach((track) => {
          trackList.appendChild(createTrackItem(track));
        });
        // Update song info
        wrapper.querySelector(".at-song-title").innerText = '${widget.title}';
        wrapper.querySelector(".at-song-artist").innerText = '${widget.artist}';
      });
      api.renderStarted.on(() => {
        // collect tracks being rendered
        const tracks = new Map();
        api.tracks.forEach((t) => {
          tracks.set(t.index, t);
        });
        // mark the item as active or not
        const trackItems = trackList.querySelectorAll(".at-track");
        trackItems.forEach((trackItem) => {
          if (tracks.has(trackItem.track.index)) {
            trackItem.classList.add("active");
          } else {
            trackItem.classList.remove("active");
          }
        });
      });

      /** Controls **/
      /* Commenting out count-in handler
      const countIn = wrapper.querySelector('.at-controls .at-count-in');
      countIn.onclick = () => {
        countIn.classList.toggle('active');
        if (countIn.classList.contains('active')) {
          api.countInVolume = 1;
        } else {
          api.countInVolume = 0;
        }
      };
      */
      
      /* Commenting out loop handler
      const loop = wrapper.querySelector(".at-controls .at-loop");
      loop.onclick = () => {
        loop.classList.toggle("active");
        api.isLooping = loop.classList.contains("active");
      };
      */

      /* Commenting out print handler
      wrapper.querySelector(".at-controls .at-print").onclick = () => {
        api.print();
      };
      */

      const layout = wrapper.querySelector(".at-controls .at-layout select");
      layout.onchange = () => {
        switch (layout.value) {
          case "horizontal":
            api.settings.display.layoutMode = alphaTab.LayoutMode.Horizontal;
            break;
          case "page":
            api.settings.display.layoutMode = alphaTab.LayoutMode.Page;
            break;
        }
        api.updateSettings();
        api.render();
      };

      // player loading indicator
      const playerIndicator = wrapper.querySelector(
        ".at-controls .at-player-progress"
      );
      api.soundFontLoad.on((e) => {
        const percentage = Math.floor((e.loaded / e.total) * 100);
        playerIndicator.innerText = percentage + "%";
      });
      api.playerReady.on(() => {
        playerIndicator.style.display = "none";
      });

      // main player controls
      const playPause = wrapper.querySelector(
        ".at-controls .at-player-play-pause"
      );
      const stop = wrapper.querySelector(".at-controls .at-player-stop");
      let hasInitializedVoiceCommands = false;  // Track if we've initialized voice commands

      playPause.onclick = async (e) => {
        if (e.target.classList.contains("disabled")) {
          return;
        }

        // Initialize voice commands on first play button click
        if (!hasInitializedVoiceCommands) {
          console.log('[Voice] Initializing voice commands from play button');
          try {
            // Request microphone permission explicitly
            const stream = await navigator.mediaDevices.getUserMedia({ audio: true });
            stream.getTracks().forEach(track => track.stop());
            
            // Initialize voice commands
            await initializeSpeechRecognition();
            hasInitializedVoiceCommands = true;
          } catch (error) {
            console.error('[Voice] Error initializing from play button:', error);
            // Continue with playback even if voice initialization fails
          }
        }

        // Add this block to unlock audio on iOS PWA
        if (typeof AudioContext !== 'undefined') {
          const audioContext = new AudioContext();
          audioContext.resume();
        }
        api.playPause();
      };
      stop.onclick = (e) => {
        if (e.target.classList.contains("disabled")) {
          return;
        }
        api.stop();
      };
      api.playerReady.on(() => {
        playPause.classList.remove("disabled");
        stop.classList.remove("disabled");
      });
      api.playerStateChanged.on((e) => {
        const icon = playPause.querySelector("i.fas");
        if (e.state === alphaTab.synth.PlayerState.Playing) {
          icon.classList.remove("fa-play");
          icon.classList.add("fa-pause");
        } else {
          icon.classList.remove("fa-pause");
          icon.classList.add("fa-play");
        }
      });

      // song position
      function formatDuration(milliseconds) {
        let seconds = milliseconds / 1000;
        const minutes = (seconds / 60) | 0;
        seconds = (seconds - minutes * 60) | 0;
        return (
          String(minutes).padStart(2, "0") +
          ":" +
          String(seconds).padStart(2, "0")
        );
      }

      const songPosition = wrapper.querySelector(".at-song-position");
      let previousTime = -1;
      api.playerPositionChanged.on((e) => {
        // reduce number of UI updates to second changes.
        const currentSeconds = (e.currentTime / 1000) | 0;
        if (currentSeconds == previousTime) {
          return;
        }

        songPosition.innerText =
          formatDuration(e.currentTime) + " / " + formatDuration(e.endTime);
      });

      // Commenting out zoom control handler
      /*
      const zoom = wrapper.querySelector(".at-controls .at-zoom select");
      zoom.onchange = () => {
        const zoomLevel = parseInt(zoom.value) / 100;
        api.settings.display.scale = zoomLevel;
        api.updateSettings();
        api.render();
      };
      */

      // speed control
      const speed = wrapper.querySelector(".at-sidebar-speed .at-speed-select");
      speed.onchange = () => {
        const speedLevel = parseFloat(speed.value);
        api.playbackSpeed = speedLevel;
      };

      // Voice command setup with mobile PWA support
      let recognition = null;
      let isRecognitionActive = false;
      
      // Function to show status messages to user
      function showVoiceStatus(message, isError = false) {
        console.log('[Voice Status]', message); // Add logging for all status messages
        const statusDiv = document.createElement('div');
        statusDiv.style.position = 'fixed';
        statusDiv.style.bottom = '60px';
        statusDiv.style.left = '50%';
        statusDiv.style.transform = 'translateX(-50%)';
        statusDiv.style.backgroundColor = isError ? '#ff4444' : '#436d9d';
        statusDiv.style.color = 'white';
        statusDiv.style.padding = '8px 16px';
        statusDiv.style.borderRadius = '20px';
        statusDiv.style.zIndex = '9999';
        statusDiv.textContent = message;
        document.body.appendChild(statusDiv);
        setTimeout(() => statusDiv.remove(), 3000);
      }

      // Initialize speech recognition with proper error handling
      async function initializeSpeechRecognition() {
        console.log('[Voice Init] Starting initialization');
        if (!('webkitSpeechRecognition' in window)) {
          console.error('[Voice Init] Speech recognition not supported');
          showVoiceStatus('Voice commands not supported in this browser', true);
          return;
        }

        try {
          console.log('[Voice Init] Requesting microphone permission');
          const stream = await navigator.mediaDevices.getUserMedia({ audio: true });
          stream.getTracks().forEach(track => track.stop());
          console.log('[Voice Init] Microphone permission granted');
          
          recognition = new webkitSpeechRecognition();
          // Make recognition more responsive
          recognition.continuous = false;  // Process commands faster
          recognition.interimResults = true;  // Get faster results
          recognition.maxAlternatives = 1;  // Reduce processing overhead
          
          recognition.onstart = () => {
            console.log('[Voice] Recognition started');
            isRecognitionActive = true;
          };
          
          recognition.onerror = (event) => {
            console.error('[Voice Error]', event.error);
            if (event.error === 'not-allowed') {
              showVoiceStatus('Microphone permission denied', true);
            } else {
              showVoiceStatus('Voice recognition error: ' + event.error, true);
            }
            isRecognitionActive = false;
            // Immediately restart recognition
            if (!isRecognitionActive) recognition.start();
          };
          
          recognition.onend = () => {
            console.log('[Voice] Recognition ended');
            isRecognitionActive = false;
            // Immediately restart recognition
            recognition.start();
          };
          
          recognition.onresult = (event) => {
            // Process interim results for faster response
            const result = event.results[event.results.length - 1];
            if (result.isFinal || result[0].confidence > 0.7) {  // Accept high confidence interim results
              const command = result[0].transcript.toLowerCase().trim();
              console.log('[Voice Command] Received:', command);
              
              // Handle "start over" command regardless of player state
              if (command.includes('start over') || command.includes('restart')) {
                console.log('[Voice] Executing start over');
                api.stop();
                // Add a small delay before playing to ensure the stop command is fully processed
                setTimeout(() => {
                  console.log('[Voice] Auto-playing after start over');
                  api.play();
                  showVoiceStatus('Starting over');
                }, 100);
                return;
              }
              
              // When playing, listen for "pause"
              if (api.playerState === alphaTab.synth.PlayerState.Playing) {
                if (command.includes('pause') || command.includes('stop')) {
                  console.log('[Voice] Executing pause');
                  api.pause();
                  showVoiceStatus('Paused');
                }
              }
              // When not playing, listen for "play"
              else {
                if (command.includes('play') || command.includes('start')) {
                  console.log('[Voice] Executing play');
                  try {
                    api.play();
                    showVoiceStatus('Playing');
                  } catch (error) {
                    console.error('[Voice] Play error:', error);
                  }
                }
              }
            }
          };

          // Add voice command indicator that shows current valid commands
          const controlsRight = wrapper.querySelector('.at-controls-right');
          const voiceIndicator = document.createElement('div');
          voiceIndicator.style.marginLeft = '10px';
          voiceIndicator.style.display = 'flex';
          voiceIndicator.style.alignItems = 'center';
          voiceIndicator.innerHTML = '<i class="fas fa-microphone"></i><span style="margin-left: 5px; font-size: 12px">Say "pause" or "start over"</span>';
          voiceIndicator.title = 'Voice commands enabled';
          controlsRight.appendChild(voiceIndicator);

          // Update the voice indicator based on player state
          api.playerStateChanged.on((e) => {
            const textSpan = voiceIndicator.querySelector('span');
            if (e.state === alphaTab.synth.PlayerState.Playing) {
              textSpan.textContent = 'Say "pause" or "start over"';
            } else {
              textSpan.textContent = 'Say "play" or "start over"';
            }
          });

          // Start recognition immediately
          recognition.start();

          console.log('[Voice Init] Setup complete');
          
        } catch (error) {
          console.error('[Voice Init] Error:', error);
          showVoiceStatus('Error initializing voice commands: ' + error.message, true);
        }
      }

      // Initialize voice commands when player is ready
      api.playerReady.on(() => {
        console.log('[Player] Ready - initializing voice commands');
        initializeSpeechRecognition();
      });
      
      // Handle player state changes
      api.playerStateChanged.on((e) => {
        console.log('[Player] State changed:', e.state);
        if (!recognition) {
          console.log('[Voice] Recognition not initialized, skipping state change handling');
          return;
        }
        
        if (e.state === alphaTab.synth.PlayerState.Playing) {
          if (!isRecognitionActive) {
            console.log('[Voice] Starting recognition due to player state change');
            recognition.start();
          }
        } else {
          console.log('[Voice] Stopping recognition due to player state change');
          recognition.stop();
        }
      });
      
    </script>
</body>
</html>
    ''';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.artist,
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 14,
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: HtmlElementView(viewType: viewId),
    );
  }
}