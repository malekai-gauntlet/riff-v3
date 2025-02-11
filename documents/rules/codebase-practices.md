# Codebase Best Practices for Riff

This document outlines the coding guidelines, folder structure, file naming conventions, and additional rules to maintain a clean, modular, and scalable AI-first codebase for Riff. By following these practices, we ensure that our code is highly navigable, easy to understand, and consistent across the project, facilitating rapid development and onboarding.

---

## 1. Overview

Riff is built using Flutter with a Clean Architecture that separates presentation, domain, and data layers. The project integrates with Firebase services (Authentication, Firestore, Storage, Cloud Functions) and leverages advanced state management (StateNotifier + Riverpod with Freezed) along with AI-powered content tutorials (OpenAI). All files should be well-documented and not exceed 250 lines to maintain readability and simplicity.

---

## 2. Folder Structure

Organize the source code into clearly separated folders according to their responsibilities. Here is an example file tree demonstrating our ideal structure:

Use @project-overview.md to create a document called `user-flow.md`, which should define the user journey through different segments of the map (i.e. Auth, home feed, tutorials, etc). 

The user journey should take into account the different features the app has & how they are connected to one-another. This document will later serve as a guide for building out our project architecture and UI elements.

Please also reference the codebase to see what we've already built to define the user journey.

Provide the file in markdown format.

No code block found
Use @project-overview.md  and @user-flow.md  to make recommendations for our stack. I'm already using flutter and firebase fyi.

For each anticipated part of our stack, propose and describe an industry standard and a popular alternative, as well as a list of 1 or more other options. 

Put this in a markdown file called `tech-stack-options.md`.

No code block found
thanks, I'm going with this stack:

framework: flutter
auth: firebase
db: firestore
cloud storage for video content: firebase
video playback: flutter's video_player
state management: statenotifier + riverpod (with Freezed)
analytics: firebase analytics
cloud functions: firebase cloud functions
CI/CD: github, vercel
ai powered content tutorials: OpenAI

if these options look good, please clean @tech-stack.md to include these options as they make up my tech stack. please also look through my codebase to lmk if any inconsistencies or if I'm missing anything that should be added to my tech stack


.
Use @tech-stack.md  to create a document called `tech-stack-rules.md`.
This file should cover all best-practices, limitations, and conventions for using the selected technologies.
It should be thorough, and include important considerations and common pitfalls for each technology.

Provide the file in markdown format.

.
As you know from my codebase, I want my project to be mobile-first, responsive, animated, super fast clean functionality on a PWA, super smooth. We need to define the visual and interaction guidelines for building components (including accessibility and design principles), as well as any tie-ins with the tech stack (consider our backend, for example).

Also, I have decided I want my theme to be - as you know - basically as similar to tiktok's designs as possible.

Use @user-flow.md , @tech-stack.md  , and @tech-stack-rules.md  to put together two new files, called `ui-rules.md` and `theme-rules.md`. Please references the styles in my codebase as necessary too for this documentation — I want this to be consistent so it makes building future features even faster.

.
.
We need to define our overall project's folder structure, file naming conventions, and any other rules we need to follow.

We are building an AI-first codebase, which means it needs to be modular, scalable, and easy to understand. The file structure should be highly navigable, and the code should be well-organized and easy to read.

All files should have an explanation of their contents at the top, and all functions should have proper commentation of their purpose and parameters (Dart Doc, etc, whatever is appropriate).
To maintain readability by Cursor's AI tools, files should not exceed 250 lines.

Use @tech-stack.md  , @tech-stack-rules.md@ui-rules.md to put together a new file called `codebase-best-practices.md`. This document should also include a file tree demonstrating the proper separation of concerns given our project's expected structure.

Riff is built using Flutter with a Clean Architecture that separates presentation, domain, and data layers. The project integrates with Firebase services (Authentication, Firestore, Storage, Cloud Functions) and leverages advanced state management (StateNotifier + Riverpod with Freezed) along with AI-powered content tutorials (OpenAI). All files should be well-documented and not exceed 250 lines to maintain readability and simplicity.
lib/
└── src/
├── presentation/ // UI-related code
│ ├── screens/ // Full-screen page widgets
│ │ ├── login_screen.dart // Screen for user authentication (login/signup)
│ │ ├── feed_screen.dart // Home feed displaying video content
│ │ └── tutorial_screen.dart // Screen for video tutorials
│ └── widgets/ // Reusable UI components
│ ├── video_card.dart // Widget displaying video thumbnails and metadata
│ └── navigation_bar.dart // Persistent bottom navigation bar
├── domain/ // Business logic and core models
│ ├── models/ // Immutable data models (using Freezed)
│ │ ├── video.dart // Video data model
│ │ └── user.dart // User data model
│ └── usecases/ // Business use cases and logic
│ └── fetch_videos.dart // Use case for retrieving video feeds
└── data/ // Data layer for external integrations
├── repositories/ // Repository implementations (repository pattern)
│ └── video_repository.dart // Interactions with video data
└── services/ // Services for backend integration
├── firebase_auth_service.dart // Firebase Authentication integration
└── firestore_service.dart // Firestore and real-time database access
assets/
├── images/ // Static images for UI elements
└── videos/ // Cached or downloaded video assets
test/
├── unit_tests/ // Unit tests for core logic and models
└── widget_tests/ // Widget tests for UI components


---

## 3. File Naming Conventions

- **File Names:** Use **snake_case** for all file names (e.g., `login_screen.dart`, `video_card.dart`).
- **Class & Variable Names:**  
  - Use **PascalCase** for classes (e.g., `LoginScreen`, `VideoCard`).
  - Use **camelCase** for variables and function names.
- **Data Models & Utilities:**  
  - Suffix model files with `_model.dart` only if many similar models exist; otherwise, keep names succinct.
  - Use descriptive names for helper functions, utilities, and service classes.

---

## 4. Documentation & Commenting

- **File Headers:**  
  Every file must start with a header block comment that describes:
  - The file's purpose.
  - A brief explanation of its contents.
  - Any important setup instructions.
  
  Example:
  ```dart
  // login_screen.dart
  //
  // This file contains the LoginScreen widget which is responsible for
  // rendering the user login and sign-up interface. It includes form fields,
  // validation, and interaction with Firebase Authentication.
  ```

- **Function Documentation:**  
  All functions and methods must have documentation comments (using DartDoc syntax) explaining:
  - The purpose of the function.
  - Descriptions of its parameters and return value.
  
  Example:
  ```dart
  /// Attempts to sign in a user using the provided [email] and [password].
  /// 
  /// Returns a [User] object on successful sign-in, or throws an exception
  /// if the credentials are invalid or the network call fails.
  Future<User> signInWithEmail(String email, String password) async {
    // Function implementation here...
  }
  ```

- **Inline Comments:**  
  Use inline comments sparingly to clarify complex logic or critical operations, ensuring that the code remains readable for future maintenance.

---

## 5. Code Organization & Readability

- **Modularity:**  
  - Each file should not exceed 250 lines. If a file grows beyond this limit, break it into smaller components or separate logic into additional helper files.
  - Maintain clear separation between business logic (use cases, services) and UI code.

- **State Management:**  
  - Leverage StateNotifier and Riverpod with Freezed to manage application state without mixing UI and business logic.
  - Ensure that state controllers and providers have proper lifecycle management to avoid memory leaks.

- **Performance & Optimization:**  
  - Use `const` constructors where appropriate to reduce unnecessary widget rebuilds.
  - Optimize for responsiveness using Flutter's layout and animation capabilities as specified in our UI rules.

- **Consistent Style:**  
  - Follow Dart and Flutter style guidelines using linters and formatters.
  - Code should be structured to facilitate easy testing and debugging.

---

## 6. Additional Coding Conventions

- **Separation of Concerns:**  
  - Clearly divide code into presentation (UI), domain (business logic), and data (external services) layers.
  - Avoid cross-cutting concerns; each module should have a single responsibility.

- **Error Handling:**  
  - Implement robust error handling, especially for asynchronous calls and external integrations.
  - Log errors appropriately using Firebase Analytics and Crashlytics for subscription tracking.

- **Version Control & CI/CD:**  
  - Adhere to established git branching strategies. Use clear, concise commit messages.
  - Automatically run tests and style checks using GitHub Actions to maintain code quality.

---

By following these codebase best practices, the Riff project will remain modular, scalable, and easy to maintain. Every file and function is designed to be self-explanatory through proper documentation and organization, ensuring that our AI-first codebase is accessible to all team members and future contributors.
