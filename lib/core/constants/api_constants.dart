class ApiConstants {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';
  static const String originalImageUrl = 'https://image.tmdb.org/t/p/original';
  
  // Endpoints
  static const String popularMovies = '/movie/popular';
  static const String topRatedMovies = '/movie/top_rated';
  static const String upcomingMovies = '/movie/upcoming';
  static const String nowPlayingMovies = '/movie/now_playing';
  static const String movieDetails = '/movie';
  static const String searchMovies = '/search/movie';
  static const String movieVideos = '/movie/{movie_id}/videos';
  static const String movieReviews = '/movie/{movie_id}/reviews';
  static const String movieCredits = '/movie/{movie_id}/credits';
  static const String genres = '/genre/movie/list';
  static const String discoverMovies = '/discover/movie';
  
  // Query parameters
  static const String apiKeyParam = 'api_key';
  static const String languageParam = 'language';
  static const String pageParam = 'page';
  static const String queryParam = 'query';
  static const String withGenresParam = 'with_genres';
  static const String sortByParam = 'sort_by';
  static const String yearParam = 'year';
  static const String voteAverageGteParam = 'vote_average.gte';
}
