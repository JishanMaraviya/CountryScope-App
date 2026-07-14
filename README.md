# CountryScope 🌍

A production-quality Material 3 Flutter application for discovering and exploring countries around the world using the public Countries GraphQL API.

## ✨ Features

- **Explore Countries:** View a comprehensive list of countries fetched via GraphQL.
- **Advanced Filtering & Search:** Search countries locally in real-time and filter by continents.
- **Offline Favorites:** Save your favorite countries locally using an offline SQLite database.
- **Beautiful UI & Animations:** 
  - Splash screens, loading shimmers, and beautifully designed empty/error states.
  - Smooth hero transitions and motion animations powered by `flutter_animate`.
- **Customizable Theming:** Switch between Light, Dark, and System default themes. Supports Material 3 Dynamic Colors.
- **High Performance:** Features normalized Hive-backed caching for GraphQL queries and `cached_network_image` for fast flag loading from FlagCDN.
- **Responsive & Accessible:** Adapts to both phone and tablet layouts seamlessly with accessible controls.

## 🛠️ Tech Stack & Libraries

This project uses modern, industry-standard Flutter libraries:

- **Framework:** [Flutter](https://flutter.dev/) (SDK ^3.10.4)
- **State Management:** [Riverpod](https://riverpod.dev/) (`flutter_riverpod`) - *Using AsyncNotifier for robust state handling.*
- **Networking & API:** [GraphQL](https://pub.dev/packages/graphql_flutter) (`graphql_flutter`, `gql`)
- **Navigation:** [GoRouter](https://pub.dev/packages/go_router) for declarative routing.
- **Local Storage:** 
  - `sqflite` (SQLite database for favorites)
  - `shared_preferences` (For persisting user preferences like themes)
- **UI & Animations:**
  - `dynamic_color` (Material 3 dynamic theming)
  - `flutter_animate` (Micro-interactions and motion)
  - `cached_network_image` (Image caching)
  - `cupertino_icons`
- **Utilities:** `intl` (Formatting), `path_provider`, `path`

## 📁 Folder Structure

The project follows a clean, feature-first architecture to maintain modularity and scalability:

```text
lib/
 ├── core/              # Core configurations, GraphQL client setup, theme, and constants
 ├── features/          # Feature-based modular directories
 │   ├── countries/     # Country listing and GraphQL fetching
 │   ├── country_details/ # Country detail screen and logic
 │   ├── favorites/     # Offline favorite countries implementation
 │   ├── home/          # Main screen and bottom navigation setup
 │   ├── search/        # Real-time local search and filtering
 │   ├── settings/      # App settings and theme switching
 │   └── splash/        # Splash screen and app initialization
 ├── shared/            # Shared, reusable UI widgets across features
 └── main.dart          # Entry point of the application
```

## 🚀 Getting Started

Follow these steps to run the project locally.

### Prerequisites
- Install the [Flutter SDK](https://docs.flutter.dev/get-started/install).
- Ensure your environment is set up for Android/iOS or Web development.

### Installation

1. **Clone the repository (if applicable) or navigate to the project directory:**
   ```bash
   cd countryscope
   ```

2. **Fetch dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the app:**
   ```bash
   flutter run
   ```

## 🌐 API Reference

This app consumes the [Public Countries GraphQL API](https://countries.trevorblades.com/graphql) for retrieving country data, continent details, and languages. Flag images are dynamically constructed using country codes and fetched from FlagCDN.

## 🛡️ Permissions

- The Android manifest already declares **Internet permissions** to execute remote GraphQL queries and load images.
