# LOCALLink — Premium UI/UX Redesign Master Prompt

## Role

Act as a senior product designer, design systems architect, and expert Flutter UI engineer.

Redesign the existing **LocalLink — Mumbai Local Train Companion** application into a polished, production-quality mobile product that feels deliberately designed by an experienced human product team.

The result must feel like a real Mumbai commuter application: practical, distinctive, locally relevant, trustworthy, and beautiful without sacrificing usability.

This is a redesign of the existing application, not an exercise in generating attractive screenshots.

**Implement the design directly in the existing Flutter repository.** Do not merely describe the design, create a Figma-style specification, or produce a static mockup. Modify the actual widgets, layouts, theme, assets, and navigation as required.

---

# 1. The Design Direction

Create a visual identity inspired by three things:

- The precision and clarity of a well-designed public transit system.
- The understated refinement of a premium utility application.
- The distinctive visual character of Mumbai's railway network.

The application should feel functional first, but never visually generic.

Think of a carefully art-directed transit product with strong typography, meaningful use of space, precise alignment, recognizable railway-line graphics, and a restrained color palette.

Avoid making the application look like a generic SaaS dashboard squeezed onto a phone.

## Design personality

The interface should communicate:

- Reliability.
- Speed.
- Clarity.
- Local identity.
- Technical competence.
- Calmness during a busy commute.

The visual experience should feel considered rather than decorative.

Every color, icon, card, divider, animation, and spacing decision must have a reason.

---

# 2. Establish a Distinct Visual Identity

Create a consistent design system before redesigning individual screens.

## Color palette

Use this palette as the starting point. Adjust individual values when needed to achieve accessible contrast.

### Light theme

- Primary ink: `#17263C`
- Primary background: `#F7F6F2`
- Surface: `#FFFFFF`
- Secondary surface: `#EFEEE8`
- Primary text: `#182230`
- Secondary text: `#667085`
- Subtle divider: `#E4E2DC`
- Primary action: `#244A73`
- Highlight accent: `#C8473D`
- Success: `#26734D`
- Warning: `#A86417`
- Error: `#B42318`

Use the red accent sparingly for important actions, alerts, selected railway elements, and meaningful emphasis. Do not make every button and icon red.

The app should predominantly use warm neutral surfaces, dark readable text, and a small number of purposeful accents.

### Dark theme

Create a genuinely designed dark theme rather than simply inverting every color.

Use:

- Deep blue-black backgrounds.
- Distinct but restrained elevated surfaces.
- Muted text with accessible contrast.
- Carefully adjusted line colors and status indicators.
- Consistent separators and selection states.

Do not use pure black everywhere or excessive glowing effects.

### Railway-line colors

Preserve railway-line identity using source-defined colors wherever verified.

Line colors must remain recognizable on maps, route diagrams, station lists, and journey cards.

Do not rely on color alone to distinguish lines. Include line names, labels, or other accessible identifiers.

---

# 3. Typography and Layout

## Typography

Use a coherent typography system with a maximum of two font families.

Prefer a highly legible sans-serif family such as Inter, or a suitable bundled alternative already available in the project.

Use a compatible Devanagari font for Hindi and Marathi when needed. Ensure that English, Hindi, and Marathi text renders correctly without missing glyphs or inconsistent baselines.

Establish clear text roles:

- Large, confident screen titles.
- Compact section headings.
- Highly legible station names.
- Tabular or visually aligned departure times.
- Restrained supporting labels.
- Distinct status and timestamp text.

Do not make every label bold.

Avoid oversized headings that push useful journey information below the fold.

Use consistent typography tokens rather than arbitrary font sizes throughout the application.

## Spacing

Adopt a consistent spacing scale based on 4- and 8-point increments.

Use alignment, whitespace, and typography to establish hierarchy before adding borders or containers.

Avoid:

- Random padding values.
- Excessive empty space.
- Dense clusters of tiny labels.
- Inconsistent screen margins.
- Every component having a different corner radius.
- Multiple nested cards containing one another.

Use safe areas and responsive constraints correctly.

The application must remain usable on compact phones, large Android devices, and different system font sizes.

---

# 4. Make the Home Screen Exceptional

The home screen is the most important screen in the product.

Design it around the commuter's next action rather than a collection of feature cards.

## Recommended composition

### A. Compact header

Create a restrained header containing:

- LocalLink wordmark.
- A small, distinctive railway-inspired brand mark.
- A meaningful current status, such as offline timetable availability or the last data update.
- An optional profile or settings action.

Avoid giant hero illustrations, oversized logos, and unnecessary welcome messages.

### B. Primary journey-search area

Make origin and destination selection the central interaction.

Use a clean, carefully composed search surface with:

- Origin station.
- Destination station.
- A clear swap action.
- Optional departure-time selection.
- A prominent search action.

Use subtle structure, deliberate alignment, and strong field hierarchy.

Do not create an enormous rounded gradient container around a basic form.

### C. Saved journeys

Show frequently used journeys as compact, useful shortcuts.

Each item should communicate the route clearly and allow a one-tap journey search.

Use actual saved journeys. Do not hardcode fictitious home, college, or workplace addresses.

### D. Upcoming journey or departure

When the user has selected a route, present useful departure information with strong visual hierarchy.

Show scheduled times, route details, and freshness indicators.

Never present scheduled departures as real-time arrivals.

### E. Relevant service information

Display recent, relevant disruption or crowd information only when actual data exists.

If there is no information, use a quiet empty state rather than a large decorative placeholder.

### F. Bottom navigation

Use a restrained navigation system for the main destinations, such as:

- Home.
- Explore.
- Saved journeys.
- Settings.

Adapt the destinations to the existing application architecture.

Do not create tabs for features that do not work.

---

# 5. Design the Journey Search and Results Experience

Journey planning is the core of LocalLink. It should receive the most careful information design.

## Search screen

- Make station selection quick and predictable.
- Include clear search and clear-selection actions.
- Display station codes and railway-line information where useful.
- Provide accessible autocomplete suggestions.
- Make the selected origin and destination visually obvious.
- Keep departure-time and route-preference controls compact.
- Preserve input state where appropriate.

Avoid unnecessary modals and decorative elements.

## Route results

Design route results as an information-rich, easy-to-scan list.

Each route should communicate:

- Departure and arrival time.
- Journey duration.
- Service type.
- Transfer count.
- Intermediate stops.
- Scheduled versus live information.
- Relevant data freshness.

Use aligned time columns, compact line indicators, and consistent spacing.

Do not give every route a different visual style.

Use one deliberate selected or recommended treatment. If the app recommends a route, explain the actual reason, such as fewer transfers or shorter scheduled duration.

Never invent a fastest-route badge or a time saving that the routing engine has not calculated.

## Journey details

Create a polished vertical station timeline.

Show:

- Origin.
- Intermediate stops.
- Transfer stations.
- Destination.
- Scheduled arrival and departure times where available.
- Service and direction.
- Active destination alert.
- Available crowd information.

The railway line should appear as a coherent visual element connecting the stations.

Use small, precise markers and readable typography. Do not use oversized colorful circles, random emojis, or decorative icons at every step.

The timeline should help someone understand their journey at a glance while standing on a crowded platform.

---

# 6. Make the Railway Map Feel Native to LocalLink

The railway map should be a signature feature, not a generic map with unrelated floating cards.

## Map styling

- Use restrained map colors and clear railway-line overlays.
- Preserve railway-line identity.
- Highlight the selected journey without overwhelming surrounding geography.
- Use clear station markers at appropriate zoom levels.
- Make interchange stations visually distinguishable.
- Display origin and destination distinctly.
- Keep controls compact and consistent with the rest of the app.

## Map interaction

- Tapping a station should open a useful station detail panel.
- Selecting a route should update the highlighted journey.
- Map controls must have meaningful labels and accessibility semantics.
- The map must remain usable on smaller screens.
- Avoid covering important stations with large floating panels.

Use actual map and railway data. Do not substitute a fabricated railway diagram for a real geographic map while labelling it as one.

If offline map tiles are unavailable, provide a deliberate fallback, such as a schematic route view or station timeline.

Any fallback must be clearly distinguishable from geographic map mode.

---

# 7. Crowd Information and Service Alerts

Crowd and disruption information needs to communicate uncertainty responsibly.

## Crowd visualization

Use a restrained four-level system:

- Low.
- Moderate.
- Heavy.
- Packed.

Use accessible labels, compact indicators, and clear timestamps.

Display the number of reports or evidence strength when available.

Make stale reports visually distinct from recent reports.

Avoid large red heatmaps that make the entire interface look like an emergency dashboard.

Do not display estimated occupancy percentages unless a legitimate measurement method supports them.

## Disruption information

Use a clear severity hierarchy.

Important disruptions should be immediately recognizable, but routine information should remain visually quiet.

Every alert should communicate:

- What happened.
- Where it happened.
- When it was reported.
- Whether it is verified, community-reported, or otherwise unconfirmed.

Provide an appropriate empty state when no relevant alerts exist.

---

# 8. Destination Alert Experience

Design the destination-alarm flow around confidence, clarity, and safety.

The active journey screen should make it obvious:

- Which destination is selected.
- How many stops remain, when known.
- Whether the alarm is enabled.
- Whether location monitoring is active.
- Whether location accuracy is sufficient.
- Whether the app can reliably determine progress.

Use a prominent but restrained active-alert indicator.

Do not show a false precision countdown when the application only has approximate location information.

Permission explanations should be concise and contextual.

Design separate states for:

- Alert active.
- Permission required.
- Location unavailable.
- Low location accuracy.
- Journey completed.
- Alert cancelled.

Use animation sparingly and never as the only indication that an alert is active.

---

# 9. Build a Proper Flutter Design System

Refactor the UI into reusable, purpose-built components.

Create or improve shared components such as:

- `AppTheme`
- `AppColors`
- `AppTypography`
- `AppSpacing`
- `AppRadii`
- `PrimaryButton`
- `StationSearchField`
- `StationLineIndicator`
- `JourneySearchPanel`
- `RouteResultCard`
- `StationTimeline`
- `CrowdLevelIndicator`
- `ServiceAlertTile`
- `OfflineStatusIndicator`
- `EmptyStateView`
- `LoadingStateView`

Use names and structures consistent with the existing repository.

Keep components small and reusable, but do not turn every text label into its own widget.

Use Flutter's theme system rather than scattering literal colors and dimensions throughout the codebase.

Use existing Riverpod state and domain models.

Do not create new hardcoded sample data simply to make a widget look populated.

Use realistic test fixtures only in development and automated tests, with clear separation from production data.

---

# 10. Avoid AI-Generated Design Clichés

This section is mandatory.

Do not use:

- Purple-to-blue gradients on every screen.
- Gradient-filled buttons without a meaningful reason.
- Glassmorphism as the default surface style.
- Excessive backdrop blur.
- Huge rounded cards for every small component.
- Repeated pill-shaped containers around all labels.
- Random floating circles or abstract decorative shapes.
- Generic dashboard layouts with many identical statistic cards.
- Excessive shadows or glowing borders.
- Emoji as the primary icon system.
- Random icons that do not communicate useful meaning.
- Fake charts and meaningless statistics.
- Arbitrary animation on every component.
- Unnecessary illustrations that consume valuable screen space.
- Oversized headings and promotional copy inside a utility app.
- Identical layouts for unrelated features.
- Fake online indicators, fake live times, and fictitious notifications.
- Repeated "AI-powered" labels or artificial marketing language.
- Excessive rounded corners that make every element look interchangeable.

Use gradients, shadows, illustrations, and animation only when they have a clear design purpose.

Prefer a small number of distinctive, consistent design decisions over dozens of decorative effects.

The application must look like a designed product, not a generated template.

---

# 11. Icons, Assets, and Motion

## Icons

Use one consistent icon family, preferably Material Symbols or a compatible icon set already used by the project.

Use recognizable icons with consistent stroke weight, size, and alignment.

Do not mix multiple icon libraries arbitrarily.

## Brand assets

Create a simple LocalLink brand mark inspired by railway lines, connected stations, or a route intersection.

Keep it geometric and recognizable at small sizes.

Avoid generic AI sparkles, gradients, complex illustrations, or excessive detail.

Use real station and map imagery only where it adds genuine value.

## Motion

Use subtle animation for meaningful transitions:

- Switching selected routes.
- Expanding station details.
- Updating route progress.
- Opening contextual panels.
- Confirming a saved journey or enabled alert.

Keep animations short, consistent, and purposeful.

Respect reduced-motion preferences where supported.

Never animate continuously just to make the app look modern.

---

# 12. Localization and Accessibility

The existing application supports English, Hindi, and Marathi.

Preserve that functionality throughout the redesign.

Requirements:

- No hardcoded user-facing strings in widgets.
- Correct English, Hindi, and Marathi localization.
- Correct Devanagari font rendering.
- Flexible layouts for longer translated text.
- Accessible contrast.
- Screen-reader labels for icon-only actions.
- Minimum practical touch targets of approximately 48 logical pixels.
- Support for system text scaling.
- No reliance on color alone to indicate status.
- Logical focus order and keyboard behavior where relevant.

Check every redesigned screen in all supported languages.

---

# 13. Implementation Workflow

Work directly in the existing repository.

### Step 1: Audit the existing UI

Inspect all current screens, navigation, shared widgets, theme files, assets, and state management.

Identify visual inconsistencies and preserve functional behavior.

### Step 2: Establish the design system

Implement colors, typography, spacing, radii, themes, and shared components.

### Step 3: Redesign the main user journey

Prioritize:

1. Home screen.
2. Station search.
3. Route results.
4. Journey details.
5. Railway map.

These screens must form one coherent visual experience.

### Step 4: Redesign supporting features

Update crowd reports, disruptions, destination alerts, saved journeys, settings, and history.

### Step 5: Implement light and dark themes

Ensure both themes are deliberate and fully usable.

### Step 6: Validate real application states

Test:

- First launch.
- Empty local database.
- Loaded timetable.
- No route found.
- No internet connection.
- Stale timetable.
- Missing crowd reports.
- Failed synchronization.
- Location permission denied.
- Active destination alert.
- Long station names.
- Hindi and Marathi text.
- Small screen sizes.
- Increased font scaling.

### Step 7: Run the application

Run formatting, static analysis, tests, and a build where the environment allows.

Fix layout errors, overflows, incorrect navigation, inconsistent themes, and broken functionality.

Do not claim visual validation if you have not inspected actual rendered screens.

If screenshot capture or emulator access is available, capture the redesigned screens and inspect them at realistic phone dimensions. Correct problems based on what you observe.

---

# 14. Definition of Done

The redesign is complete when:

- The app has a recognizable and consistent visual identity.
- The home screen makes journey search the primary action.
- Route results are easier to scan and compare.
- The station timeline is visually coherent and informative.
- The railway map integrates naturally with the rest of the product.
- Crowd and disruption states communicate freshness and uncertainty.
- Destination alerts have clear active, inactive, and error states.
- All screens use the same design tokens.
- Light and dark themes work.
- English, Hindi, and Marathi remain supported.
- The interface works on compact and large phones.
- No core feature has been replaced with a static mockup.
- No fabricated data is presented as real.
- Existing business logic and Clean Architecture boundaries remain intact.
- Flutter analysis and available tests pass, or any remaining failures are documented.

---

# Final Instruction

Make decisive design choices and implement them.

Do not ask me to choose every color, font, radius, or animation. Use your professional judgment within the design direction.

Do not rewrite the app's functionality simply to make the UI easier to build.

Do not stop after changing the theme or creating a single attractive home screen. Apply the design consistently across the complete application.

**The final result should feel like a carefully designed, production-quality Mumbai transit app: understated, distinctive, information-rich, fast to use, and free of generic AI-generated design clichés.**