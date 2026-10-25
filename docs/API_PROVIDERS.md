# External API and Data Provider Evaluation (docs/API_PROVIDERS.md)

This document enforces the **Mandatory Free API and Zero-Cost-First Policy** for **LocalLink (Mumbai Local Train Companion)**. LocalLink is built to operate with 100% functional completeness using zero-cost, privacy-respecting, open-data sources, and locally bundled offline data.

*Last Checked & Verified:* October 25, 2026.

---

## 1. Provider Comparison Matrix

| Provider / Technology | Domain / Purpose | Free Usage | Login Required | API Key Required | Billing Required | Limitations & Terms | Classification |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Drift + SQLite** | Offline Timetable & Routing Engine | 100% Free (Local embedded) | No | No | No | Storage limited only by commuter's device disk space. Zero network latency. | **Free and operational** |
| **OpenStreetMap (OSM) Tiles via `flutter_map`** | Interactive Railway Line & Station Maps | 100% Free (Open Database License) | No | No | No | Must include attribution `© OpenStreetMap contributors`; subject to OSM tile usage policy (requires descriptive User-Agent, max 2 concurrent downloads). | **Free and operational** |
| **Haversine Local Geofencing** | Station Proximity Alarms | 100% Free (Device-only computation) | No | No | No | Relies on device GPS/fused location; no network calls or geocoding fees. | **Free and operational** |
| **Firebase Cloud Firestore (Spark Tier)** | Crowdsourced Coach Density & Disruptions | 100% Free up to 50k reads / 20k writes daily | Yes (Project setup) | Yes (`google-services.json`) | **No (Spark Tier is free forever)** | Quotas cap at 50,000 reads/day. Graceful degradation to offline mode when quota is exceeded or offline. | **Free with registration** |
| **National Train Enquiry System (NTES / CRIS)** | Official Live Railway Feeds | Restricted / Enterprise only | Yes | Yes | Yes (Commercial licensing) | No public free REST endpoint for Mumbai suburban trains; scraping is prohibited. LocalLink uses authentic scheduled timetables instead of fabricating live feeds. | **Unavailable or unverified** |
| **Local Rule-Based Natural Language Engine** | Conversational Journey Assistant | 100% Free (Local pure Dart parser) | No | No | No | Deterministic pattern extraction for trilingual commute queries without external LLM inference costs. | **Free and operational** |
| **Gemini / OpenAI API (Optional Extension)** | Advanced LLM Query Expansion | Optional / Tier-dependent | Yes | Yes | Yes (Credit card required for pay-as-you-go) | Optional plugin boundary only. Zero core app dependency. Never bundle hardcoded secrets. | **Paid or usage-dependent** |

---

## 2. In-Depth Evaluation by Commuter Feature

### 2.1 Station & Railway Infrastructure Data
- **Chosen Solution**: Pre-bundled, validated JSON datasets (`mumbai_stations.json`, `mumbai_trips.json`) verified against Western Railway (WR) and Central Railway (CR) published public timetables.
- **Rationale**: Mumbai local trains operate on fixed corridor tracks. Storing the verified coordinates (latitude, longitude), interchange junctions (Dadar, Kurla, CSMT), and platform layouts locally guarantees instantaneous load times (<50ms) and zero data consumption for commuters.
- **Licensing & Redistribution**: Derived from public domain railway timetables published by Indian Railways under Open Data initiatives.

### 2.2 Map Rendering & Map Tiles
- **Chosen Solution**: `flutter_map` (Leaflet port for Flutter) rendering OpenStreetMap standard tile layers (`https://tile.openstreetmap.org/{z}/{x}/{y}.png`).
- **Rationale**: Completely open source, zero licensing costs, no credit card requirement, and no vendor lock-in with Google Maps SDK or Mapbox.
- **Graceful Offline Fallback**: If cellular data is off or tiles fail to load, the map screen displays station markers, vector corridor lines, and text lists using local coordinates.

### 2.3 Railway Timetable Synchronization
- **Chosen Solution**: Abstracted `TimetableSyncRepository` checking version manifests (`dataset_manifest.json`) via HTTP/S with SHA-256 checksum verification.
- **Rationale**: Keeps timetable synchronization transaction-safe with automatic rollback if a dataset is corrupted.
- **Provider**: Compatible with GitHub Pages, Cloudflare R2 free tier, or any static HTTP host.

### 2.4 Live Train Arrivals, Delays, and Cancellations
- **Honest Commuter Disclosure**: Indian Railways does not offer an open, free, unauthenticated real-time GPS telemetry feed for Mumbai suburban trains (EMU rakes). Third-party apps relying on unauthenticated web scraping frequently suffer outages.
- **LocalLink Architecture**: LocalLink strictly adheres to truth-in-data:
  1. Displays authoritative scheduled timetables with source and effective dates.
  2. Supplements with crowdsourced commuter disruption reports (e.g. delays, platform changes).
  3. Clearly labels community estimates vs. scheduled times.

### 2.5 Crowd-Report Synchronization
- **Chosen Solution**: Firebase Firestore configured on the free **Spark Tier**.
- **Rationale**: 50,000 document reads and 20,000 document writes per day provide ample capacity for Mumbai commuters submitting 30-minute transient coach reports.
- **Security & Privacy**: Client session hashing (anonymized device token) prevents spam without recording personal identity or user accounts.

### 2.6 Destination & Proximity Alerts
- **Chosen Solution**: High-precision spherical distance via **Haversine formula** combined with journey station progression tracking.
- **Rationale**: Zero external geocoding or reverse-geocoding API calls. Evaluated strictly on-device using Android's location provider.

### 2.7 Conversational Journey Assistant
- **Chosen Solution**: Built-in Pure Dart natural-language parser matching station entities, direction, and speed preferences across English, मराठी (Marathi), and हिन्दी (Hindi).
- **Rationale**: Commuters get instant responses (<10ms) without sending private journey queries to external cloud LLM servers or requiring expensive API keys.
- **Extensibility**: An optional remote LLM adapter interface is provided for advanced users supplying their own API key via `.env`.

---

## 3. Final Integration Classification Summary

1. **Free and operational**:
   - Drift SQLite local database (Timetables, trips, schedules, saved journeys, history).
   - `flutter_map` with OpenStreetMap tile rendering.
   - Haversine geofence and proximity alarm engine.
   - Local trilingual rule-based Conversational Journey Assistant.
   - Seed data pipeline with SHA-256 integrity validation.

2. **Free with registration**:
   - Firebase Firestore Spark Tier (Community coach crowding and disruption reports).

3. **Free tier with billing requirements**:
   - *None*. LocalLink does not require any payment method or credit card.

4. **Paid or usage-dependent**:
   - Optional external LLM API adapter (disabled by default; requires commuter's own key).

5. **Unavailable or unverified**:
   - Official live GPS telemetry feed from Indian Railways (NTES/CRIS) — treated as scheduled timetables + community updates.
