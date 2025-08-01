# Do Work

A SwiftUI app for adaptive workout logging powered by GPT-driven natural language input.

## Progress

- ✅ Core SwiftData models defined:
  - `Exercise`, `ExerciseAlias`
  - `Effort` (linked to `Exercise` and `Session`)
  - `Session` (groups multiple `Efforts`)
  - `UserProfile` (stores user info and unit preferences)
  - `BodyMetrics` (historical tracking of physical data)
- ✅ Relationships modeled using inverse keys
- ✅ Canonical units stored; display units derived via `UserProfile` preferences
- ✅ Architecture uses native SwiftUI patterns (`@Observable`, `@Query`, `@Environment`)
- ✅ Basic GPT integration scaffolding and test coverage in place

## Next

- 🚧 Build out the GPT NLP service
- 🚧 Create UI for natural language input and session views
- 🚧 Add more advanced logging and metric features
