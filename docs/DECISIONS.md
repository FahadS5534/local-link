# Architecture Decision Records (ADRs) (docs/DECISIONS.md)

This log records every significant architectural, technical, and structural decision made for the **LocalLink** project.

---

## Index of ADRs

- [ADR-001: State Management and Dependency Injection via Riverpod](#adr-001-state-management-and-dependency-injection-via-riverpod)
- [ADR-002: Local Timetable Persistence via Drift and SQLite](#adr-002-local-timetable-persistence-via-drift-and-sqlite)
- [ADR-003: Strict Decoupling of Firebase Crowdsourcing from Core Offline Routing](#adr-003-strict-decoupling-of-firebase-crowdsourcing-from-core-offline-routing)
- [ADR-004: Versioned Immutable Timetable Datasets and Schema Migration Strategy](#adr-004-versioned-immutable-timetable-datasets-and-schema-migration-strategy)
- [ADR-005: Railway Network Graph & Search Index Representation](#adr-005-railway-network-graph--search-index-representation)
- [ADR-006: Station Proximity Alerts and Geofencing Lifecycle](#adr-006-station-proximity-alerts-and-geofencing-lifecycle)
- [ADR-007: Crowdsourced Crowd Report Freshness Decay, TTL, and Anonymization](#adr-007-crowdsourced-crowd-report-freshness-decay-ttl-and-anonymization)
- [ADR-008: Strongly Typed Domain Failures and Functional Error Handling](#adr-008-strongly-typed-domain-failures-and-functional-error-handling)
- [ADR-009: Trilingual Localization Architecture (English, Hindi, Marathi)](#adr-009-trilingual-localization-architecture-english-hindi-marathi)
- [ADR-010: Environment Configuration via Dart-Define and Optional .env](#adr-010-environment-configuration-via-dart-define-and-optional-env)

---

## ADR-001: State Management and Dependency Injection via Riverpod

- **Status**: Accepted
- **Date**: 2026-10-22
- **Related Phases**: Phase 1, Phase 3, Phase 4, Phase 5, Phase 6, Phase 7, Phase 8

### Context
A modern, maintainable Flutter app requires robust state management, testable dependency injection, explicit lifecycle management, and clear separation between UI and application logic. The application also needs reactive state updates for timetable searches, proximity alerts, and live crowd sync.

### Decision
Adopt **Riverpod** (`flutter_riverpod` with `@riverpod` code generation / modern `Notifier` and `AsyncNotifier` APIs) as the exclusive state management and dependency injection solution across the application.

### Alternatives Considered
1. **Bloc / Cubit**: Excellent architecture, but verbose boilerplate for simple dependency injection and derived reactive states.
2. **Provider**: InheritedWidget-based, runtime-only dependency checks, lacks clean async cache invalidation, and has scoping limitations compared to Riverpod.
3. **GetIt / Injectable**: Works for DI, but requires a separate library for state management, fragmenting the architecture.

### Consequences & Trade-offs
- **Pros**: Compile-time safety, auto-dispose of inactive states, straightforward unit testing by overriding providers in container, zero Flutter context requirement for business logic.
- **Cons**: Requires code generation via `build_runner` for optimal DX; learning curve for modern notifier syntax.

---

## ADR-002: Local Timetable Persistence via Drift and SQLite

- **Status**: Accepted
- **Date**: 2026-10-22
- **Related Phases**: Phase 0, Phase 2, Phase 3, Phase 4, Phase 8

### Context
Mumbai suburban railway networks feature hundreds of stations, thousands of daily trips across Western, Central, Harbour, and Trans-Harbour lines, and tens of thousands of scheduled stop times. The app must execute complex timetable queries (e.g. "Next fast train from Dadar to Borivali after 18:30 stopping at Bandra and Andheri") offline in under 50ms.

### Decision
Use **Drift** (formerly Moor) over standard SQLite. Drift provides a type-safe, reactive Dart DSL for SQLite with built-in schema migrations, indexed queries, and automated table generation.

### Alternatives Considered
1. **Hive / Isar**: Key-value or object stores. While fast for simple lookups, complex multi-table relational joins (trips, stop_times, stations, calendar days) are clumsy and prone to memory overhead.
2. **Raw sqflite**: Requires hand-written SQL strings with no compile-time type safety and high risk of runtime schema mismatch errors.
3. **Pure in-memory JSON**: High RAM consumption, slow startup deserialization on budget Android devices.

### Consequences & Trade-offs
- **Pros**: Relational indexing on `station_id`, `trip_id`, and `departure_time`; native Dart streams; robust migration API; proven offline performance.
- **Cons**: Requires code generation step; SQLite binary adds minimal footprint (~1-2MB).

---

## ADR-003: Strict Decoupling of Firebase Crowdsourcing from Core Offline Routing

- **Status**: Accepted
- **Date**: 2026-10-22
- **Related Phases**: Phase 0, Phase 3, Phase 4, Phase 6

### Context
Subway commuters in Mumbai frequently encounter deep signal blackouts (underground platforms, crowded rakes, suburban dead zones). The core value proposition of LocalLink is guaranteed offline functionality for route finding and timetable checks. Crowdsourced coach crowding is an auxiliary value-add.

### Decision
Architecturally isolate Firebase Cloud Firestore behind a dedicated `CrowdReportRepository` domain interface. The core route planner and timetable query engine must have **zero dependency** on Firebase initialization or network connectivity. If Firebase fails or network is disconnected, the UI displays offline timetable data with a clear badge: *"Offline: live crowd reports unavailable"*.

### Alternatives Considered
1. **Firebase as Central Backend**: Storing schedules on Firestore with offline persistence enabled. Rejected because Firestore offline cache is unpredictable, doesn't support complex relational joins, and incurs high read/write costs.
2. **Supabase / Postgres**: Similar drawbacks regarding network requirements; still requires local SQLite fallback.

### Consequences & Trade-offs
- **Pros**: Guaranteed 100% offline uptime for journey planning; lower cloud operational costs; clean failure boundaries.
- **Cons**: Dual data model (relational SQLite for timetable, document Firestore for transient crowd reports).

---

## ADR-004: Versioned Immutable Timetable Datasets and Schema Migration Strategy

- **Status**: Accepted
- **Date**: 2026-10-22
- **Related Phases**: Phase 0, Phase 2, Phase 3, Phase 8

### Context
Railway timetables update periodically (typically yearly or biannually by Central & Western Railway). The application must ship with an initial, pre-indexed offline dataset, and support future updates without corrupting user bookmarks or settings.

### Decision
Store timetable assets as versioned, validated JSON / SQLite pre-populated packages in the app bundle. Track timetable version via a `metadata` table in Drift. Migrations are executed via Drift's `MigrationStrategy`:
- Version 1: Initial static schema with stations, lines, trips, stop_schedules.
- Subsequent versions: Schema version increments trigger safe step-by-step schema migrations while preserving user preferences and alerts.

### Alternatives Considered
1. **Dynamically downloading entire SQLite DB on first run**: High initial launch friction, network failure on first install ruins onboarding.
2. **Hardcoded Dart constants**: Bloats Dart VM heap memory, lacks SQL indexing.

### Consequences & Trade-offs
- **Pros**: Zero initial download delay on install; deterministic data state; testable migration scripts.
- **Cons**: Increases initial APK size by ~5-8MB for bundled timetable assets.

---

## ADR-005: Railway Network Graph & Search Index Representation

- **Status**: Accepted
- **Date**: 2026-10-22
- **Related Phases**: Phase 2, Phase 3, Phase 4

### Context
Finding routes between two Mumbai suburban stations requires supporting:
1. Direct journeys on the same line (both Fast and Slow trains).
2. Interchange journeys requiring transfer at major junctions (e.g., Dadar for Western/Central, Kurla for Central/Harbour, Vadala Road for Harbour/Goregaon).
The route finder must compute optimal routes quickly without lagging the UI thread.

### Decision
Implement a hybrid approach:
1. **Network Topology Graph**: An in-memory graph representation of stations and line connections for topological path-finding (Dijkstra / BFS for shortest transfer hops).
2. **Schedule Lookup via Indexed SQLite**: Once candidate line sequences (direct or single-interchange) are identified by the graph, fetch actual scheduled trips from SQLite indexed by `departure_time >= current_time`.

### Alternatives Considered
1. **Pure SQL Recursive CTEs**: Extremely complex to write and optimize in SQLite for time-dependent transit paths across transfers.
2. **Full In-Memory GTFS engine**: Too heavy for budget Android devices with limited RAM.

### Consequences & Trade-offs
- **Pros**: Sub-millisecond path topology discovery; lightning-fast trip filtering via SQLite index; clean separation of physical network and timetable.
- **Cons**: Requires keeping station topology in memory (~200KB for Mumbai suburban network).

---

## ADR-006: Station Proximity Alerts and Geofencing Lifecycle

- **Status**: Accepted
- **Date**: 2026-10-22
- **Related Phases**: Phase 7

### Context
Commuters sleeping or listening to music often miss their destination or interchange stations. Geofencing can notify them 500m-1km before their destination. However, background location tracking on Android is subject to aggressive battery restrictions and runtime permissions (`ACCESS_FINE_LOCATION`, `ACCESS_BACKGROUND_LOCATION`, `POST_NOTIFICATIONS`).

### Decision
1. Default to foreground alerts when app is active.
2. Use Android native Geofencing APIs (via standard Flutter geofencing/location plugins) registered only for the active journey destination.
3. Use `flutter_local_notifications` with high-importance notification channel and vibration/sound.
4. Auto-cancel geofences once the user arrives or dismisses the journey.
5. Never request `ACCESS_BACKGROUND_LOCATION` up front; request location contextually only when the user taps "Set Station Alarm".

### Alternatives Considered
1. **Continuous high-frequency GPS polling in background service**: Heavy battery drain, guaranteed Android OS kill on low-memory devices.
2. **WorkManager periodic tasks**: Minimum interval is 15 minutes, far too infrequent for train arrivals (a train covers 5-10km in 15 minutes).

### Consequences & Trade-offs
- **Pros**: Minimal battery impact; low permission friction; clear user value.
- **Cons**: Geofencing accuracy inside underground platforms or heavy metal rakes can vary based on cell tower/GPS reception; fallback distance estimates required.

---

## ADR-007: Crowdsourced Crowd Report Freshness Decay, TTL, and Anonymization

- **Status**: Accepted
- **Date**: 2026-10-22
- **Related Phases**: Phase 6

### Context
Crowd levels in Mumbai local trains fluctuate dramatically minute by minute. A report from 45 minutes ago is actively misleading. Furthermore, commuter privacy must be protected, and spam reports must be mitigated.

### Decision
1. **Freshness Windows**:
   - `Fresh` (0 - 15 minutes ago): High confidence indicator.
   - `Expiring` (15 - 30 minutes ago): Medium confidence with age label (e.g., "Reported 20m ago").
   - `Expired` (> 30 minutes ago): Automatically ignored by UI and purged from active queries.
2. **Anonymity**: No personal identifying information (PII) is stored. Reports use an anonymous client session hash.
3. **Firestore Aggregation**: Reports are aggregated per `(train_id or station_id, coach_type, direction)`.
4. **Disclaimers**: UI prominently labels crowd data as *"Crowdsourced commuter estimate • Not an official railway feed"*.

### Alternatives Considered
1. **Persistent user reputation system with logins**: Adds massive onboarding friction for daily commuters who want instant access without an account.
2. **Permanent report history**: Unnecessary cloud storage costs with zero real-time value.

### Consequences & Trade-offs
- **Pros**: Clean data, honest commuter expectations, minimal privacy risks, low Firestore storage footprint.
- **Cons**: Requires active commuter engagement during peak hours for sufficient report density.

---

## ADR-008: Strongly Typed Domain Failures and Functional Error Handling

- **Status**: Accepted
- **Date**: 2026-10-22
- **Related Phases**: All Phases

### Context
Untyped exceptions bubbling up to UI widgets cause crashes, unhelpful "Something went wrong" messages, or silent failures.

### Decision
Adopt functional error handling using a typed `Result<T, Failure>` pattern (or fpdart `Either<Failure, T>`). Domain repositories and use cases return explicit failure types:
- `DatabaseFailure`
- `StationNotFoundFailure`
- `RouteNotFoundFailure`
- `PermissionDeniedFailure`
- `NetworkFailure`
- `DataCorruptionFailure`

### Alternatives Considered
1. **Standard `throw Exception()`**: Easily overlooked by callers, hard to test exhaustively.

### Consequences & Trade-offs
- **Pros**: Exhaustive `switch` pattern matching in Dart 3; forced handling of error states in controllers.
- **Cons**: Slightly more verbose return types.

---

## ADR-009: Trilingual Localization Architecture (English, Hindi, Marathi)

- **Status**: Accepted
- **Date**: 2026-10-22
- **Related Phases**: Phase 1, Phase 5

### Context
Mumbai commuters encompass speakers of Marathi (official state language), Hindi (widely spoken commuter language), and English. Station names, route directions (Up/Down / अप/डाऊन), coach types, and alerts must be accessible in all three languages.

### Decision
Use official Flutter localization (`flutter_localizations` with `.arb` Application Resource Bundle files).
- Default locale: English (`en`), with immediate switcher for Marathi (`mr`) and Hindi (`hi`).
- Station names stored in the database with trilingual columns (`name_en`, `name_hi`, `name_mr`) to allow searching and display in the commuter's selected language.

### Alternatives Considered
1. **Custom JSON key-value files**: Lacks automated type-safe getters (`AppLocalizations.of(context)`).
2. **Third-party SaaS i18n libraries**: Adds unnecessary external dependencies.

### Consequences & Trade-offs
- **Pros**: Native Flutter integration; type-safe translation keys; zero runtime overhead.
- **Cons**: Requires maintaining three ARB translation files in sync.

---

## ADR-010: Environment Configuration via Dart-Define and Optional .env

- **Status**: Accepted
- **Date**: 2026-10-22
- **Related Phases**: Phase 0, Phase 6, Phase 9

### Context
Different environments (local development, test, CI/CD, release) require different configuration values (e.g. Firebase project IDs, feature flags).

### Decision
Use compile-time environment definitions via `const String.fromEnvironment('KEY')` (passed via `--dart-define` or `--dart-define-from-file=.env`). Provide `.env.example` as a template. Never commit real `.env` secrets into source control.

### Alternatives Considered
1. **Hardcoded config files**: Risks committing sensitive keys.
2. **Runtime JSON assets**: Not available before app bootstrapping; less secure.

### Consequences & Trade-offs
- **Pros**: Compile-time constant folding, zero runtime disk I/O, secure in CI/CD.
- **Cons**: Developers must supply `--dart-define-from-file=.env` during custom builds.
