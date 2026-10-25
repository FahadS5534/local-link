# Troubleshooting & Verified Solutions (docs/TROUBLESHOOTING.md)

This document records common development, build, and runtime issues encountered during the development of **LocalLink**, along with verified step-by-step solutions.

---

## 1. Code Generation & Build Runner Issues

### Issue: Conflicting outputs during `build_runner`
- **Symptom**: `build_runner` fails with `ConflictingOutputsException: ... generated files already exist`.
- **Cause**: Generated files (`*.g.dart`, `*.drift.dart`) were committed or left over from a previous interrupted build.
- **Solution**:
  ```powershell
  dart run build_runner clean
  dart run build_runner build --delete-conflicting-outputs
  ```

### Issue: Drift schema file not found or outdated
- **Symptom**: Drift database fails to generate database accessor classes.
- **Solution**:
  Ensure the database class specifies all tables explicitly in `@DriftDatabase(tables: [...])` and that `drift_dev` is listed under `dev_dependencies` in `pubspec.yaml`.

---

## 2. Localization (l10n) & ARB Generation

### Issue: ARB keys not generating getters in `AppLocalizations`
- **Symptom**: Compiler reports `The getter 'xyz' isn't defined for the class 'AppLocalizations'`.
- **Cause**: Flutter l10n tool hasn't regenerated the synthetic package files in `.dart_tool/flutter_gen/`.
- **Solution**:
  1. Ensure `l10n.yaml` exists in the project root:
     ```yaml
     arb-dir: lib/core/l10n/arb
     template-arb-file: app_en.arb
     output-localization-file: app_localizations.dart
     ```
  2. Run `flutter gen-l10n` manually or run `flutter test` / `flutter run` which triggers automatic generation.

### Issue: Devanagari text clipping or truncation
- **Symptom**: Hindi or Marathi vowels (matras like ि, ी, ु, ू) or conjunct characters are vertically clipped on certain Android devices.
- **Solution**:
  In `ThemeData`, ensure `TextStyle` provides appropriate `height` (e.g., `height: 1.25` or `1.3`) for Devanagari scripts and avoid setting rigid fixed `Container(height: ...)` wrappers around localized text widgets.

---

## 3. SQLite & Drift Database Migrations

### Issue: `SqliteException(1): no such table: ...` after schema update
- **Symptom**: App crashes on startup after adding a new column or table.
- **Cause**: The local database file on the device/emulator is still at schema version 1, but the code is expecting schema version 2 without a defined `migration` strategy.
- **Solution**:
  1. For development quick resets: clear app data or uninstall app on emulator.
  2. For production stability: increment `schemaVersion` in the Drift database class and implement the migration step in `MigrationStrategy`:
     ```dart
     @override
     MigrationStrategy get migration => MigrationStrategy(
       onCreate: (m) async => m.createAll(),
       onUpgrade: (m, from, to) async {
         if (from < 2) {
           await m.createTable(newTable);
         }
       },
     );
     ```

---

## 4. Location & Geofencing Edge Cases

### Issue: Geofence alert does not fire when train enters station
- **Symptom**: Commuter arrives at the station but proximity alert notification does not appear.
- **Cause**:
  1. GPS signal loss inside enclosed or underground railway platforms.
  2. Android Battery Optimization (Doze mode) throttled location updates.
- **Solution**:
  1. Set minimum geofence radius to at least 500m to 1000m to allow cell-tower/Wi-Fi assisted geolocation to trigger before reaching the platform.
  2. Instruct users to exempt LocalLink from aggressive battery optimization when setting alarms.

### Issue: Notification permission denied on Android 13+
- **Symptom**: Geofence triggers in background, but no heads-up notification is displayed.
- **Cause**: Android 13 (API 33) requires explicit runtime permission for `POST_NOTIFICATIONS`.
- **Solution**:
  Check `await Permission.notification.status` before activating an alarm. If denied, show an in-app dialog explaining why the alert cannot sound without notification access.

---

## 5. Firebase Offline Decoupling

### Issue: App hangs or times out when testing offline
- **Symptom**: Timetable screen spins indefinitely when device is placed in Airplane Mode.
- **Cause**: A provider or usecase is awaiting a Firebase Firestore call without a timeout or without checking connectivity.
- **Solution**:
  Always isolate Firebase calls inside `CrowdReportRepository` with explicit timeouts:
  ```dart
  firestore.collection('crowd_reports').get().timeout(
    const Duration(seconds: 3),
    onTimeout: () => throw NetworkFailure('Connection timed out'),
  );
  ```
  Ensure the timetable search never queries Firestore; timetable data must query Drift exclusively.
