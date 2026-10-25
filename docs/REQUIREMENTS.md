# Requirements Specification (docs/REQUIREMENTS.md)

This document specifies the numbered Functional Requirements (FR) and Non-Functional Requirements (NFR) for **LocalLink**. Each requirement has a stable identifier, priority level, and verification criteria.

---

## 1. Functional Requirements (FR)

### FR-01: Trilingual Station Search & Directory
- **Priority**: P0 (Must Have)
- **Description**: Commuters must be able to search and browse all suburban stations by English name, Marathi name, Hindi name, or official railway code (e.g., `DDR`, `CSTM`, `BVI`).
- **Acceptance Criteria**:
  - Search query matches against `name_en`, `name_mr`, `name_hi`, and station `code` case-insensitively.
  - Sub-50ms search response as user types.
  - Results indicate line associations (e.g. Western Line badge, Central Line badge) and interchange status.
  - Stations can be bookmarked/favorited for quick access on the home screen.

### FR-02: Offline Timetable Lookup
- **Priority**: P0 (Must Have)
- **Description**: Commuters must be able to view full scheduled timetables for any origin-destination pair on the same line without an active internet connection.
- **Acceptance Criteria**:
  - Filter by direction (UP / DOWN) and service type (All, Fast, Slow, AC).
  - Displays scheduled departure time, estimated arrival time, duration, and train number.
  - Tapping a train displays the complete stop sequence, noting intermediate stations skipped by Fast trains.
  - Operates completely in Airplane Mode using local SQLite (Drift) data.

### FR-03: Multi-Line Route & Transfer Journey Planning
- **Priority**: P0 (Must Have)
- **Description**: The app must plan journeys between stations located on different railway lines, identifying intermediate interchange junctions (e.g., Dadar, Kurla, Vadala Road).
- **Acceptance Criteria**:
  - Generates multi-leg itineraries (Leg 1: Source to Interchange; Leg 2: Interchange to Destination).
  - Calculates estimated transfer buffer time at the interchange station.
  - Returns explicit "No route found" failure state for invalid or unroutable station pairs.
  - Deterministic results validated against test fixture journeys.

### FR-04: Station Proximity Alerts & Geofencing
- **Priority**: P1 (Should Have)
- **Description**: Commuters must be able to set a proximity alert for their destination or interchange station to prevent missing their stop.
- **Acceptance Criteria**:
  - Commuter can select alert distance threshold (e.g., 500m, 1000m, or 1 station prior).
  - Android location permission (`ACCESS_FINE_LOCATION`) requested contextually only when setting an alarm.
  - Triggers audible alert, vibration, and high-priority notification upon crossing the geofence boundary.
  - Automatically cancels geofence registration upon arrival or explicit dismissal to conserve battery.

### FR-05: Crowdsourced Coach Crowding Reports
- **Priority**: P1 (Should Have)
- **Description**: Commuters can submit and view community-reported crowd density levels for specific train coaches.
- **Acceptance Criteria**:
  - Report parameters: Train/Trip ID, Station, Coach Category (First Class, Second Class, Ladies, Divyang), Crowd Level (Low, Medium, Heavy, Super-Dense).
  - Freshness window: Reports decay and are categorized as Fresh (0-15m), Expiring (15-30m), and Expired (>30m). Expired reports are excluded from active calculations.
  - Prominent disclaimer displayed indicating crowdsourced estimation, not official railway data.
  - If network is unavailable, timetable remains fully functional and displays a localized offline status badge.

### FR-06: Trilingual Localization
- **Priority**: P0 (Must Have)
- **Description**: Entire user interface must support English, Marathi, and Hindi, switchable from the app settings or system locale.
- **Acceptance Criteria**:
  - All UI strings, error states, and buttons use Flutter ARB localizations.
  - Devanagari script renders cleanly without clipping or text overflow at 1.5x and 2.0x font scaling.
  - Railway terminology accurately translated (e.g., Fast Train -> जलद लोकल / तेज लोकल; Slow Train -> धीमी लोकल / धीमी लोकल).

### FR-07: Timetable Data Versioning & Updates
- **Priority**: P1 (Should Have)
- **Description**: Bundled timetable data must have version metadata, with an architecture supporting local schema migrations.
- **Acceptance Criteria**:
  - App displays dataset publish date, version code, and source attribution in an "About Data" screen.
  - Corrupt or invalid local data triggers a clean recovery path without crashing.

---

## 2. Non-Functional Requirements (NFR)

### NFR-01: Offline Availability & Zero Remote Coupling
- The primary journey planner and timetable lookup must achieve 100% availability without active cellular data or Wi-Fi.
- Cold startup time to search screen in offline mode must be under 1.5 seconds on mid-range Android hardware.

### NFR-02: Performance & Query Latency
- Station search autocomplete query latency: < 30ms.
- Point-to-point timetable query latency: < 50ms for direct journeys, < 100ms for transfer journeys.
- 60 FPS scrolling on timetable and stop sequence lists.

### NFR-03: Battery & Resource Efficiency
- Zero continuous background GPS polling when no active proximity alert is configured.
- Geofence monitoring must utilize Android OS hardware-accelerated geofencing APIs where supported.
- App background memory footprint must not exceed 50MB.

### NFR-04: Privacy & Anonymity
- Zero user PII (names, phone numbers, device IDs, advertising IDs) collected.
- Commuter GPS coordinates are processed exclusively on-device and never sent over the network.
- Crowd reports submitted to Firebase use ephemeral anonymous hashes.

### NFR-05: Accessibility & Inclusive Design
- Conformance to WCAG 2.1 AA contrast ratios (minimum 4.5:1 for normal text).
- Touch targets for all buttons and interactive cards: minimum 48x48dp.
- Full screen reader semantic announcements for station names, departure times, and alert toggles.

### NFR-06: Code Quality & Automated Test Gates
- 100% null safe Dart code with zero `flutter analyze` warnings.
- Comprehensive unit test coverage for domain entities, network graph route finder, and database DAOs.
- All database queries and migrations validated via automated integration tests.
