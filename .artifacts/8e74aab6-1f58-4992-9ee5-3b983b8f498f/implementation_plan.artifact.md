# Steppy - Fitness Gamification App Implementation Plan

Build a production-ready fitness gamification app with Firebase, Health Connect, and Jetpack Compose.

## User Review Required

> [!IMPORTANT]
> **Firebase Setup**: You will need to create a Firebase project and add the `google-services.json` file to the `app/` directory. I will provide the instructions, but I cannot create the Firebase project for you.
> **Health Connect Capability**: The app requires Health Connect. On Android 14+, it's built-in. On older versions, users need to install the Health Connect app from the Play Store.

## Proposed Changes

### Project Setup & Infrastructure
Initialize the project with modern architecture (MVVM + Clean Architecture) and all necessary dependencies.

#### [MODIFY] [build.gradle.kts](file:///C:/Users/HoneyBadger/AndroidStudioProjects/Steppy/app/build.gradle.kts)
- Add Firebase BOM and dependencies (Auth, Firestore, Messaging).
- Add Health Connect SDK.
- Add Hilt for Dependency Injection.
- Add Navigation Compose.
- Add Vico for charts.
- Add Lifecycle and ViewModel utilities.

#### [NEW] [Package Structure]
Create a modular package structure:
- `data`: Models, Repositories, Health Connect Manager, Firebase Data Sources.
- `domain`: Use cases for business logic (XP calculation, streak logic, etc.).
- `ui`: Screens, Components, Theme, Navigation.
- `di`: Hilt Modules.

---

### Authentication Module
Implement a complete authentication flow using Firebase Auth.

#### [NEW] [Auth Screens](file:///C:/Users/HoneyBadger/AndroidStudioProjects/Steppy/app/src/main/java/com/example/steppy/ui/screens/auth/)
- `LoginScreen`, `SignupScreen`, `ForgotPasswordScreen`.
- `AuthViewModel` to handle user state.

#### [NEW] [AuthRepository](file:///C:/Users/HoneyBadger/AndroidStudioProjects/Steppy/app/src/main/java/com/example/steppy/data/repository/AuthRepository.kt)
- Manage sign-in, sign-up, and session persistence.

---

### Health Connect & Step Sync
Integrate Health Connect for real-time step tracking and background synchronization.

#### [NEW] [HealthConnectManager](file:///C:/Users/HoneyBadger/AndroidStudioProjects/Steppy/app/src/main/java/com/example/steppy/data/health/HealthConnectManager.kt)
- Handle permission requests and availability checks.
- Read aggregated step data (daily, weekly, monthly).

#### [NEW] [StepSyncWorker](file:///C:/Users/HoneyBadger/AndroidStudioProjects/Steppy/app/src/main/java/com/example/steppy/data/health/StepSyncWorker.kt)
- Use WorkManager to periodically sync steps to Firestore in the background.

---

### Core Features & UI
Implement the main dashboard and feature screens.

#### [NEW] [Dashboard](file:///C:/Users/HoneyBadger/AndroidStudioProjects/Steppy/app/src/main/java/com/example/steppy/ui/screens/home/HomeScreen.kt)
- Animated progress ring for today's steps.
- Quick stats (Streak, XP, Level).
- Active challenges summary.

#### [NEW] [Challenges](file:///C:/Users/HoneyBadger/AndroidStudioProjects/Steppy/app/src/main/java/com/example/steppy/ui/screens/challenges/)
- `ChallengeListScreen`: View active and joined challenges.
- `CreateChallengeScreen`: Form to create new challenges.
- `ChallengeDetailScreen`: Progress leaderboard for a specific challenge.

#### [NEW] [Leaderboard & Friends](file:///C:/Users/HoneyBadger/AndroidStudioProjects/Steppy/app/src/main/java/com/example/steppy/ui/screens/social/)
- Global and friend-based leaderboards.
- Friend search and invitation system.

---

### Gamification & Analytics
Implement the logic for XP, levels, achievements, and progress charts.

#### [NEW] [Gamification Engine](file:///C:/Users/HoneyBadger/AndroidStudioProjects/Steppy/domain/usecase/GamificationUseCase.kt)
- Calculate XP based on steps and challenge wins.
- Logic for unlocking badges and maintaining streaks.

#### [NEW] [AnalyticsScreen](file:///C:/Users/HoneyBadger/AndroidStudioProjects/Steppy/app/src/main/java/com/example/steppy/ui/screens/analytics/AnalyticsScreen.kt)
- Interactive charts using Vico for historical step data.

---

### Firebase Security Rules & Schema
Define the Firestore structure and security rules.

#### [NEW] [firestore.rules](file:///C:/Users/HoneyBadger/AndroidStudioProjects/Steppy/firestore.rules)
- Secure user data so only owners can read/write their private profiles.
- Validation rules for XP and step updates.

## Verification Plan

### Automated Tests
- **Unit Tests**:
    - `XPServiceTest`: Verify XP and Level calculations.
    - `StreakServiceTest`: Verify daily streak logic.
    - `ChallengeUseCaseTest`: Test challenge participation logic.
- **UI Tests**:
    - `AuthFlowTest`: Test login and registration UI.
    - `NavigationTest`: Verify bottom navigation and deep links.

### Manual Verification
- Deploy to a physical device with Health Connect installed.
- Verify step synchronization from Google Fit or on-device sensors.
- Test challenge invitations between two different Firebase accounts.
