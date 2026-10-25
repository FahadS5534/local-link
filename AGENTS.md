# AGENTS.md — Agent Operating Instructions & Protocol

Welcome to **LocalLink (Mumbai Local Train Companion)**. This document serves as the mandatory operational protocol for any autonomous coding agent or developer working on this codebase.

---

## 1. Golden Rules for Agents

Every agent operating in this repository MUST strictly follow these rules:

1. **Read Core Docs First**: Before modifying or creating code, you must read:
   - [AGENTS.md](file:///f:/flutter-internship/local-link/AGENTS.md) (this document)
   - [docs/RULES.md](file:///f:/flutter-internship/local-link/docs/RULES.md) (engineering, architectural, and quality rules)
   - [docs/DECISIONS.md](file:///f:/flutter-internship/local-link/docs/DECISIONS.md) (Architecture Decision Records)
   - [docs/ARCHITECTURE.md](file:///f:/flutter-internship/local-link/docs/ARCHITECTURE.md) (system components and design)
   - [docs/PHASES.md](file:///f:/flutter-internship/local-link/docs/PHASES.md) (implementation roadmap and criteria)
2. **Inspect Current State**: Inspect the real repository and run `git status` before touching files.
3. **Strict Phase Isolation**: Identify the single current active phase in [docs/PHASES.md](file:///f:/flutter-internship/local-link/docs/PHASES.md). Implement **only** the requested phase. Never attempt ahead-of-time implementation of future phases.
4. **No Unrelated Refactoring**: Do not restructure code, change unrelated formats, or upgrade unrelated dependencies without an explicit user prompt.
5. **Verify Every Change**:
   - Run `dart format .` to maintain formatting standard.
   - Run `flutter analyze` to ensure zero warnings or lint errors.
   - Run `flutter test` (or targeted test files) to ensure regression-free code.
6. **Synchronize Documentation**: Update [docs/PHASES.md](file:///f:/flutter-internship/local-link/docs/PHASES.md), [CHANGELOG.md](file:///f:/flutter-internship/local-link/CHANGELOG.md), and relevant ADRs immediately after satisfying a phase's acceptance criteria.
7. **Absolute Honesty**: Never fake test runs, never fabricate schedule/train data, and never report incomplete work as complete. If a platform check cannot run (e.g. Android emulator unavailable), explicitly record it as a limitation.
8. **Preserve User Code & Protect Secrets**: Never execute destructive git resets (`git reset --hard`, `git clean -fd`) without explicit confirmation. Never hardcode API keys, credentials, or private configuration.
9. **Clarification Stop**: If a consequential architecture or product decision cannot safely be inferred from the documentation, STOP and ask the user before writing code.
10. **Await Explicit Approval**: At the conclusion of any phase report, summarize achievements and wait for explicit user approval before advancing to the next phase.

---

## 2. Standard Development Workflow

For every phase or feature implementation, follow this 6-step lifecycle:

```
[Step A: Inspect] ──> [Step B: Plan] ──> [Step C: Implement] ──> [Step D: Verify] ──> [Step E: Document] ──> [Step F: Report & Stop]
```

### Step A: Inspect
- Check git branch and working tree: `git status`.
- Check active phase in [docs/PHASES.md](file:///f:/flutter-internship/local-link/docs/PHASES.md).
- Verify dependencies in `pubspec.yaml`.

### Step B: Plan
- State Phase objective.
- Define scope and explicit non-goals.
- List files expected to change.
- Reference relevant ADRs in [docs/DECISIONS.md](file:///f:/flutter-internship/local-link/docs/DECISIONS.md).
- Identify risks, edge cases, and test strategy.

### Step C: Implement
- Write clean, modular, typed Dart code following Clean Architecture layers:
  - `lib/core/` (constants, failures, theme, routing, utils)
  - `lib/features/<feature>/domain/` (entities, value objects, repository interfaces)
  - `lib/features/<feature>/data/` (Drift DAOs, Firebase models, data sources, repository implementations)
  - `lib/features/<feature>/presentation/` (Riverpod controllers, states, screens, widgets)
- Run code generation if using Drift or Freezed:
  ```powershell
  dart run build_runner build --delete-conflicting-outputs
  ```

### Step D: Verify
- Format code:
  ```powershell
  dart format .
  ```
- Run linter & analyzer:
  ```powershell
  flutter analyze
  ```
- Run automated tests:
  ```powershell
  flutter test
  ```

### Step E: Document
- Check off completed acceptance criteria in [docs/PHASES.md](file:///f:/flutter-internship/local-link/docs/PHASES.md).
- Add new ADR in [docs/DECISIONS.md](file:///f:/flutter-internship/local-link/docs/DECISIONS.md) if an architectural decision was introduced.
- Log entries in [CHANGELOG.md](file:///f:/flutter-internship/local-link/CHANGELOG.md).
- Update [README.md](file:///f:/flutter-internship/local-link/README.md) if setup or usage commands changed.

### Step F: Report & Stop
Provide a concise phase completion report with:
- Features implemented.
- Files created/modified.
- Exact commands run and output results.
- Verified vs. unverified behavior.
- Outstanding decisions or risks.
- Proposed next phase.
- **Stop and await user approval.**

---

## 3. Project File Structure Reference

```text
local-link/
├── AGENTS.md                   # This instruction file
├── README.md                   # Project overview and run guide
├── CHANGELOG.md                # Development change log
├── .env.example                # Config placeholders
├── .gitignore                  # Git ignore rules
├── docs/
│   ├── PRODUCT_SPEC.md         # Problem context, personas, scope
│   ├── REQUIREMENTS.md         # Numbered FRs and NFRs
│   ├── ARCHITECTURE.md         # System design, layers, diagrams
│   ├── DECISIONS.md            # Architecture Decision Records (ADR)
│   ├── RULES.md                # Engineering standards & style
│   ├── DATA_MODEL.md           # Domain & DB schemas
│   ├── SECURITY.md             # Privacy, permissions, threat model
│   ├── TESTING.md              # Test strategy, coverage, mocks
│   ├── PHASES.md               # Phased roadmap & checklists
│   ├── TROUBLESHOOTING.md      # Known issues & verified fixes
│   └── RELEASE_CHECKLIST.md    # Pre-release verification
├── assets/                     # Static assets (JSON timetables, icons)
├── lib/                        # Flutter source code
└── test/                       # Unit, widget, and integration tests
```
