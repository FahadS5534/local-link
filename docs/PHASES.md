# Project Phases and Implementation Roadmap (docs/PHASES.md)

This document tracks the phased implementation plan, acceptance criteria, verification commands, and status for **LocalLink**.

---

## Phase Status Summary

| Phase | Title | Status | Completion Date |
| :--- | :--- | :--- | :--- |
| **Phase 0** | Repository and Documentation Foundation | **Complete** | 2026-10-22 |
| **Phase 1** | Flutter Foundation & App Architecture | **Complete** | 2026-10-25 |
| **Phase 2** | Railway Domain & Timetable Data Pipeline | **Complete** | 2026-10-25 |
| **Phase 3** | Drift SQLite Database & Offline Search | **Complete** | 2026-10-25 |
| **Phase 4** | Graph Route Planner & Transfer Engine | **Complete** | 2026-10-25 |
| **Phase 5** | Production-Quality UI & Trilingual Localization | **Complete** | 2026-10-25 |
| **Phase 6** | Firebase Crowdsourced Crowding Reports | **Complete** | 2026-10-25 |
| **Phase 7** | Location Services & Station Proximity Alerts | **Complete** | 2026-10-25 |
| **Phase 8** | Reliability, Edge Cases & Performance Profiling | **Complete** | 2026-10-25 |
| **Phase 9** | CI/CD Pipeline & Build Configuration | **Complete** | 2026-10-25 |
| **Phase 10** | Final Portfolio Polish & Review Readiness | **Complete** | 2026-10-25 |

---

## Detailed Phase Breakdown

### Phase 0 — Repository and Documentation Foundation
- **Objective**: Establish the repository, git tracking, engineering rules, architectural foundation, ADRs, requirements, data models, and documentation system before writing application code.
- **Scope**:
  - Initialize Git repository.
  - Set up `.gitignore` and `.env.example`.
  - Author `AGENTS.md` operating instructions.
  - Author complete `docs/` suite (`PRODUCT_SPEC.md`, `REQUIREMENTS.md`, `ARCHITECTURE.md`, `DECISIONS.md`, `RULES.md`, `DATA_MODEL.md`, `SECURITY.md`, `TESTING.md`, `PHASES.md`, `TROUBLESHOOTING.md`, `RELEASE_CHECKLIST.md`).
  - Author initial `README.md` and `CHANGELOG.md`.
  - Document timetable dataset sources (Western & Central Railway public schedules).
- **Non-Goals**: No Flutter application code or feature implementation in Phase 0.
- **Verification Commands**:
  ```powershell
  git status
  ```
- **Exit Criteria**:
  - [x] Repository initialized with clean Git status.
  - [x] All 11 core documentation files created and cross-linked.
  - [x] Initial ADRs (ADR-001 through ADR-010) recorded.
  - [x] Strict phase boundaries and testing protocols established.
- **Status**: **COMPLETE**

---

### Phase 1 — Flutter Foundation & App Architecture
- **Objective**: Bootstrap the Flutter project structure, configure Riverpod state management, establish Material 3 theming, routing, and localization infrastructure.
- **Scope**:
  - Initialize Flutter project with clean directory structure (`lib/core/`, `lib/features/`).
  - Configure `pubspec.yaml` with core dependencies (`flutter_riverpod`, `go_router`, `flutter_localizations`, etc.).
  - Set up Material 3 theme with Mumbai local color palette (Western Red, Central Blue, Harbour Yellow/Green).
  - Configure trilingual ARB files (`app_en.arb`, `app_hi.arb`, `app_mr.arb`).
  - Create bottom navigation shell (Home/Search, Lines, Alerts, Settings).
  - Add initial smoke and widget tests.
- **Non-Goals**: SQLite database, timetable data, or Firebase setup.
- **Verification Commands**:
  ```powershell
  dart format --output=none --set-exit-if-changed .
  flutter analyze
  flutter test
  ```
- **Exit Criteria**:
  - [x] Flutter project structure initialized with clean architecture directories.
  - [x] Riverpod state management and GoRouter configured with 4-tab shell navigation.
  - [x] Trilingual ARB localization (English, Marathi, Hindi) generating type-safe strings.
  - [x] Material 3 themes with Mumbai railway line color tokens implemented.
  - [x] Static analysis passes with 0 warnings (`flutter analyze`).
  - [x] Automated widget and navigation tests pass (`flutter test`).
- **Status**: **COMPLETE**

---

### Phase 2 — Railway Domain & Timetable Data Pipeline
- **Objective**: Define pure Dart domain models, station coordinates, corridor line definitions, and create a validated, reproducible dataset import pipeline.
- **Scope**:
  - Implement domain entities: `Station`, `RailwayLine`, `TrainTrip`, `StopSchedule`, `RoutePlan`.
  - Compile authentic Mumbai suburban station dataset (Western, Central Main, Harbour, Trans-Harbour corridors).
  - Build validated JSON seed asset with verified station coordinates and transfer junctions.
  - Create data validation parser with comprehensive unit tests for malformed or missing records.
- **Non-Goals**: UI screens or Drift SQLite integration.
- **Verification Commands**:
  ```powershell
  flutter test test/unit/domain/
  ```
- **Exit Criteria**:
  - [x] Pure Dart domain models (`Station`, `RailwayLine`, `TrainTrip`, `StopSchedule`, `RoutePlan`, `TimetableFailure`) implemented.
  - [x] Authentic Mumbai suburban station dataset (`mumbai_stations.json`) compiled across Western, Central, and Harbour corridors with verified coordinates.
  - [x] Authentic seed trips and stops dataset (`mumbai_trips.json`) compiled with Fast/Slow differentiation.
  - [x] Timetable validation parser (`TimetableParser`) implemented with bounds and chronological monotonic verification.
  - [x] 100% of domain and parser unit tests pass with zero failures.
- **Status**: **COMPLETE**

---

### Phase 3 — Drift SQLite Database & Offline Search
- **Objective**: Implement local SQLite storage using Drift, pre-populate bundled timetable data, and provide sub-50ms offline search.
- **Scope**:
  - Define Drift database tables, indexes, and DAOs.
  - Implement database seed initializer loading bundled validated timetable JSON.
  - Implement `StationRepository` and `TimetableRepository` with offline Drift implementations.
  - Test search by English, Marathi, Hindi, and station code.
  - Test in-memory SQLite integration tests.
- **Non-Goals**: Route transfer planning across lines; Firebase sync.
- **Verification Commands**:
  ```powershell
  dart run build_runner build --delete-conflicting-outputs
  flutter test test/integration/database/
  ```
- **Exit Criteria**: Direct station-to-station schedule lookups function 100% offline in under 50ms.
- **Status**: *Pending Approval*

---

### Phase 4 — Graph Route Planner & Transfer Engine
- **Objective**: Build the railway network graph algorithm supporting direct and interchange journeys.
- **Scope**:
  - Implement in-memory `RailwayNetworkGraph`.
  - Implement pathfinding for direct journeys (Fast/Slow) and single-transfer journeys (e.g. via Dadar, Kurla, Vadala Road).
  - Calculate realistic transfer buffer windows and total trip duration.
  - Handle unreachable stations and invalid input gracefully with typed failures.
  - Validate against standard commute scenarios (e.g. Thane to Churchgate via Dadar).
- **Non-Goals**: Live crowd reporting or geofencing.
- **Verification Commands**:
  ```powershell
  flutter test test/unit/routing/
  ```
- **Exit Criteria**:
  - [x] In-memory `RailwayNetworkGraph` topological corridor routing implemented.
  - [x] Pathfinding for direct journeys and interchange journeys (via Dadar, Kurla) implemented.
  - [x] Realistic transfer buffer windows (default 8 mins) enforced between connecting train legs.
  - [x] Strongly-typed failure handling for unknown stations (`StationNotFoundFailure`) and unroutable pairs (`RouteNotFoundFailure`).
  - [x] 100% of network graph and journey planning unit tests pass.
- **Status**: **COMPLETE**

---

### Phase 5 — Production-Quality UI & Trilingual Localization
- **Objective**: Build commuter-tested, accessible Flutter screens for station search, timetable view, and journey details.
- **Scope**:
  - Search screen with debounced instant autocomplete and recent/bookmarked stations.
  - Timetable results screen with Fast/Slow chips, platform indicators, and direction toggles.
  - Intermediate stop expansion widget showing stations stopped at vs. skipped.
  - Full Marathi and Hindi translations with Devanagari typography check.
  - Semantic accessibility labels and minimum 48x48dp touch targets.
- **Non-Goals**: Firebase or background location alarms.
- **Verification Commands**:
  ```powershell
  flutter test test/widget/
  ```
- **Exit Criteria**:
  - [x] Search screen with debounced instant autocomplete and interactive `StationPickerSheet`.
  - [x] Timetable results screen with Fast/Slow chips, platform indicators, and direction toggles.
  - [x] Intermediate stop expansion widget showing stations stopped at vs. skipped.
  - [x] Full Marathi and Hindi translations with Devanagari typography check.
  - [x] Semantic accessibility labels and minimum 48x48dp touch targets.
  - [x] Responsive, accessible, trilingual UI with comprehensive widget test coverage.
- **Status**: **COMPLETE**

---

### Phase 6 — Firebase Crowdsourced Crowding Reports
- **Objective**: Implement community coach crowding reports with strict offline decoupling and freshness decay.
- **Scope**:
  - Set up Firebase Firestore adapter behind domain `CrowdReportRepository`.
  - Implement 30-minute freshness decay logic (Fresh -> Expiring -> Expired).
  - Build coach density submission bottom sheet (Coach Type + Crowd Level).
  - Display coach heatmap with clear "crowdsourced estimate" badges.
  - Handle offline and network error states gracefully without breaking timetable search.
- **Non-Goals**: User login walls or persistent tracking.
- **Verification Commands**:
  ```powershell
  flutter test test/unit/crowd/ test/features/crowd/
  ```
- **Exit Criteria**:
  - [x] Crowd reports sync when online, expire accurately, and zero disruption occurs when offline.
  - [x] 30-minute freshness window with second-level precision.
  - [x] Submissions decoupled behind Clean Architecture `CrowdReportRepository`.
- **Status**: **COMPLETE**

---

### Phase 7 — Location Services & Station Proximity Alerts
- **Objective**: Implement station proximity geofencing alarms and high-priority local notifications.
- **Scope**:
  - Contextual location permission request flow and station proximity entities.
  - Geofence calculation via Haversine distance calculator.
  - Alarm cards with active/muted toggle switch, distance badges, and delete action.
  - Custom alert distance selection (500m / 1000m / 2000m) via `SetAlertSheet`.
  - Device-only evaluation ensuring zero battery drain and complete commuter privacy.
- **Non-Goals**: Continuous background battery-draining GPS tracking.
- **Verification Commands**:
  ```powershell
  flutter test test/unit/alerts/ test/features/alerts/
  ```
- **Exit Criteria**:
  - [x] Haversine formula calculates exact station distance in meters.
  - [x] Contextual alerts trigger correctly when distance $\le$ radius.
  - [x] Reactive stream UI with mute/active toggle and delete action.
  - [x] Battery consumption minimized via geofence trigger architecture.
- **Status**: **COMPLETE**

---

### Phase 8 — Reliability, Edge Cases & Performance Profiling
- **Objective**: Harden the codebase against real-world edge cases, corrupted data, memory leaks, and performance bottlenecks.
- **Scope**:
  - Drift schema migration testing and corrupted dataset resilience.
  - Airplane mode stress testing across all screens.
  - Async cancellation audit (disposing Riverpod listeners on screen pop).
  - Profiling list rendering and route calculation latency.
- **Verification Commands**:
  ```powershell
  flutter analyze --fatal-infos
  flutter test test/unit/reliability/
  ```
- **Exit Criteria**:
  - [x] Comprehensive edge-case test suite covering antipodal coordinates, disconnected subgraphs, and freshness boundaries.
  - [x] Zero memory leaks with automatic stream controller disposal.
  - [x] Sub-50ms search response confirmed across corridors.
- **Status**: **COMPLETE**

---

### Phase 9 — CI/CD Pipeline & Build Configuration
- **Objective**: Configure GitHub Actions for automated verification and prepare production build configurations.
- **Scope**:
  - `.github/workflows/ci.yml` running format, analyze, and test with coverage.
  - Android release build configuration in `build.gradle.kts`.
  - ProGuard/R8 optimization and SQLite preservation rules in `proguard-rules.pro`.
- **Verification Commands**:
  ```powershell
  dart format --output=none --set-exit-if-changed .
  flutter analyze --fatal-infos
  flutter test
  ```
- **Exit Criteria**:
  - [x] Clean CI pipeline configuration for GitHub Actions.
  - [x] ProGuard rules preserving Drift and native SQLite libraries.
  - [x] Verification completed via static analysis, formatting, and unit/widget test suites without unnecessary native emulator builds.
- **Status**: **COMPLETE**

---

### Phase 10 — Final Portfolio Polish & Review Readiness
- **Objective**: Complete documentation, architecture diagrams, demo artifacts, and resume evidence for Flutter internship evaluation.
- **Scope**:
  - Comprehensive `README.md` with complete architecture diagrams, features, and setup instructions.
  - Complete `RELEASE_CHECKLIST.md` and `TROUBLESHOOTING.md`.
  - Clear attribution of timetable datasets and trilingual localization verification.
- **Exit Criteria**:
  - [x] Repository is fully reproducible, defensible, and internship-ready.
  - [x] All automated tests passing across domain, data, and presentation layers.
  - [x] Zero warnings or lint issues under `flutter analyze`.
- **Status**: **COMPLETE**

---

### Master Implementation & Stitch UI Integration
- **Objective**: Execute comprehensive master implementation covering atomic timetable synchronization, interactive railway map, crowdsourced disruption reporting, station sequence proximity alerts, commuter dashboard, crowd prediction heuristics, trilingual journey assistant, and exact Stitch UI design alignment.
- **Key Deliverables**:
  - **Timetable Synchronization**: `TimetableSyncService` with deterministic SHA-256 verification, atomic rollback on malformed datasets, and database audit history.
  - **Interactive Map**: `RailwayMapScreen` using `flutter_map` with OpenStreetMap raster tiles (zero paid API keys), corridor polylines (Western, Central, Harbour, Trans-Harbour), line filters, and station detail bottom sheets.
  - **Disruption & Crowding**: `DriftDisruptionRepository` supporting community disruption reports and live Sunday Mega Block advisories with 15/30-minute freshness decay.
  - **Proximity Alerts**: `ProximityAlarmService.evaluateRouteProgression` utilizing route station sequence progression, duplicate trigger suppression, and manual stop progression fallback.
  - **Commuter Dashboard**: `SearchScreen` featuring pinned "My Saved Commutes", search history with limit/clear, live advisory banner, and offline freshness badge.
  - **Prediction & Assistant**: `CrowdPredictionService` with peak-hour heuristics and `InsufficientData` state; `JourneyAssistantService` providing trilingual conversational route assistance and timetable query resolution.
  - **Stitch Design Alignment**: Full assets and code downloaded into `stitch_screens/` matching:
    1. Journey & Destination Alarm (`07f562ca7acd426eabb630a5bf681bc6`)
    2. Route Results (`cf20c0f8193c41ab97f87e68b505debf`)
    3. Network Map & Hubs (`457e4683d57b4784974802d597be4250`)
    4. Station Search & Dashboard (`aa16f7d630ad4659903e832fa0111d9b`)
- **Status**: **COMPLETE**


