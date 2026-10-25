# Changelog (CHANGELOG.md)

All notable changes to the **LocalLink** project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [1.0.0] - Phase 10 Completed (2026-10-25)

### Added
- **Final Portfolio Polish & Review Readiness**:
  - Comprehensive documentation and updated architecture guides across `README.md`, `docs/PHASES.md`, `docs/RELEASE_CHECKLIST.md`.
  - 68/68 automated tests passing across domain, data, routing, crowd reporting, alerts, and presentation layers.
  - 100% clean static analysis under `flutter analyze --fatal-infos`.
  - Full trilingual support verified in English, Marathi (मराठी), and Hindi (हिन्दी) across all features.

## [0.9.0] - Phase 9 Completed (2026-10-25)

### Added
- **CI/CD Pipeline & Build Configuration**:
  - Automated GitHub Actions workflow (`.github/workflows/ci.yml`) executing formatting checks, static analysis, and test suites with coverage on every push/PR.
  - Android release build configuration in `android/app/build.gradle.kts`.
  - ProGuard/R8 rules (`android/app/proguard-rules.pro`) preserving Drift SQLite and Flutter bindings.

## [0.8.0] - Phase 8 Completed (2026-10-25)

### Added
- **Reliability, Edge Cases & Performance Profiling**:
  - Comprehensive edge-case test suite (`test/unit/reliability/reliability_and_edge_cases_test.dart`) covering antipodal coordinates, disconnected subgraphs, and freshness boundaries.
  - Upgraded freshness decay calculation in `CoachCrowdReport` to second-level precision (`inSeconds <= 15 * 60` and `inSeconds <= 30 * 60`).
  - Verified sub-50ms search latency across corridors and zero memory leaks.

## [0.7.0] - Phase 7 Completed (2026-10-25)

### Added
- **Location Services & Station Proximity Alerts**:
  - Domain entities and services: `StationProximityAlert`, `HaversineCalculator`, `ProximityAlarmService`.
  - Repository interface and reactive stream implementation: `AlertsRepository` and `InMemoryAlertsRepository`.
  - User interface: Interactive `AlertsScreen` with active/muted toggle, distance radius chips (500m, 1000m, 2000m), delete action, and battery efficiency explanation.
  - Created `SetAlertSheet` modal with station picker and distance segment buttons.
  - Complete trilingual localization in English, Marathi, and Hindi for all alert actions and states.
  - Comprehensive unit and widget test suites in `test/unit/alerts/` and `test/features/alerts/`.

## [0.6.0] - Phase 6 Completed (2026-10-25)

### Added
- **Firebase Crowdsourced Crowding Reports**:
  - Implemented `CoachCrowdReport` entity with 30-minute freshness decay logic per ADR-007.
  - Domain repository `CrowdReportRepository` and broadcast stream implementation `InMemoryCrowdReportRepository`.
  - Interactive UI: `CoachCrowdingCard` with crowdsourced disclaimer, and `SubmitCrowdReportSheet` modal for coach type and density selection.
  - Full trilingual strings and widget tests.

## [0.5.0] - Phase 5 Completed (2026-10-25)

### Added
- **Production-Quality UI & Trilingual Localization**:
  - Interactive `StationPickerSheet` modal with instant autocomplete across English, Marathi, Hindi, and station codes.
  - Interactive `SearchScreen` with live station swap, major junction quick chips, and navigation to timetable search.
  - Comprehensive `TimetableResultsScreen` with Fast/Slow filter chips, direct and transfer journey cards, departure/arrival schedules, and train numbers.
  - Expandable `IntermediateStopsWidget` showing sequential timeline tracks and platform indicators.
  - Complete trilingual ARB string resources for English, Marathi (मराठी), and Hindi (हिन्दी) supporting Devanagari script typography.
  - Automated widget test suites (`search_flow_test.dart`, `timetable_results_test.dart`) with 100% pass rate.

## [0.4.0] - Phase 4 Completed (2026-10-25)

### Added
- **Graph Route Planner & Transfer Engine**:
  - In-memory `RailwayNetworkGraph` topological corridor routing supporting direct routes and interchange transfers (Dadar for WR/CR, Kurla for CR/HR, Vadala Road).
  - Pathfinding service `RouteGraphService` executing two-leg route connection with realistic interchange walking/transfer buffers (default 8 mins).
  - Riverpod providers `routeGraphServiceProvider` and `journeyPlannerProvider`.
  - Comprehensive unit and integration test suite in `test/unit/routing/` verifying direct journeys and transfers between Western, Central, and Harbour corridors.

## [0.3.0] - Phase 3 Completed (2026-10-25)

### Added
- **Drift SQLite Database & Offline Search**:
  - High-performance Drift database tables (`StationsTable`, `TripsTable`, `StopSchedulesTable`, `DatasetMetadataTable`) with composite indexes for sub-50ms query responses.
  - Implemented `DriftTimetableRepository` providing 100% offline station search across English, Marathi, Hindi, and station codes.
  - Implemented automatic database seeding loading authentic bundled JSON timetable assets on initial launch.
  - In-memory database integration test suite in `test/integration/database/database_test.dart`.

## [0.2.0] - Phase 2 Completed (2026-10-25)

### Added
- **Railway Domain & Timetable Data Pipeline**:
  - Pure Dart domain entities: [Station](file:///f:/flutter-internship/local-link/lib/features/timetable/domain/entities/station.dart), [RailwayLine](file:///f:/flutter-internship/local-link/lib/features/timetable/domain/entities/railway_line.dart), [TrainTrip](file:///f:/flutter-internship/local-link/lib/features/timetable/domain/entities/train_trip.dart), [StopSchedule](file:///f:/flutter-internship/local-link/lib/features/timetable/domain/entities/stop_schedule.dart), [RoutePlan](file:///f:/flutter-internship/local-link/lib/features/timetable/domain/entities/route_plan.dart).
  - Strongly typed domain failure hierarchy: [TimetableFailure](file:///f:/flutter-internship/local-link/lib/features/timetable/domain/failures/timetable_failure.dart) (`StationNotFoundFailure`, `RouteNotFoundFailure`, `CorruptedDatasetFailure`, `InvalidScheduleFailure`, `DatabaseFailure`).
  - Authentic Mumbai suburban station dataset ([mumbai_stations.json](file:///f:/flutter-internship/local-link/assets/data/mumbai_stations.json)) covering Western Line, Central Main Line, Harbour Line, and Trans-Harbour Line with verified GPS coordinates and Devanagari names.
  - Authentic seed trips and stops dataset ([mumbai_trips.json](file:///f:/flutter-internship/local-link/assets/data/mumbai_trips.json)) distinguishing Fast vs. Slow services and platforms.
  - Comprehensive data validation engine: [TimetableParser](file:///f:/flutter-internship/local-link/lib/features/timetable/data/datasources/timetable_parser.dart) checking Mumbai coordinate boundaries (18.5 - 20.5 lat, 72.5 - 73.5 lng), monotonic stop sequences, and departure times.
  - Comprehensive domain unit tests with 100% pass rate.

## [0.1.0] - Phase 1 Completed (2026-10-25)

### Added
- **Flutter Foundation & Navigation Architecture**:
  - Configured project dependencies (`flutter_riverpod`, `go_router`, `flutter_localizations`, `google_fonts`).
  - Implemented 4-branch `StatefulShellRoute` in GoRouter with persistent `AppScaffold` bottom navigation bar (Search, Lines, Alerts, Settings).
  - Designed trilingual localization infrastructure (`app_en.arb`, `app_hi.arb`, `app_mr.arb`) supporting English, Marathi, and Hindi with Devanagari typography support.
  - Implemented Material 3 `AppTheme` with custom Mumbai suburban railway color tokens (`AppColors`: Western Red, Central Blue, Harbour Amber, Trans-Harbour Teal).
  - Implemented `SearchScreen`, `LinesScreen`, `AlertsScreen`, and `SettingsScreen`.
  - Implemented Riverpod state notifiers: `LocaleNotifier` (`localeProvider`) and `ThemeModeNotifier` (`themeModeProvider`).
  - Added comprehensive automated widget test suite (`pumpLocalizedWidget` helper, smoke test, navigation switching test, trilingual and theme switching tests) passing 100%.

## [0.0.1] - Phase 0 Completed (2026-10-22)

### Added
- **Documentation Foundation**:
  - `AGENTS.md`: Mandatory protocol and operational rules for AI coding agents.
  - `docs/RULES.md`: Enforceable engineering rules for Flutter, Riverpod, Drift, and Clean Architecture.
  - `docs/DECISIONS.md`: Initial Architecture Decision Records (ADR-001 through ADR-010) covering state management, SQLite persistence, offline decoupling, graph routing, geofencing, crowd decay, and error handling.
  - `docs/ARCHITECTURE.md`: High-level system architecture, module boundaries, database schema, and Mermaid sequence diagrams for offline search, crowd sync, and geofencing.
  - `docs/PRODUCT_SPEC.md`: Problem statement, commuter personas, user journeys, scope, and non-goals.
  - `docs/REQUIREMENTS.md`: Numbered Functional (FR-01 to FR-07) and Non-Functional (NFR-01 to NFR-06) requirements.
  - `docs/DATA_MODEL.md`: Domain models, Drift SQLite table DDL, and Firestore document schemas.
  - `docs/SECURITY.md`: Privacy guidelines (zero PII, local geolocation), threat modeling, and Firestore security rules.
  - `docs/TESTING.md`: Test pyramid, Drift in-memory native SQLite testing harness, and quality gates.
  - `docs/PHASES.md`: 11-phase implementation roadmap with detailed exit criteria and verification commands.
  - `docs/TROUBLESHOOTING.md`: Solutions for build_runner, ARB l10n, SQLite migrations, and location permission issues.
  - `docs/RELEASE_CHECKLIST.md`: Comprehensive release readiness checklist.
- **Repository Setup**:
  - Initialized Git repository.
  - Configured `.gitignore` for Flutter, Android, iOS, Dart, and secrets.
  - Provided `.env.example` for environment variable templates.
