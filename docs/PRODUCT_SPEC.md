# Product Specification (docs/PRODUCT_SPEC.md)

**Product Name:** LocalLink — Mumbai Local Train Companion  
**Platform Target:** Android-first (clean Flutter architecture allowing seamless future iOS support)  
**Primary Goal:** Empower over 7.5 million daily Mumbai suburban railway commuters with guaranteed offline timetable lookup, intelligent route planning across interchange stations, timely station proximity alerts, and community-driven coach crowding insights.

---

## 1. Problem Statement & Context

The Mumbai Suburban Railway (the "lifeline of Mumbai") operates over 3,000 train services daily across Western, Central, Harbour, and Trans-Harbour lines. Commuters face several persistent daily challenges:
1. **Network Blackouts**: Deep underground stations, high-density rakes, and suburban track dead zones mean commuters often have zero cellular connectivity when they urgently need to check connecting trains or stop sequences.
2. **Complex Network Transfers**: Commuters switching between lines (e.g. from Western at Dadar to Central, or at Kurla to Harbour) struggle to time transfers between Fast and Slow services.
3. **Missed Stations**: Packed trains, loud ambient noise, poor onboard audio announcements, and exhaustion lead commuters to miss their stop or transfer junction.
4. **Extreme Crowding**: Rakes experience "super dense crush loads" (over 5,000 passengers per 12-car rake). Passengers have no visibility into which coaches (e.g. front vs. middle vs. rear) or which upcoming trains have manageable crowding.

---

## 2. Target Personas

### Persona A: Rajesh, The Daily Peak-Hour Commuter
- **Profile**: 34-year-old financial analyst commuting daily from Borivali (Western) to BKC via Bandra.
- **Needs**: Instant timetable access without waiting for network spin loops; quick identification of Fast trains skipping minor stops; knowing exactly when the train approaches Bandra so he can maneuver toward the exit door 5 minutes early.
- **Pain Point**: Poor network connectivity inside the packed rake prevents checking connecting services.

### Persona B: Priya, The College Student Cross-Line Traveler
- **Profile**: 20-year-old student living in Thane (Central) and attending college in Vile Parle (Western).
- **Needs**: Must change trains at Dadar junction; needs clear transfer guidance (which platform, how many minutes between trains); prefers Marathi or Hindi UI.
- **Pain Point**: Anxiety over missing the Dadar interchange when falling asleep during late evening commutes.

### Persona C: Sunil, The Occasional Commuter / Tourist
- **Profile**: 52-year-old visitor navigating the Mumbai suburban system to visit relatives in Navi Mumbai (Harbour Line).
- **Needs**: High-clarity station search, clear indication of Fast vs. Slow stops, trilingual station names in Devanagari script (Marathi/Hindi) and English.
- **Pain Point**: Overwhelmed by complex paper timetable charts and chaotic platform crowds.

---

## 3. User Journeys

### Journey 1: Instant Offline Timetable Search
1. Commuter opens LocalLink in airplane mode or with poor signal.
2. Selects or searches Origin ("Churchgate") and Destination ("Andheri").
3. LocalLink instantly (<50ms) displays upcoming departures grouped by Fast/Slow, showing departure time, platform estimate, and arrival time.
4. Commuter taps a train to see all intermediate stops with scheduled arrival times.

### Journey 2: Cross-Line Transfer Journey Planning
1. Commuter plans a journey from Thane (Central Line) to Bandra (Western Line).
2. LocalLink computes an optimal route via Dadar Junction.
3. Displays Leg 1 (Thane -> Dadar Fast), estimated walking/transfer buffer at Dadar, and Leg 2 (Dadar -> Bandra Slow/Fast).
4. Commuter bookmarks the journey for 1-tap recall.

### Journey 3: Station Proximity Alarm
1. Commuter boards a crowded train from CST to Kalyan.
2. Taps "Set Alarm for Thane".
3. Selects buffer: "1 station before (Mulund)" or "1 km before station".
4. App registers a low-power geofence.
5. As the train nears Mulund/Thane, the app triggers a loud vibration and audible alarm even if the screen is off or the commuter is listening to music.

### Journey 4: Crowdsourced Coach Crowding
1. Commuter on the platform views upcoming 08:42 Fast train.
2. Views community-reported crowd heatmap: Front Second Class (Super Dense), Middle First Class (Moderate), Rear Second Class (Heavy).
3. Moves to the rear coach platform section before train arrives.
4. While onboard, commuter submits a 1-tap report: "Rear 2nd Class — Moderate" with zero registration required.

---

## 4. Scope & Feature Boundaries

### In-Scope (MVP & Roadmap Phases)
- Trilingual UI: English, Marathi (मराठी), and Hindi (हिन्दी).
- 100% offline timetable query engine using local SQLite database (Drift).
- Station directory covering Western, Central Main, Harbour, and Trans-Harbour corridors.
- Fast vs. Slow train stop differentiation.
- Inter-line journey planner supporting single-transfer junctions (Dadar, Kurla, Vadala Road).
- Contextual station proximity alarms using native geofencing and local notifications.
- Crowdsourced coach crowding reports via Firebase with automatic 30-minute freshness expiration.
- Battery-conscious, accessible, and polished Material 3 design.

### Explicit Non-Goals (Out of Scope)
- **Real-Time GPS Live Rake Tracking**: LocalLink will NOT promise fake "live GPS positions" of trains. Unlike western metros with public GTFS-RT APIs, Indian Railways suburban trains do not expose a public real-time GPS API to third-party apps. Fabricating live positions is strictly forbidden.
- **Ticketing & Booking**: Purchasing UTS tickets or integrating with Indian Railways payment gateways (UTS/IRCTC) is closed and proprietary.
- **Commercial Advertising / Notification Spam**: The app will not include disruptive ad banners or irrelevant push notifications.
- **Social Networking / User Profiles**: No accounts, passwords, or public user profiles are required or collected.
