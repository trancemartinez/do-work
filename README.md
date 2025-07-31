# Do Work

SwiftUI app for adaptive workout logging using GPT-powered natural language input.

## Progress

- Defined core SwiftData models:
  - Exercise, ExerciseAlias
  - Effort (a set linked to Exercise and Session)
  - Session (groups Efforts)
  - UserProfile (user info and unit prefs)
  - BodyMetrics (historical body data)
- Modeled relationships with inverse keys.
- Canonical units stored; display units handled in UserProfile.
- Architecture uses SwiftUI without ViewModels, relies on `@Observable`, `@Query`, `@Environment`.
- NLP parsing integration planned.

## Next

- Build NLP service.
- Develop UI for input and session views.
