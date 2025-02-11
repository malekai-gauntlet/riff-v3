Product Requirements Document (PRD)

Project Overview

Our TikTok for guitar app is a short-video platform for guitarists to discover, learn, and save songs with AI-powered tutorials. It enables users to engage with high-quality guitar content while tracking their progress and receiving personalized recommendations.

User Roles & Core Workflows
	1.	Consumer: Discover, watch, and save guitar videos with linked tutorials.
	2.	Consumer: Like, comment, and track progress on videos.
	3.	Consumer: Receive personalized video and tutorial recommendations.
	4.	Consumer: Access saved videos and playlists for future learning.
	5.	Creator: Upload videos with metadata (title, description, tags).
	6.	Creator: Link uploaded videos to tutorials and track engagement analytics.
	7.	Admin: Moderate videos, users, and comments to ensure platform compliance.

Technical Foundation

Data Models
	1.	User
	•	Fields: userId, username, email, profilePictureUrl, role, preferences, createdAt.
	•	Relationships: Interacts with videos, comments, progress, and notifications.
	2.	Video
	•	Fields: videoId, title, description, videoUrl, thumbnailUrl, creatorId, createdAt, tags, likesCount, viewsCount.
	•	Relationships: Linked to tutorials, comments, likes, and user progress.
	3.	Tutorial
	•	Fields: tutorialId, videoId, steps, AIGenerated, createdAt.
	4.	Comment
	•	Fields: commentId, userId, videoId, text, createdAt.
	5.	SavedContent
	•	Fields: savedContentId, userId, videoId, savedAt.
	6.	Progress
	•	Fields: progressId, userId, videoId, progressPercentage, lastWatchedTimestamp.
	7.	Notification
	•	Fields: notificationId, userId, type, content, createdAt.

API Endpoints
	1.	POST /auth/signup – Register a new user.
	2.	POST /auth/login – Authenticate and retrieve access token.
	3.	GET /videos/feed – Fetch personalized video feed.
	4.	GET /videos/{videoId} – Retrieve video details and associated tutorial.
	5.	POST /videos/{videoId}/like – Like or unlike a video.
	6.	POST /videos/{videoId}/comments – Add a comment to a video.
	7.	GET /users/{userId}/saved – Retrieve saved content for the user.
	8.	POST /users/{userId}/saved – Save a video to the user’s playlist.
	9.	POST /progress/update – Update video progress data for a user.
	10.	GET /notifications – Fetch notifications for the user.

Key Components
	1.	Frontend – Flutter-based mobile app for Android and iOS.
	2.	Backend – Firebase services for authentication, storage, and real-time database management.
	3.	Storage – Firebase Cloud Storage for video and thumbnail assets.
	4.	AI Services – Firebase Cloud Functions for AI tutorial generation and personalized recommendations.
	5.	Notifications – Firebase Cloud Messaging for real-time updates.
	6.	Security – Firebase Auth and Firestore rules to enforce access control.

MVP Launch Requirements
	1.	User Authentication: Enable secure sign-up, login, and role assignment via Firebase Auth.
	2.	Video Feed: Provide a scrollable, personalized video feed powered by Firestore and AI.
	3.	Video Playback: Support video streaming with core controls (play, pause, skip).
	4.	Tutorial Integration: Link videos to AI-generated or creator-uploaded tutorials.
	5.	User Interaction: Enable liking, commenting, and saving videos in real-time.
	6.	Progress Tracking: Track and display user progress on videos.
	7.	Content Upload: Allow creators to upload videos with metadata.
	8.	Push Notifications: Notify users of new comments, likes, and tutorial recommendations.
	9.	Search and Discovery: Implement a search feature with filters for genres, difficulty, and techniques.
	10.	Admin Moderation: Provide tools to manage users, videos, and comments.

This PRD provides clear, actionable steps for designing, building, and launching the MVP. Let me know how you’d like to proceed!
