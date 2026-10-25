# Release Readiness Checklist (docs/RELEASE_CHECKLIST.md)

This checklist must be executed and fully verified before publishing any public or internal release of **LocalLink**.

---

## 1. Code Quality & Static Analysis Gates

- [x] Run `dart format --output=none --set-exit-if-changed .` — passes with 0 changes.
- [x] Run `flutter analyze --fatal-infos` — passes with 0 issues, 0 warnings, 0 infos.
- [x] Run `flutter test --coverage` — passes with 100% pass rate (68/68 tests passing).
- [x] Confirm no hardcoded debug endpoints, secrets, or test credentials remain in source code.
- [x] Verify no `print()` statements exist in production code (use logger or debugPrint guarded by kDebugMode).

---

## 2. Offline-First Verification

- [ ] Place device / emulator into **Airplane Mode** (Wi-Fi off, Mobile Data off).
- [ ] Perform fresh cold launch: App opens within 1.5 seconds without error dialogs.
- [ ] Search for stations across Western, Central, and Harbour lines — search completes instantaneously (<50ms).
- [ ] Query direct schedule (e.g. Churchgate to Borivali) — timetable loads with fast/slow indicators.
- [ ] Query transfer schedule (e.g. Thane to Bandra via Dadar) — multi-leg route calculates correctly.
- [ ] Open train details screen — verifies timetable is displayed with clear badge: *"Live crowd data unavailable offline"*. Zero crashes or unhandled network exceptions.

---

## 3. Localization Verification

- [ ] Switch app language to **English**: All buttons, titles, station names, error messages render cleanly.
- [ ] Switch app language to **मराठी (Marathi)**: Station names and UI render in Devanagari script without clipping.
- [ ] Switch app language to **हिन्दी (Hindi)**: Station names and UI render in Devanagari script without clipping.
- [ ] Test dynamic text scaling up to 1.5x and 2.0x in system settings: No text overflow yellow-and-black stripes.

---

## 4. Permissions & Android OS Compliance

- [ ] On clean install, confirm app **does not** request Location permission on startup.
- [ ] Tap "Set Proximity Alert": Dialog explains rationale before system permission prompt appears.
- [ ] Test permission denial: App gracefully informs user without crashing and allows manual time alerts.
- [ ] Test Android 13+ notification permission: Heads-up notification displays when station is entered.
- [ ] Verify battery usage: Geofence cancels automatically upon arrival; no background battery drain.

---

## 5. Security & Build Hardening

- [ ] Confirm `.env` and `key.properties` are in `.gitignore` and not tracked by Git.
- [ ] Android `AndroidManifest.xml` has `android:allowBackup="false"` or appropriate backup rules.
- [ ] ProGuard / R8 minification enabled in `android/app/build.gradle` for release builds.
- [ ] Verify APK size: Pre-bundled database and assets result in an APK size under 25MB.
- [ ] Build release APK:
  ```powershell
  flutter build apk --release
  ```
- [ ] Verify generated APK installs cleanly on a physical Android test device:
  ```powershell
  flutter install --release
  ```
