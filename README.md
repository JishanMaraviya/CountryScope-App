<div align="center">

# 🌍 CountryScope App

### Discover & Explore Countries — Built with Flutter & GraphQL

*A modern, highly responsive Flutter application that helps users discover countries, view detailed geographical information, and manage their favorite destinations locally.*

<br/>

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Riverpod](https://img.shields.io/badge/Riverpod-0553B1?style=for-the-badge&logo=flutter&logoColor=white)
![GraphQL](https://img.shields.io/badge/GraphQL-E10098?style=for-the-badge&logo=graphql&logoColor=white)
![SQLite](https://img.shields.io/badge/SQLite-003B57?style=for-the-badge&logo=sqlite&logoColor=white)

![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web-blue?style=flat-square)
![Architecture](https://img.shields.io/badge/Architecture-Riverpod-0553B1?style=flat-square)
![Status](https://img.shields.io/badge/Status-Active-brightgreen?style=flat-square)

</div>

---

## 📖 Overview

**CountryScope** is a comprehensive geographical companion app that helps users explore countries across the world using the public Countries GraphQL API. It features an intuitive user interface to view country details, filter by continents, and manage personal offline favorites. Powered by **Hive-backed GraphQL caching** and **SQLite**, it offers a fast, real-time search experience, dynamic theming, and responsive layouts that adapt beautifully to both phones and tablets.

---

## 🌟 Key Features

- **🌍 Explore Countries** — Discover a wide range of countries, explore them continent-wise, and read detailed information for each location.
- **🔍 Advanced Filtering & Search** — Search for countries locally in real-time and filter destinations by continent.
- **💾 Offline Favorites** — Save your favorite countries locally using an offline SQLite database for easy access anytime.
- **🌓 Dynamic Theming** — Built-in Light, Dark, and System default mode support (`shared_preferences` & **Riverpod**) with Material 3 Dynamic Colors for an enhanced viewing experience.
- **⚡ High Performance** — Features normalized Hive-backed caching for GraphQL queries and `cached_network_image` for blazing-fast flag image loading from FlagCDN.
- **✨ Beautiful UI & Animations** — Enjoy smooth hero transitions, loading shimmers, beautifully designed empty/error states, and motion animations powered by `flutter_animate`.
- **📱 Responsive & Accessible** — Adapts to both phone and tablet layouts seamlessly with accessible controls.

---

## 🛠️ Tech Stack & Libraries

- **Framework:** [Flutter](https://flutter.dev/) (SDK ^3.10.4)
- **State Management:** [Riverpod](https://riverpod.dev/) (`flutter_riverpod`)
- **Networking & API:** [GraphQL](https://pub.dev/packages/graphql_flutter) (`graphql_flutter`, `gql`)
- **Navigation:** [GoRouter](https://pub.dev/packages/go_router)
- **Local Storage:** `sqflite` (Favorites), `shared_preferences` (Theming)
- **UI & Animations:** `dynamic_color`, `flutter_animate`, `cached_network_image`

---

## 📁 Folder Structure

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

---

## 🚀 Getting Started

### Prerequisites
- Install the [Flutter SDK](https://docs.flutter.dev/get-started/install).

### Installation

1. **Clone the repository:**
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

---

## 🌐 API Reference

This app consumes the [Public Countries GraphQL API](https://countries.trevorblades.com/graphql) for retrieving country data. Flag images are dynamically constructed using country codes and fetched from FlagCDN.

---

## 🛡️ Permissions

- The Android manifest declares **Internet permissions** to execute remote GraphQL queries and load images.
