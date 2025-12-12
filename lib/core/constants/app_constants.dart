class AppConstants {
  // App Info
  static const String appName = 'Movie Discovery';
  static const String appVersion = '1.0.0';
  
  // Hive Boxes
  static const String userPreferencesBox = 'user_preferences_box';
  static const String favoritesBox = 'favorites_box';
  static const String watchlistBox = 'watchlist_box';
  
  // Keys
  static const String isDarkModeKey = 'is_dark_mode';
  static const String languageKey = 'language';
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userIdKey = 'user_id';
  
  // Pagination
  static const int itemsPerPage = 20;
  static const int scrollThreshold = 200;
  
  // Cache Duration
  static const Duration cacheDuration = Duration(hours: 24);
  
  // Network
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const int maxRetries = 3;
}
