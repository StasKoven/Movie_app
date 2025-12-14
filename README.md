# 🎬 Movie Discovery App

A comprehensive Flutter application for discovering movies, built with Clean Architecture, BLoC state management, and modern development practices.

![Flutter](https://img.shields.io/badge/Flutter-3.24.0+-02569B?style=for-the-badge&logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.10.0+-0175C2?style=for-the-badge&logo=dart)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

## 📱 About The Project

**Movie Discovery** - Full-featured mobile application for browsing and discovering movies using The Movie Database (TMDB) API. Built with Flutter following Clean Architecture principles, BLoC pattern for state management, and offline-first approach.

### 🎯 Обрана тема

**Movie Discovery** - Додаток для пошуку та перегляду фільмів з можливістю:
- Перегляду популярних, топ-рейтингових та майбутніх фільмів
- Пошуку за назвою з фільтрацією за жанром та рейтингом
- Збереження улюблених фільмів для офлайн-перегляду
- Перегляду деталей фільмів з трейлерами та відгуками
- Автентифікації через Firebase

## ✨ Features

- 🔥 **Movies Catalog**: Popular, Top Rated, Upcoming
- 🔍 **Advanced Search**: Filter by genre, year, rating
- ❤️ **Favorites Management**: Save and manage favorite movies offline
- 📱 **Offline-First**: Works without internet with cached data
- 🎥 **Movie Details**: Trailers (YouTube), reviews, cast info
- 🔐 **Authentication**: Firebase Auth with login/register

## 🏗️ Архітектура

### Clean Architecture (3 Layers)
- **Presentation**: BLoC, Pages, Widgets
- **Domain**: Use Cases, Entities, Repository Interfaces
- **Data**: Models, Data Sources, Repository Implementation

### 📁 Структура проекту

```
movie_discovery/
├── lib/
│   ├── core/                    # Utilities, constants, DI
│   │   ├── constants/          # App colors, strings, etc.
│   │   ├── di/                 # Dependency injection
│   │   ├── errors/             # Error handling
│   │   ├── network/            # Network configuration
│   │   └── usecase/            # Base use case
│   ├── features/               # Feature modules
│   │   ├── auth/              # Authentication
│   │   │   ├── data/
│   │   │   ├── domain/
│   │   │   └── presentation/
│   │   ├── home/              # Home screen with movies
│   │   │   ├── data/
│   │   │   ├── domain/
│   │   │   └── presentation/
│   │   ├── favorites/         # Favorites management
│   │   │   ├── data/
│   │   │   ├── domain/
│   │   │   └── presentation/
│   │   └── profile/           # User profile
│   │       └── presentation/
│   ├── shared/                # Shared widgets/models
│   │   └── widgets/
│   ├── firebase_options.dart
│   └── main.dart
├── test/                      # Unit + Widget tests
│   ├── features/
│   │   ├── auth/
│   │   └── home/
│   └── shared/
├── integration_test/          # E2E tests
│   └── app_test.dart
├── .github/                   # CI/CD workflows
│   └── workflows/
│       └── flutter_ci.yml
├── assets/                    # Images, fonts
├── .env                       # Environment variables
├── README.md                  # Project documentation
└── pubspec.yaml               # Dependencies
```

### State Management: BLoC Pattern
- flutter_bloc ^8.1.6
- Event-driven architecture
- Global state management

### Dependency Injection: GetIt + Injectable
- Service locator pattern
- Code generation
- Lazy singletons

## 🌐 API Integration & Local Storage

- **TMDB API**: Movie data, search, details
- **Dio**: HTTP client with interceptors & logging
- **Offline-first caching**: 
  - **Drift (SQLite)** - Primary movie data cache with 1-hour freshness
  - **Hive** - Favorites + user preferences
  - **flutter_secure_storage** - API keys, tokens
- **Error handling**: Retry mechanisms with fallback to cache

**Test Types:**
- ✅ Unit tests (domain use cases)
- ✅ Widget tests (UI components)
- ✅ BLoC tests (state management)
- 📝 Integration tests (E2E flows)

## 🚀 CI/CD Pipeline

GitHub Actions automatically:
1. ✅ Analyze code & check formatting
2. ✅ Run all tests with coverage
3. ✅ Build APK/iOS with **code obfuscation**
4. ✅ Deploy web build

## 🛠️ Setup Instructions

### Prerequisites

- Flutter SDK ^3.24.0
- Dart SDK ^3.10.0
- Android Studio / Xcode (for mobile)
- Chrome (for web)

### Installation Steps

1. **Clone repository**
   ```bash
   git clone https://github.com/yourusername/movie_discovery.git
   cd movie_discovery
   ```

2. **Environment Configuration**
   
   Create `.env` file in project root:
   ```env
   TMDB_API_KEY=your_api_key_here
   BASE_URL=https://api.themoviedb.org/3
   IMAGE_BASE_URL=https://image.tmdb.org/t/p
   ```
   
   Get your API key from [TMDB](https://www.themoviedb.org/settings/api)

3. **Firebase Setup**
   
   - Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
   - Add Android app: Download `google-services.json` → place in `android/app/`
   - Add iOS app: Download `GoogleService-Info.plist` → place in `ios/Runner/`
   - Enable Authentication → Email/Password in Firebase Console


### Building Release APK

```bash
# Build with obfuscation
flutter build apk --release --obfuscate --split-debug-info=build/app/outputs/symbols

# APK location
build/app/outputs/flutter-apk/app-release.apk
```

## 📦 Key Dependencies

- flutter_bloc ^8.1.6
- get_it ^8.0.2
- dio ^5.7.0
- hive ^2.2.3
- drift ^2.22.0
- firebase_auth ^5.3.4
- cached_network_image ^3.4.1


## 🙏 Acknowledgments

- [TMDB API](https://www.themoviedb.org/documentation/api) for movie data
- [Flutter](https://flutter.dev) framework
- [BLoC Library](https://bloclibrary.dev) for state management
- [Firebase](https://firebase.google.com) for authentication
