# Engineering Rules and Conventions (docs/RULES.md)

This document establishes the mandatory engineering rules, architectural constraints, coding standards, and quality gates for the **LocalLink** project.

---

## 1. Flutter & Dart Standards

### 1.1 Language & Formatting
- **Null Safety**: 100% sound null safety. Do not use `!` (force unwrap) unless backed by an explicit preceding assertion or check with an explanatory comment.
- **Formatting**: All files must pass `dart format --line-length=100 .`.
- **Linting**: Follow the standard `flutter_lints` ruleset with zero warnings allowed. No code may be checked in with analyzer warnings suppressed unless specifically justified and documented.
- **File Organization**: Keep files focused. Maximum target size for a single Dart file is 300 lines; files exceeding 400 lines must be reviewed for modular decomposition.

### 1.2 State Management & Dependency Injection
- **Riverpod Only**: Use Riverpod (`flutter_riverpod` with `@riverpod` annotations / `Notifier` / `AsyncNotifier`) as the single state management and dependency injection solution.
- **No Global Singletons**: Do not use `GetIt` or mutable global variables. All dependencies (repositories, databases, services, clock) must be provided via Riverpod `Provider` or `@riverpod`.
- **Provider Granularity**: Providers must be scoped and single-purpose. Do not create monolithic "AppState" or "TrainProvider" classes that handle everything.
- **UI State Modeling**: Every asynchronous UI state must explicitly represent four states:
  1. `Initial`
  2. `Loading`
  3. `Success(data)`
  4. `Error(failure)` or `Empty`

### 1.3 Local Persistence
- **Drift (SQLite)**: All relational train schedules, stations, and routes must be stored in SQLite via Drift.
- **No Database Logic in UI**: Never invoke Drift queries, raw SQL, or transactions directly from Flutter widgets or controllers.
- **Repository Boundary**: Presentation and Domain layers must interact exclusively with Domain Repository interfaces; Drift DAOs must live inside `lib/features/*/data/`.

### 1.4 Widget Architecture
- **Small & Composable**: Split widgets into small, reusable components. A single widget class `build` method should ideally fit within one screen scroll (under 60 lines).
- **Stateless by Default**: Prefer `ConsumerWidget` or `StatelessWidget`. Use `ConsumerStatefulWidget` only when managing ephemeral local UI state (e.g., animation controllers, scroll listeners).
- **Accessibility**: All interactive elements must have semantic labels (`Semantics` or tooltip). Ensure touch targets meet minimum 48x48dp guidelines. Support dynamic font scaling up to 200%.

### 1.5 Code Generation
- Generated files (`*.g.dart`, `*.freezed.dart`, `*.drift.dart`) must never be modified by hand.
- Run build_runner with:
  ```powershell
  dart run build_runner build --delete-conflicting-outputs
  ```
- Commit generated files to ensure build reproducibility.

---

## 2. Architecture & Design Rules

### 2.1 Layer Separation
Follow Clean Architecture with strict inward dependency flow:
```
Presentation ───> Application ───> Domain <─── Infrastructure
```
1. **Domain Layer (`lib/features/*/domain/`)**:
   - Entities and Value Objects (immutable, pure Dart).
   - Domain failure definitions (`Either<Failure, T>` or Result patterns).
   - Repository interfaces and domain service contracts.
   - **Zero dependencies on Flutter UI, Drift, or Firebase.**
2. **Application Layer (`lib/features/*/application/`)**:
   - Use cases and coordinators orchestrating domain logic across repositories.
   - Pure Dart; no direct Flutter UI dependency.
3. **Infrastructure / Data Layer (`lib/features/*/data/` & `lib/core/`):**
   - Implementations of repository interfaces.
   - Drift database, DAOs, and SQLite table definitions.
   - Firebase adapters, location services, notification handlers.
   - JSON parsing, asset loading, serialization.
4. **Presentation Layer (`lib/features/*/presentation/`):**
   - Flutter screens, custom widgets, dialogs.
   - Riverpod `Notifier` / `AsyncNotifier` controllers.
   - Localization formatting.

### 2.2 Offline-First Invariance
- **Zero Network Requirement for Core Journey Planning**:
  - Station search, timetable lookup, fast/slow identification, and transfer route planning must function 100% offline using the local Drift SQLite database.
  - Network failure or lack of internet connectivity must never result in an unhandled crash or locked UI.
- **Decoupled Firebase Integration**:
  - Crowdsourced crowding reports are strictly supplementary. If Firebase is unreachable or fails to respond within a timeout, the UI must continue to display the offline timetable with an indicator: *"Live crowd data unavailable offline"*.

### 2.3 Dependency Policy
- No third-party package may be added without evaluating:
  1. Maintenance status and publisher reputation.
  2. Impact on offline capability and app size.
  3. Platform support (Android-first, iOS-compatible).
- Every newly introduced package must be documented in `docs/DECISIONS.md`.

---

## 3. Code Quality & Error Handling

### 3.1 Error Handling
- **No Swallowed Exceptions**: Never use empty `catch (e) {}` blocks.
- **Typed Failures**: Use strongly typed domain failures (e.g., `DatabaseFailure`, `RouteNotFoundFailure`, `LocationPermissionDeniedFailure`) rather than raw `Exception` strings.
- **User-Facing Error Messages**: Translate technical failures into commuter-friendly, localized error messages.

### 3.2 Privacy & Security
- **No PII Collection**: LocalLink collects no names, phone numbers, or email addresses.
- **Location Ephemerality**: Commuter GPS coordinates used for proximity alerts are evaluated entirely on-device and must NEVER be transmitted to any remote server or Firebase.
- **Crowdsourced Anonymity**: Crowd reports must use random ephemeral session tokens or anonymous Firebase Auth UIDs. No hardware IDs (IMEI, MAC) may be collected.
- **No Hardcoded Secrets**: Firebase API keys must be loaded via secure environment definitions or standard platform configuration (`google-services.json`).

### 3.3 No Placeholders or Shortcuts
- Never leave mock data hardcoded inside production repositories.
- Never place fake "Coming Soon" buttons for acceptance criteria that belong to the current active phase.
- Do not leave empty TODO comments to pass acceptance gates.

---

## 4. Git & Phase Discipline

- **Status Verification**: Always inspect `git status` before making edits.
- **Preserve User Changes**: Do not overwrite or discard files that you did not create.
- **No Unsolicited Commits**: The agent must not commit code unless explicitly requested by the user.
- **Verification Gates**: A phase is NOT complete until all acceptance criteria are verified with:
  ```powershell
  dart format .
  flutter analyze
  flutter test
  ```
