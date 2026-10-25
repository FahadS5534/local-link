# System Architecture (docs/ARCHITECTURE.md)

This document describes the architectural foundations, layer boundaries, data flows, and subsystem integrations of **LocalLink — Mumbai Local Train Companion**.

---

## 1. High-Level Architecture Overview

LocalLink is structured around **Clean Architecture** principles and **Offline-First** design patterns. Presentation and UI widgets are completely decoupled from domain business logic and data storage mechanisms.

```mermaid
graph TD
    subgraph Presentation Layer
        UI[Flutter Screens & Widgets]
        Notifiers[Riverpod Notifiers & Controllers]
        UI --> Notifiers
    end

    subgraph Application Layer
        UseCases[Use Cases & Journey Coordinators]
        Notifiers --> UseCases
    end

    subgraph Domain Layer
        Entities[Domain Entities & Value Objects]
        RepoInterfaces[Repository Interfaces]
        Failures[Domain Failures]
        UseCases --> Entities
        UseCases --> RepoInterfaces
        UseCases --> Failures
    end

    subgraph Infrastructure Layer
        DriftDB[Drift SQLite Timetable DB]
        GraphEngine[In-Memory Network Graph]
        Firestore[Firebase Firestore Client]
        LocationService[Geofencing & Location Service]
        NotificationService[Local Notifications Handler]
        
        DriftDB -.->|implements| RepoInterfaces
        GraphEngine -.->|implements| RepoInterfaces
        Firestore -.->|implements| RepoInterfaces
        LocationService -.->|implements| RepoInterfaces
        NotificationService -.->|implements| RepoInterfaces
    end
```

---

## 2. Layer Responsibilities & Module Boundaries

### 2.1 Presentation Layer (`lib/features/*/presentation/` & `lib/core/presentation/`)
- **Flutter UI**: Small, accessible, stateless/consumer widgets adhering to design tokens.
- **Riverpod Controllers**: StateNotifier / AsyncNotifier controllers managing UI state models (`Initial`, `Loading`, `Success`, `Error`).
- **Localization**: Uses `AppLocalizations.of(context)` for trilingual copy (English, Marathi, Hindi).

### 2.2 Application Layer (`lib/features/*/application/`)
- Orchestrates multi-repository workflows (e.g., querying the graph for route topology, querying Drift for next available departures, checking local alert status).
- Contains coordinators and use cases with single public `execute(...)` or `call(...)` methods.

### 2.3 Domain Layer (`lib/features/*/domain/`)
- Contains enterprise business models (`Station`, `TrainTrip`, `StopSchedule`, `RoutePlan`, `CrowdReport`).
- Pure Dart, free from any Flutter, Drift, or Firebase framework dependencies.
- Declares abstract repository contracts (e.g., `StationRepository`, `TimetableRepository`, `RoutePlannerRepository`, `CrowdReportRepository`, `AlertRepository`).
- Defines typed failures (`Failure`).

### 2.4 Infrastructure Layer (`lib/features/*/data/` & `lib/core/infrastructure/`)
- Implements the domain contracts.
- **Drift DB**: Pre-populated and updatable SQLite database containing indexed timetables, station metadata, and routes.
- **Firebase Firestore Adapter**: Reads and submits anonymized crowd reports. Isolated so network drops never crash the app.
- **Location & Geofencing Adapter**: Uses platform channels / plugins for station proximity detection.
- **Local Notifications**: Issues vibration and audible alarms when approaching destination stations.

---

## 3. Data Flows

### 3.1 Offline Journey Planning & Timetable Search Flow

```mermaid
sequenceDiagram
    autonumber
    actor Commuter
    participant UI as SearchScreen
    participant Controller as RouteSearchNotifier
    participant UseCase as FindRoutesUseCase
    participant Graph as RailwayNetworkGraph
    participant DB as DriftTimetableDatabase

    Commuter->>UI: Selects Origin (Churchgate) & Destination (Borivali)
    UI->>Controller: search(originId, destinationId, time, filter)
    Controller->>UseCase: execute(origin, destination, time, filter)
    
    Note over UseCase,Graph: 100% Offline Execution
    UseCase->>Graph: findPathOptions(originId, destinationId)
    Graph-->>UseCase: returns candidate line sequences (Direct Fast, Direct Slow, Transfer)
    
    UseCase->>DB: queryUpcomingTrips(candidates, time)
    DB-->>UseCase: returns matching trip schedules
    
    UseCase-->>Controller: Right(List<RoutePlan>)
    Controller-->>UI: RouteSearchState.success(routes)
    UI-->>Commuter: Displays fast/slow trains with intermediate stop counts
```

### 3.2 Crowdsourced Coach Crowding Synchronization Flow

```mermaid
sequenceDiagram
    autonumber
    actor Commuter
    participant UI as JourneyDetailsScreen
    participant Controller as CrowdReportNotifier
    participant Repo as CrowdReportRepository
    participant Firestore as Firebase Firestore

    Commuter->>UI: Opens Train Trip Details
    UI->>Controller: loadCrowdReports(tripId)
    Controller->>Repo: streamReports(tripId)
    
    alt Device has Internet Connection
        Repo->>Firestore: query reports where tripId == id and timestamp >= now - 30m
        Firestore-->>Repo: returns live report documents
        Repo-->>Controller: yields List<CrowdReport> with freshness calculation
        Controller-->>UI: displays Coach Heatmap (e.g. Coach 4: Heavy, 8m ago)
    else Device is Offline / Signal Lost
        Repo-->>Controller: yields Left(NetworkOfflineFailure)
        Controller-->>UI: displays timetable with badge: "Crowd info unavailable offline"
    end
```

### 3.3 Station Proximity Geofencing Flow

```mermaid
sequenceDiagram
    autonumber
    actor Commuter
    participant UI as JourneyScreen
    participant AlertController as StationAlertNotifier
    participant GeofenceService as NativeGeofencingService
    participant NotifService as LocalNotificationService

    Commuter->>UI: Taps "Alarm 1 Station Before Destination"
    UI->>AlertController: enableAlert(stationId, targetDistance=1000m)
    AlertController->>GeofenceService: registerGeofence(station.lat, station.lng, radius=1000m)
    GeofenceService-->>AlertController: confirmed active
    AlertController-->>UI: Alert icon toggled to Active
    
    Note over Commuter,GeofenceService: Train approaches destination station
    GeofenceService->>AlertController: onGeofenceEntered(stationId)
    AlertController->>NotifService: triggerHighPriorityAlarm("Approaching Borivali!", "Prepare to alight.")
    NotifService-->>Commuter: Loud alarm, notification banner & vibration
    AlertController->>GeofenceService: autoDeregister(stationId)
```

---

## 4. Database Schema and Offline Storage

The local SQLite database (managed via Drift) consists of the following key tables:

1. **`stations`**:
   - `id` (TEXT, PK, e.g. `ST_DDR` for Dadar)
   - `code` (TEXT, e.g. `DDR`, `DR`, `BVI`)
   - `name_en`, `name_hi`, `name_mr` (TEXT, trilingual names)
   - `latitude`, `longitude` (REAL)
   - `lines` (TEXT, JSON array of lines, e.g. `["WESTERN", "CENTRAL"]`)
   - `is_interchange` (BOOLEAN)
2. **`railway_lines`**:
   - `id` (TEXT, PK, e.g. `LINE_WR`, `LINE_CR`, `LINE_HR`)
   - `name_en`, `name_hi`, `name_mr` (TEXT)
   - `color_hex` (TEXT)
3. **`trips`**:
   - `id` (TEXT, PK, e.g. `TRIP_WR_90001`)
   - `train_number` (TEXT)
   - `line_id` (TEXT, FK -> railway_lines.id)
   - `direction` (TEXT: `UP` or `DOWN`)
   - `service_type` (TEXT: `SLOW`, `FAST`, `AC_SLOW`, `AC_FAST`)
   - `source_station_id` (TEXT, FK)
   - `destination_station_id` (TEXT, FK)
   - `operating_days` (INTEGER, bitmask for Mon-Sun)
4. **`stop_schedules`**:
   - `id` (INTEGER, PK, auto-increment)
   - `trip_id` (TEXT, FK -> trips.id, INDEXED)
   - `station_id` (TEXT, FK -> stations.id, INDEXED)
   - `stop_sequence` (INTEGER)
   - `arrival_time` (INTEGER, minutes from midnight: 0 to 1439, INDEXED)
   - `departure_time` (INTEGER, minutes from midnight, INDEXED)
   - `platform` (TEXT, nullable)
5. **`metadata`**:
   - `key` (TEXT, PK)
   - `value` (TEXT)
   - (Stores timetable version, publish date, source attribution, import checksum)

---

## 5. Security & Isolation Boundaries

- **Local Storage Isolation**: SQLite DB resides exclusively inside the application's private app data sandbox on Android (`/data/data/com.locallink.mumbai/databases/`).
- **Location Coordinate Protection**: GPS coordinates never leave the device. All geofence distance checks are evaluated locally.
- **Firebase Guardrails**:
  - Unauthenticated or anonymous users can read reports within the past 30 minutes.
  - Submissions require schema validation and rate limiting.
  - No commuter PII is accepted or stored.
