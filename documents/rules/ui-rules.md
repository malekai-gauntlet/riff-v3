# UI Rules for Riff

This document outlines the visual and interaction guidelines for building UI components in the Riff application. Our focus is to ensure a mobile-first, responsive design that is animated, fast, and consistent across both native mobile platforms and our PWA. These guidelines also tie into our tech stack, helping to maintain clean functionality and a cohesive user experience.

---

## 1. Design Principles

- **Mobile-First & Responsive:**  
  - Prioritize mobile user experience while ensuring responsiveness on larger screens using Flutter's responsive design tools (e.g., MediaQuery, LayoutBuilder).  
  - Design for touch interactions with scalable UI elements.

- **Clean Architecture & Modularity:**  
  - Follow Clean Architecture by keeping presentation separate from business logic. Keep widget files under 300 lines and extract reusable components to promote maintainability.
  - Use `const` constructors where possible to enhance performance.

- **Performance & Animation:**  
  - Leverage Flutter's animation libraries for smooth transitions and interactive effects that mirror TikTok-style fluidity.  
  - Optimize rebuilds and leverage lazy loading/caching (using packages like `cached_network_image`) to ensure super-fast content loading.

---

## 2. Interaction & Navigation Guidelines

- **Gesture & Touch Feedback:**  
  - Implement TikTok-style gestures such as swipe up/down for video navigation and tap for playback controls.  
  - Provide immediate tactile feedback with animations (e.g., scale changes, fade transitions) to enhance user interaction.

- **Consistent Navigation:**  
  - Use a persistent bottom navigation bar for primary sections (Home Feed, Upload, Profile) to ensure users can easily switch contexts.  
  - Animate transitions between screens (e.g., fade, slide) for smooth user journeys.

- **Loading & Empty States:**  
  - Indicate real-time data updates and loading conditions (e.g., shimmer effects in feeds, progress indicators during network calls).  
  - Use clear, user-friendly error messages and empty state illustrations when data is not available.

---

## 3. Accessibility Guidelines

- **Color Contrast & Legibility:**  
  - Ensure all text has sufficient contrast against its background in accordance with WCAG 2.1 standards.  
  - Use scalable fonts and support dynamic text scaling to aid users with visual impairments.

- **Semantic Widgets & Alt Texts:**  
  - Use semantic UI components (e.g., Material Buttons, Accessible Icons) to support screen readers.  
  - Provide descriptive labels and alternative texts for images and interactive elements.

- **Touch Target Sizes:**  
  - Maintain a minimum touch target size (at least 48x48dp) throughout all interactive components to facilitate ease of use on mobile screens.

---

## 4. Integration with the Tech Stack

- **State Management Tie-Ins:**  
  - Connect UI components to state managed via StateNotifier + Riverpod (with Freezed) to reflect real-time data updates from Firestore and interactions managed by Firebase Cloud Functions.
  
- **Data-Driven Feedback:**  
  - Integrate visual feedback for backend operations such as video likes, comments, and state changes triggered by Firebase Analytics events.  
  - Use loading indicators and error states that directly correspond to asynchronous calls made for authentication, database queries, or media loading.

---

## 5. Component Structure & Best Practices

- **Reusability & Modularity:**  
  - Build small, reusable widgets with well-defined responsibilities to promote consistency across screens (e.g., VideoCard, ProfileHeader, NavigationBar).  
  - Document component interfaces thoroughly to streamline onboarding and future feature development.

- **Animation & Transition Consistency:**  
  - Define a set of standard animation durations and easing curves to be used across transitions and interactive states.
  - Optimize animations to avoid jank and ensure they run smoothly even on lower-end devices.

- **Testing & Debugging:**  
  - Implement comprehensive widget tests and integration tests to validate UI behaviors across multiple devices and scenarios.  
  - Use verbose logging during development to monitor UI state changes and performance metrics.

---

By following these UI rules, our developers can create a fast, engaging, and accessible experience that aligns with our tech stack and overall design vision for Riff. 