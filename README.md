# RijksArtGallery

## Project
### Main highlights:
- 100% programmatic UI, no Storyboards used.
- No 3rd party libraries.
- MVVM-C architecture.
- Image caching.

### Branch and merge strategy
🔀 Git-flow
↩️ Rebase and merge

### Improvements
There's definetely room for improvement (as always in every take-home project). But I wanted to point out some of them.
- *Empty state*: Didn't have time to add an `EmptyState` UI component to show when there was no data returned from the API. Would have been a nice UX improvement to provide better context to the user on what's going on.
- *UI design*: I've opted for a plain but clean style, but it could be way improved.
- *More interfaces*: in order to have far better reusable and **testable** components, I could've added some more protocols (e.g. `NetworkSession`) to create stricter and replaceable API contracts.
