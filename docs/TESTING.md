# Testing Strategy & Quality Gates (docs/TESTING.md)

This document establishes the testing strategy, test pyramid, mocking protocols, and verification gates for **LocalLink**.

---

## 1. The Testing Pyramid

```
               /  E2E / Device Tests  \           ~ 10% (Android Emulator & Real Hardware)
              /------------------------\
             /       Widget Tests       \         ~ 25% (Screen states, ARB localization, forms)
            /----------------------------\
           /     Integration Tests        \       ~ 25% (Drift SQLite queries, migrations, repos)
          /--------------------------------\
         /      Domain & Unit Tests         \     ~ 40% (Route algorithm, freshness, entities)
        /------------------------------------\
```

---

## 2. Unit Testing (Domain & Application Logic)

- **Pure Dart Tests**: Located in `test/unit/`.
- **Target Areas**:
  - `RailwayNetworkGraph`: Graph construction, BFS/Dijkstra shortest path, interchange junction resolution (Dadar, Kurla, etc.).
  - `CrowdReport`: Freshness decay logic (Fresh -> Expiring -> Expired) tested using a deterministic `Clock` interface.
  - `TrainTrip` & `ServiceType`: Fast vs. slow station skipping logic.
  - Functional failure and result monads (`Either<Failure, T>`).
- **Deterministic Time Provider**:
  - Never use direct `DateTime.now()` in business logic.
  - Inject a clock provider:
    ```dart
    final clockProvider = Provider<DateTime Function()>((ref) => DateTime.now);
    ```
  - In unit tests, override with a fixed time (e.g., `2026-10-22 08:30:00`) to test departure filters and crowd freshness deterministically.

---

## 3. Database & Repository Testing (Drift SQLite)

- **In-Memory SQLite**: Drift tests run against in-memory native SQLite using `drift/native.dart`:
  ```dart
  LazyDatabase openTestConnection() {
    return LazyDatabase(() async => NativeDatabase.memory());
  }
  ```
- **Target Areas**:
  - Point-to-point timetable queries: Verify correct sequence, arrival/departure ordering, and operating day bitmask filtering.
  - Database migrations: Verify schema upgrades from v1 to v2 without data loss using Drift's migration verifier (`drift_dev/schema_migrator`).
  - Search indexes: Verify sub-30ms performance on 5,000+ stop schedules.

---

## 4. Widget Testing (Presentation & Localization)

- **Test Harness (`test/helpers/pump_app.dart`)**:
  - Wraps widgets with `ProviderScope`, `MaterialApp`, and `AppLocalizations` delegates for `en`, `hi`, and `mr`.
- **Key Scenarios to Test**:
  - Screen states: `Initial`, `Loading` (skeleton/shimmer), `Empty` ("No direct trains found"), and `Error`.
  - Trilingual rendering: Ensure station names and badges render correctly in Marathi, Hindi, and English.
  - Accessibility: Run `tester.ensureVisible()` and verify minimum touch target size (48x48dp) and semantic descriptions.

---

## 5. Verification Commands & CI Quality Gates

Before any phase or pull request can be approved, the following commands must run with 0 errors:

```powershell
# 1. Format check
dart format --output=none --set-exit-if-changed .

# 2. Static analysis
flutter analyze --fatal-infos

# 3. Automated unit and widget tests
flutter test --coverage
```

### Coverage Goals:
- **Domain & Application Logic**: Minimum 85% line coverage.
- **Data & Repositories**: Minimum 80% line coverage.
- **Presentation Controllers**: Minimum 75% line coverage.
- **Overall Target**: > 80% codebase coverage.
