# User Flow Document for Riff

This document outlines the user journey through the Riff app — our TikTok-inspired platform for guitarists. It details the flow through authentication, home feed, video interactions, tutorial integrations, profile management, and other key features. This guide will help inform our project architecture, UI components, and integration with Firebase services.

---

## 1. Overview

Riff is a niche short-video platform designed for guitarists. Users can discover, learn, and share guitar riffs. The core features include:
- **Authentication & Profile Management:** Sign up, login, update profile info, and view creator profiles.
- **Home Feed:** An infinite scroll feed of guitar videos.
- **Video Interactions:** Upload/creation, liking, commenting, saving, and adjustable playback (including slow-motion for detailed study).
- **Tutorial Integration:** Each video may have linked tutorials (either creator-uploaded or AI-generated) with features like animated fretboards.
- **Explore/Discovery:** Filter videos by difficulty, genre, or technique.
- **Social Engagement:** Following creators, viewing detailed profiles, and connecting with fellow musicians.

The codebase already implements core screens such as `LoginScreen`, `ProfileViewScreen`, `FeedScreen`, and `TutorialScreen`, aligning with the functionalities described.

---

## 2. User Journey

Below is a detailed step-by-step user journey, segmented by the main areas of the application:

### A. Authentication Flow

1. **Welcome & Login/Sign-Up Screen:**
   - **Entry Point:** Users open the app and are prompted with a login screen.
   - **UI Elements:** 
     - **Email/Password Field:** For login credentials.
     - **Sign-Up Toggle:** Allows switching to sign-up mode.
     - **Display Name & Terms of Service:** Additional fields required during sign-up.
   - **Firebase Integration:** 
     - Utilizes `FirebaseAuth` for `createUserWithEmailAndPassword` and `signInWithEmailAndPassword` (see `login_screen.dart`).
     - Post-sign-up includes an update to the user's display name and error handling for validations and Firebase-specific errors.
   - **Navigations:** 
     - Successful authentication transitions to the Home Feed.
     - Error messages guide users if any inputs fail validation.

### B. Home Feed & Video Scrolling

1. **Home Feed Screen:**
   - **Content Display:** The personalized feed displays videos using an infinite scroll pattern.
   - **UI Elements:**
     - **Video Cards:** Each card shows video thumbnails (with caching via `cached_network_image`) and basic metadata.
     - **Bottom Navigation Bar:** Provides access to key sections (feed, upload, profile, etc.) as seen in the `HomePage` widget.
   - **Code Integration:** 
     - The feed is powered by `FeedScreen` with integration of Firebase and Firestore for real-time updates.
     - Code references like `_handlePageChange` in `feed_screen.dart` manage the behavior when a user scrolls through videos.

### C. Video Playback & Interaction Flow

1. **Video Playback:**
   - **User Experience:** Upon tapping a video, users are taken to a detailed playback screen.
   - **UI Elements:**
     - **Video Player:** Handles different playback states (buffering, playing, paused); optimized for performance with caching.
     - **Interactive Controls:** Allow actions like like, comment, save, and playback speed adjustments.
   - **Key Features:**
     - **Slow-Motion Playback:** Enables detailed review of complex guitar riffs.
     - **Real-Time Interactions:** Likes and comments are updated in real-time using Firestore.
   - **Code Integration:**
     - The player state and lifecycle management are handled separately from UI state to ensure smooth transitions and proper resource disposal.

### D. Tutorial Integration Flow

1. **Tutorial Display & Interaction:**
   - **Triggering Tutorials:** When a video is selected, the app checks for an associated tutorial.
   - **UI Elements:**
     - **Tutorial Section:** Displays linked tutorials (either creator-uploaded or AI-generated) with details like title, channel name, view count, and thumbnails.
     - **Animated Fretboard (Future Enhancement):** For AI-generated tutorials to aid learning.
   - **User Actions:**
     - Users can tap on a tutorial to view more details or launch to an external source (e.g., YouTube).
   - **Code References:**
     - `TutorialScreen` manages the display of tutorials.
     - Helper methods from migration files (e.g., `add_tutorial_data.dart`) augment video data with tutorials.
  
### E. Profile & Account Management Flow

1. **Profile Viewing & Editing:**
   - **Profile Screen:**
     - Users can view their profile with details such as display name, username, bio, and saved videos.
     - Components such as `ProfileHeader`, `ProfileStats`, and `ProfileVideoGrid` provide a comprehensive view.
   - **Editing Features:**
     - Users can edit their profile picture, name, and bio via the `EditProfileScreen` (as seen in the profile components).
   - **Firebase Utilization:**
     - Firebase Auth is used for user identification.
     - Firestore rules secure the profile data and ensure that only the authenticated user can modify their info.

### F. Explore & Discovery Flow

1. **Filtering & Searching:**
   - **Discovery Page:**
     - Users can search videos by genre, difficulty, and other filters.
     - This page leverages real-time data from Firestore.
   - **User Interaction:**
     - Filters help users find specific content (e.g., fingerstyle techniques).
     - The integration of AI for personalized recommendations enhances the discovery experience.
   - **Future Enhancements:**
     - Push notifications and analytics (via Firebase Analytics and Cloud Messaging) can be integrated to notify users of new or trending content based on their interests.

### G. Social Interaction Flow

1. **Engagement with Content & Creators:**
   - **Interactions:**
     - Users can like, comment, follow creators, and save videos for later (as outlined in the project overview and implemented partially in the codebase).
   - **UI & Feedback:**
     - Instant in-app notifications and visual feedback (e.g., success message snack bars) enhance engagement.
     - Smooth transitions and animations (used in Login and Profile screens) add to the appealing and responsive UI.
   - **Analytics & Moderation:**
     - Firebase Analytics tracks user engagement.
     - Admin workflows (not fully detailed yet) handle content moderation.

---

## 3. Connecting the Segments

- **Navigation & Transitions:**
  - The app uses a bottom navigation bar (in `HomePage`) to switch between Home Feed, Upload, and Profile, ensuring that each segment is easily accessible.
  - Smooth animations and transitions (e.g., in the login and tutorial screens) improve the user experience and provide visual feedback during navigation.

- **Firebase & Real-Time Data:**
  - All segments communicate with Firebase (Auth, Firestore, Storage, and Cloud Functions) to ensure real-time updates across the app. For instance, when a user likes a video, the change is immediately visible across the home feed and profile sections.
  
- **AI and Personalization:**
  - Leveraging AI for tutorial generation and personalized feeds connects the discovery and educational aspects of the platform. This is built on top of the existing architecture that integrates video playback and Firestore-based content management.

---

## 4. Summary

This user flow represents a high-level guide to the journey a guitarist will experience when using Riff:
- **Authentication:** Secure, user-friendly registration and login.
- **Home Feed:** Seamless browsing of a personalized video feed.
- **Video Playback & Tutorials:** Engaging media consumption, detailed tutorials, and interactive controls.
- **Profile Management & Discovery:** Easy management of user data and exploration of varied content.
- **Social Features:** Community interactions through likes, comments, follows, and saved content.

This document serves as a blueprint for aligning our UI elements, backend integrations, and overall app architecture to ensure a comprehensive and engaging user experience for our MVP.

---
