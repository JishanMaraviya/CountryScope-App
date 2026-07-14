# Countries Explorer

A Material 3 Flutter application for discovering countries through the public Countries GraphQL API.

## Highlights

- GraphQL queries with normalized Hive-backed caching
- Riverpod `AsyncNotifier` state management and GoRouter navigation
- Local, real-time country search and continent filtering
- Cached FlagCDN images, responsive phone/tablet layouts, and accessible controls
- Offline SQLite favorites and persisted light, dark, or system theme preference
- Splash, loading shimmer, empty/error states, hero transitions, and Flutter Animate motion

## Run

```bash
flutter pub get
flutter run
```

The Android manifest already declares Internet permission. The app queries `https://countries.trevorblades.com/graphql` and builds flag URLs from each returned country code.
