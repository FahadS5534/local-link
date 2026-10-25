# Data Model Specification (docs/DATA_MODEL.md)

This document specifies the domain entities, relational SQLite tables (Drift), and Firebase Firestore document schemas for **LocalLink**.

---

## 1. Domain Entities & Value Objects (Pure Dart)

### 1.1 Station
Represents a physical railway station in the Mumbai suburban network.
```dart
class Station {
  final String id;             // Stable identifier, e.g., 'ST_CSTM', 'ST_DDR_WR'
  final String code;           // Official IR railway code: 'CSMT', 'DDR', 'BVI'
  final String nameEn;         // English: 'Dadar'
  final String nameHi;         // Hindi: 'दादर'
  final String nameMr;         // Marathi: 'दादर'
  final double latitude;       // e.g. 19.0178
  final double longitude;      // e.g. 72.8478
  final List<RailwayLineId> lines; // [RailwayLineId.western, RailwayLineId.central]
  final bool isInterchange;    // true if connects multiple lines
}
```

### 1.2 RailwayLine
Represents an operating suburban corridor.
```dart
enum RailwayLineId { western, centralMain, harbour, transHarbour, uran }

class RailwayLine {
  final RailwayLineId id;
  final String nameEn;         // 'Western Line'
  final String nameHi;         // 'पश्चिम रेलवे'
  final String nameMr;         // 'पश्चिम रेल्वे'
  final int colorHex;          // e.g. 0xFFE11D48 (Red) or 0xFF2563EB (Blue)
}
```

### 1.3 TrainTrip & ServiceType
Represents an individual scheduled train service.
```dart
enum TrainDirection { up, down } // UP = toward city terminus (CST/CCG); DOWN = toward suburbs

enum ServiceType {
  slow,        // Stops at all stations
  fast,        // Skips minor stations
  acSlow,      // Air-conditioned rake stopping at all stations
  acFast,      // Air-conditioned rake skipping minor stations
  ladiesSpecial// Restricted ladies rake
}

class TrainTrip {
  final String id;               // e.g., 'TRIP_WR_90001'
  final String trainNumber;      // e.g., '90001'
  final RailwayLineId lineId;
  final TrainDirection direction;
  final ServiceType serviceType;
  final String sourceStationId;
  final String destinationStationId;
  final int operatingDaysMask;   // Bitmask: Bit 0=Mon, Bit 6=Sun
}
```

### 1.4 StopSchedule
A single scheduled arrival/departure for a trip at a station.
```dart
class StopSchedule {
  final String tripId;
  final String stationId;
  final int stopSequence;        // 1, 2, 3...
  final int arrivalMinutes;      // Minutes from midnight (0..1439)
  final int departureMinutes;    // Minutes from midnight (0..1439)
  final String? platform;        // e.g., '1', '2A'
}
```

### 1.5 RoutePlan & RouteLeg
Computed journey between origin and destination.
```dart
class RouteLeg {
  final TrainTrip trip;
  final Station originStation;
  final Station destinationStation;
  final int departureMinutes;
  final int arrivalMinutes;
  final List<StopSchedule> intermediateStops;
  final int stopCount;
}

class RoutePlan {
  final Station origin;
  final Station destination;
  final List<RouteLeg> legs;    // 1 leg for direct, 2 legs for single transfer
  final int totalDurationMinutes;
  final Station? transferStation; // Null if direct
  final int? transferBufferMinutes;
}
```

### 1.6 CrowdReport
A crowdsourced report of coach density.
```dart
enum CoachCategory {
  firstClass,
  secondClass,
  ladiesFirst,
  ladiesSecond,
  divyang
}

enum CrowdLevel {
  low,         // Seats easily available
  moderate,    // Standing room comfortable
  heavy,       // Crowded, doorway packed
  superDense   // Crushed, extreme effort to board/alight
}

enum ReportFreshness {
  fresh,       // < 15 minutes old
  expiring,    // 15 - 30 minutes old
  expired      // > 30 minutes old
}

class CrowdReport {
  final String id;
  final String tripId;
  final String stationId;
  final CoachCategory coachCategory;
  final CrowdLevel crowdLevel;
  final DateTime reportedAt;
  final String reporterSessionHash;
}
```

---

## 2. Drift / SQLite Database Schema

The local SQLite schema is generated via Drift (`drift` + `drift_dev`).

```sql
-- Stations Table
CREATE TABLE stations (
    id TEXT PRIMARY KEY NOT NULL,
    code TEXT NOT NULL UNIQUE,
    name_en TEXT NOT NULL,
    name_hi TEXT NOT NULL,
    name_mr TEXT NOT NULL,
    latitude REAL NOT NULL,
    longitude REAL NOT NULL,
    lines_json TEXT NOT NULL,
    is_interchange INTEGER NOT NULL DEFAULT 0
);
CREATE INDEX idx_stations_code ON stations(code);

-- Railway Lines Table
CREATE TABLE railway_lines (
    id TEXT PRIMARY KEY NOT NULL,
    name_en TEXT NOT NULL,
    name_hi TEXT NOT NULL,
    name_mr TEXT NOT NULL,
    color_hex INTEGER NOT NULL
);

-- Trips Table
CREATE TABLE trips (
    id TEXT PRIMARY KEY NOT NULL,
    train_number TEXT NOT NULL,
    line_id TEXT NOT NULL REFERENCES railway_lines(id),
    direction TEXT NOT NULL,
    service_type TEXT NOT NULL,
    source_station_id TEXT NOT NULL REFERENCES stations(id),
    destination_station_id TEXT NOT NULL REFERENCES stations(id),
    operating_days_mask INTEGER NOT NULL DEFAULT 127
);
CREATE INDEX idx_trips_line_dir ON trips(line_id, direction);

-- Stop Schedules Table (Core index for high-speed queries)
CREATE TABLE stop_schedules (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    trip_id TEXT NOT NULL REFERENCES trips(id) ON DELETE CASCADE,
    station_id TEXT NOT NULL REFERENCES stations(id),
    stop_sequence INTEGER NOT NULL,
    arrival_minutes INTEGER NOT NULL,
    departure_minutes INTEGER NOT NULL,
    platform TEXT
);
CREATE INDEX idx_stops_station_dep ON stop_schedules(station_id, departure_minutes);
CREATE INDEX idx_stops_trip_seq ON stop_schedules(trip_id, stop_sequence);

-- Timetable Metadata Table
CREATE TABLE dataset_metadata (
    key TEXT PRIMARY KEY NOT NULL,
    value TEXT NOT NULL
);
```

---

## 3. Firebase Cloud Firestore Document Schema

Path: `/crowd_reports/{reportId}`

| Field | Type | Description | Constraints |
| :--- | :--- | :--- | :--- |
| `tripId` | string | Target train trip ID | Max 32 chars |
| `stationId` | string | Station where observed | Valid station ID |
| `lineId` | string | Railway corridor | Valid line ID |
| `coachCategory`| string | `firstClass`, `secondClass`, etc. | Enum string |
| `crowdLevel` | string | `low`, `moderate`, `heavy`, `superDense` | Enum string |
| `reportedAt` | timestamp | Firestore ServerTimestamp | Within last 30m |
| `reporterHash`| string | SHA-256 client session hash | Anonymized |
| `ttl` | timestamp | ServerTimestamp + 30 minutes | Auto-deletion index |

### Firestore Query Indexes:
- Composite Index: `(tripId ASC, reportedAt DESC)`
- Composite Index: `(stationId ASC, reportedAt DESC)`
- TTL Policy on `ttl` field to automatically purge expired documents.
