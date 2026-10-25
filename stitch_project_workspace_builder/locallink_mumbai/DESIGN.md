---
name: LocalLink Mumbai
colors:
  surface: '#f9f9ff'
  surface-dim: '#ccdbf8'
  surface-bright: '#f9f9ff'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f0f3ff'
  surface-container: '#e7eeff'
  surface-container-high: '#dee8ff'
  surface-container-highest: '#d5e3ff'
  on-surface: '#0c1c31'
  on-surface-variant: '#43474e'
  inverse-surface: '#223147'
  inverse-on-surface: '#ebf1ff'
  outline: '#73777f'
  outline-variant: '#c3c6cf'
  surface-tint: '#3c608b'
  primary: '#04335b'
  on-primary: '#ffffff'
  primary-container: '#244a73'
  on-primary-container: '#96bae9'
  inverse-primary: '#a5c9f9'
  secondary: '#ac332b'
  on-secondary: '#ffffff'
  secondary-container: '#fd6e60'
  on-secondary-container: '#6d0005'
  tertiary: '#003b22'
  on-tertiary: '#ffffff'
  tertiary-container: '#005433'
  on-tertiary-container: '#7cc89b'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#d2e4ff'
  primary-fixed-dim: '#a5c9f9'
  on-primary-fixed: '#001c37'
  on-primary-fixed-variant: '#224871'
  secondary-fixed: '#ffdad5'
  secondary-fixed-dim: '#ffb4ab'
  on-secondary-fixed: '#410002'
  on-secondary-fixed-variant: '#8a1a16'
  tertiary-fixed: '#a6f3c4'
  tertiary-fixed-dim: '#8ad7a9'
  on-tertiary-fixed: '#002111'
  on-tertiary-fixed-variant: '#005231'
  background: '#f9f9ff'
  on-background: '#0c1c31'
  surface-variant: '#d5e3ff'
typography:
  display-lg:
    fontFamily: Inter
    fontSize: 32px
    fontWeight: '700'
    lineHeight: 38px
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Inter
    fontSize: 24px
    fontWeight: '700'
    lineHeight: 30px
    letterSpacing: -0.015em
  headline-md:
    fontFamily: Inter
    fontSize: 20px
    fontWeight: '600'
    lineHeight: 26px
    letterSpacing: -0.01em
  headline-sm:
    fontFamily: Inter
    fontSize: 17px
    fontWeight: '600'
    lineHeight: 22px
    letterSpacing: -0.005em
  title-md:
    fontFamily: Inter
    fontSize: 15px
    fontWeight: '600'
    lineHeight: 20px
  title-sm:
    fontFamily: Inter
    fontSize: 13px
    fontWeight: '600'
    lineHeight: 18px
  body-lg:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  body-md:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
  body-sm:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '400'
    lineHeight: 16px
  tabular-time-lg:
    fontFamily: Inter
    fontSize: 28px
    fontWeight: '700'
    lineHeight: 32px
    letterSpacing: -0.02em
  tabular-time-md:
    fontFamily: Inter
    fontSize: 18px
    fontWeight: '600'
    lineHeight: 22px
  label-md:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '600'
    lineHeight: 16px
    letterSpacing: 0.02em
  label-sm:
    fontFamily: Inter
    fontSize: 11px
    fontWeight: '500'
    lineHeight: 14px
    letterSpacing: 0.03em
rounded:
  sm: 0.125rem
  DEFAULT: 0.25rem
  md: 0.375rem
  lg: 0.5rem
  xl: 0.75rem
  full: 9999px
spacing:
  gutter: 0.75rem
  gutter-tablet: 1rem
  margin: 1rem
  margin-tablet: 1.5rem
  space-xxs: 0.125rem
  space-xs: 0.25rem
  space-sm: 0.5rem
  space-md: 0.75rem
  space-lg: 1rem
  space-xl: 1.5rem
  space-2xl: 2rem
---

## Brand & Style

This design system is engineered for the high-friction, sensory-overloaded environment of Mumbai's suburban rail network. Commuters operate on moving trains, under harsh sunlight, through dense monsoon crowds, and across intermittent connectivity. The aesthetic responds with an uncompromising utilitarian calm: understated, precise, legible from an arm's reach while balancing on footboards, and devoid of decorative trends, artificial glass effects, or bloated cards.

The visual direction embraces a **Functional/Editorial Transit** ethos:
- **Calm Utility:** Clean off-white surfaces reduce optical fatigue beneath harsh industrial station lighting and glaring sun.
- **Immediate Hierarchy:** Critical route, platform, and countdown metrics command immediate visual attention via stark ink contrasts and strict tabular alignments.
- **Tactile Civic Presence:** Structural hairline frames and disciplined geometries honor physical railway signage without descending into nostalgic skeuomorphism.

## Colors

The palette establishes an information architecture rooted in legibility, strict status signaling, and geographic orientation across Mumbai's rail corridors.

### Surface & Canvas
- **Canvas (`#F7F6F2`):** A warm, low-glare paper surface that softens stark sunlight exposure.
- **Elevated Surface (`#FFFFFF`):** High-clarity white card backgrounds providing clean separation from the warm canvas.
- **Subtle Surface (`#EFEEE8`):** Muted structural grouping surface for table headers, inactive segments, and station progress tracks.
- **Transit Hairline (`#E4E2DC`):** 1px structural dividers and card borders; strictly non-decorative.

### Ink & Typography
- **Primary Ink (`#17263C`):** Heavy navy-tinted charcoal for headings, terminal station names, countdowns, and primary legibility.
- **Body Text (`#182230`):** Neutral dark for route details, platform labels, and schedule text.
- **Secondary Muted Text (`#667085`):** Balanced mid-slate for timestamps, kilometer markers, and metadata.

### Accent & Functional
- **Primary Railway Blue (`#244A73`):** Primary actions, active navigation states, selected route badges, and primary search buttons.
- **Signal Red (`#C8473D`):** Reserved strictly for critical interchanges, platform changes, missed train alerts, and urgent service disruptions.
- **Success Track (`#26734D`):** On-time status, confirmed platform allocations, clear crowd conditions.
- **Warning Indicator (`#A86417`):** Minor delays (under 10 mins), scheduled megablocks, maintenance alerts.
- **Critical Alert (`#B42318`):** Indefinite delays, cancelled services, emergency line disruptions.

### Railway Line Corridor Tokens
Dedicated tokens applied to route indicators, station line-transfer dots, and header strips:
- **Western Line (WR):** `#D9381E`
- **Central Main Line (CR):** `#F28C28`
- **Harbour Line (HR):** `#0284C7`
- **Trans-Harbour (TH):** `#7C3AED`

### Crowd Density Spectrum
- **Tier 1 (Low):** Fill `#E8F5E9` | Stroke `#2E7D32` | Ink `#1B5E20`
- **Tier 2 (Moderate):** Fill `#FEF3C7` | Stroke `#D97706` | Ink `#92400E`
- **Tier 3 (Heavy):** Fill `#FFEDD5` | Stroke `#EA580C` | Ink `#9A3412`
- **Tier 4 (Packed):** Fill `#FEE2E2` | Stroke `#DC2626` | Ink `#991B1B`

## Typography

The type system prioritizes high-speed parsing. Inter is deployed across Latin characters, alongside system Devanagari (Noto Sans Devanagari fallback) to support bilingual display (मराठी/हिंदी) for station names and transit warnings.

### Tabular Formatting
All departure times, ETA countdowns, platform numbers, and distance markers must enforce CSS OpenType features: `font-feature-settings: "tnum" 1, "cv05" 1`. This stops horizontal digit wobble when times update dynamically every second.

### Bilingual Display Guidelines
- When English and Marathi/Hindi co-exist on station headers, Marathi appears directly above or next to the English text in a medium weight (`body-sm` or `title-sm`), set in Primary Ink (`#17263C`) to retain civic authority.
- Devanagari line heights must accommodate full ascenders/descenders without clipping borders or adjacent rows.

## Layout & Spacing

This design system uses a strict 4pt/8pt rhythm optimized for one-handed mobile grip during erratic movement.

### Breakpoints & Canvas Bounds
- **Mobile Handheld (360px – 430px):** Single-column layout, `margin` = `1rem`, `gutter` = `0.75rem`.
- **Large Handheld / Small Tablet (431px – 768px):** Centered canvas bounded at a maximum width of 520px to retain reachability and rapid scanning.

### Layout Rules
- **Touch Bounds:** Touch targets for arrival items, interchange links, and filter pills must not fall below a physical 48px square area, even when visual badge boundaries are tighter (e.g., 28px visual height).
- **Dense Commuter Lists:** Departure listings maintain an uncompromising vertical density. List item spacing utilizes `space-sm` (8px) interior vertical padding, balancing dense informational payloads with precise thumb accuracy.

## Elevation & Depth

To eliminate visual noise and remain legible in harsh outdoor daylight, this system completely rejects ambient multi-tier blurred shadows, heavy drop shadows, and translucent frosted overlays.

Hierarchy is achieved via **structural surface layering and precise hairline boundaries**:
- **Base Canvas:** `#F7F6F2` establishes the physical floor of the viewport.
- **Card Tier:** Surfaces rest on pure `#FFFFFF`, bounded by a sharp `1px solid #E4E2DC` border.
- **Sticky / Overlay Headers:** Station timetable pinned headers use `#FFFFFF` with a single directional underside hairline: `border-bottom: 1px solid #E4E2DC`. Zero shadow blur is applied.
- **Active / Pressed State:** Subtle tactile inset using `#EFEEE8` fill rather than a depth shift.

## Shapes

The shape vocabulary is deliberate, architectural, and compact. 

- **Containers & Cards:** 8px (`rounded-md` equivalent under `roundedness: 1`) to preserve structure and fit high amounts of transit data cleanly.
- **Pills & Status Badges:** 4px to 6px maximum. Avoid circular capsule pills (`rounded-full`), which waste horizontal space and feel overly playful for an essential utility.
- **Indicators:** Exact 6px or 8px geometric circles for railway line identity dots; rectangular 3px left-aligned colored edge stripes to communicate line ownership across cards.

## Components

### 1. Departure List Item (Primary Transit Atom)
- **Container:** Background `#FFFFFF`, 1px solid `#E4E2DC`, radius 8px, padding 10px 12px.
- **Left Column (Destination & Line):** Corridor indicator stripe (3px wide, colored by line token) or line badge (e.g., `[WR]` in `#D9381E` text with `#FDE8E8` background, 4px radius). Terminal station in `headline-sm` with bilingual label directly above in `body-sm`.
- **Center Column (Train Attributes):** Fast/Slow badge (`F` in red-orange, `S` in slate), coach count (`12C` / `15C`), air-conditioned snowflake icon if AC local.
- **Right Column (ETA & Platform):** Tabular countdown in `tabular-time-lg` (e.g., `04 min` or `18:42`). Platform number housed inside a crisp hairline box: `PF 3` in `title-sm`, background `#EFEEE8`, 4px radius, 24px height.

### 2. Crowd Density Indicator
- A 4-tier horizontal segment or compact chip.
- Uses strict crowd tokens (e.g., Tier 4 "Packed" uses `#FEE2E2` background, `#B42318` text, and 4 micro-bars with all 4 illuminated).
- Displayed adjacent to the coach count without overwhelming platform or countdown data.

### 3. Action Buttons
- **Primary:** Background `#244A73`, text `#FFFFFF`, radius 6px, minimum height 48px, font `title-md`. Active state shifts to `#1A3756`.
- **Secondary:** Background `#FFFFFF`, border `1px solid #244A73`, text `#244A73`, radius 6px, minimum height 48px.
- **Destructive/Emergency Alert:** Background `#C8473D`, text `#FFFFFF`, radius 6px.

### 4. Station Search & Filter Inputs
- **Field:** Background `#FFFFFF`, border `1px solid #E4E2DC`, radius 6px, height 48px, horizontal padding 12px.
- **Focus:** 1.5px solid `#244A73`, zero glowing outline rings.
- **Quick Switch Icon:** 44px x 44px tap area to invert Source and Destination stations instantaneously.

### 5. Line Corridor Filter Tabs
- Segmented control mounted directly beneath the search area.
- Inactive segment: `#EFEEE8` background, `#182230` text.
- Active segment: `#244A73` background with white text, or individual railway line colors when filtering by line (`WR`, `CR`, `HR`, `TH`).

### 6. Service Alert Banner
- Full-bleed or inline container with a 4px left-border accent matching alert severity (`#C8473D` for red alerts, `#A86417` for warnings).
- Background `#FFFFFF`, 1px hairline border, text set in `body-md` with timestamps formatted in tabular figures.