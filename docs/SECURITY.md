# Security, Privacy & Threat Model (docs/SECURITY.md)

This document details the security policies, data privacy protections, permissions architecture, and threat mitigation models for **LocalLink**.

---

## 1. Commuter Privacy & Data Minimization

LocalLink adheres to a strict **Zero-PII** (Personally Identifiable Information) architecture.
1. **No Accounts or Logins**: Commuters are never asked to register, log in with Google, or provide email addresses, phone numbers, or names.
2. **On-Device Geolocation**:
   - Commuter GPS coordinates acquired for station proximity alerts are evaluated **entirely in memory on the client device**.
   - Latitude and longitude are **never** logged to disk, transmitted over HTTP, sent to analytics, or written to Firebase.
   - Once an alarm fires or is cancelled, geofence registrations are discarded.
3. **Anonymized Crowd Reporting**:
   - Commuters submitting crowd reports are identified only by a daily ephemeral random session token (salted hash of a random UUID stored in ephemeral memory, or anonymous Firebase Auth UID).
   - This prevents cross-session tracking of commuter travel patterns.

---

## 2. Firebase Security Rules & Threat Mitigation

### 2.1 Threat Vectors for Crowdsourcing
- **Spam / Sybil Inundation**: A malicious actor automated script flooding fake crowd reports (e.g. reporting all trains as "Super-Dense").
- **Stale Report Exploitation**: Displaying historical crowd reports as if they represent current conditions.
- **Data Tampering**: Submitting timestamps in the future or tampering with other users' submissions.

### 2.2 Mitigation Strategy
1. **Strict Client-Side & Server-Side Freshness Windows**:
   - Reports older than 30 minutes are ignored by client queries.
   - Firestore TTL policies automatically delete documents where `ttl < now()`.
2. **ServerTimestamp Enforcement**: Reports must use `request.time` (Firebase server timestamp) to prevent spoofed historical or future timestamps.
3. **Payload Validation**: Strict string length, enum type validation, and required fields.

### 2.3 Cloud Firestore Security Rules
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    
    match /crowd_reports/{reportId} {
      // Anyone can read recent reports
      allow read: if resource.data.reportedAt > request.time - duration.value(30, 'm');

      // Controlled writes with schema validation
      allow create: if request.resource.data.keys().hasAll([
          'tripId', 'stationId', 'lineId', 'coachCategory', 'crowdLevel', 'reportedAt', 'ttl'
        ])
        && request.resource.data.reportedAt == request.time
        && request.resource.data.ttl == request.time + duration.value(30, 'm')
        && request.resource.data.coachCategory in ['firstClass', 'secondClass', 'ladiesFirst', 'ladiesSecond', 'divyang']
        && request.resource.data.crowdLevel in ['low', 'moderate', 'heavy', 'superDense']
        && request.resource.data.tripId.size() <= 32
        && request.resource.data.stationId.size() <= 16;

      // No updates or deletes by clients
      allow update, delete: if false;
    }

    // Default deny for all other paths
    match /{document=**} {
      allow read, write: if false;
    }
  }
}
```

---

## 3. Android Platform Permissions & Lifecycle

| Permission | Justification | Request Timing | Denial Handling |
| :--- | :--- | :--- | :--- |
| `android.permission.ACCESS_FINE_LOCATION` | Required to trigger geofence alerts when entering station radius (~500m-1km). | Requested contextually only when user taps "Set Station Alarm". Never on app startup. | Inform commuter that proximity alarm cannot be activated; allow manual time-based alarm fallback. |
| `android.permission.ACCESS_COARSE_LOCATION` | Cellular/Wi-Fi station proximity fallback. | Requested alongside fine location. | Geofence radius adjusted to broader precision. |
| `android.permission.POST_NOTIFICATIONS` | Required on Android 13+ (API 33+) to alert commuter when screen is off. | Requested contextually upon setting the first alarm. | Display persistent in-app banner warning that sound/vibration cannot break through without notification permission. |
| `android.permission.SCHEDULE_EXACT_ALARM` | Optional for time-based alarm backup. | Only when exact scheduling requested. | Fallback to standard inexact alarms. |

---

## 4. Secret & Credential Management

1. **Zero Hardcoded Secrets**: No secret keys, Firebase service account credentials, or private tokens are checked into git.
2. **Environment Configuration**: Template provided in `.env.example`. Actual config loaded via `--dart-define` or `.env` in local development and GitHub Secrets in CI/CD.
3. **Android Keystore**: Release signing keys (`upload-keystore.jks`) are strictly excluded via `.gitignore` and injected via CI environment variables during release builds.
