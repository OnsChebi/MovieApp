class ApiConstants {
  ApiConstants._();


  static const  String BASE_URL= 'https://api.themoviedb.org/3/';
  static const  String API_KEY = 'fdceff17720035d6117544b1f21a75d4';
  static const String BASE_IMAGE_URL ="https://image.tmdb.org/t/p/w500";


  static const String TRENDING_MOVIES = 'trending/movie/day';
  static const String UPCOMING_MOVIES = 'movie/upcoming';
  static const String POPULAR_MOVIES = 'movie/popular';
  static const String TOP_RATED_MOVIES = 'movie/top_rated';
  static const String ALL_MOVIES ='discover/movie';
  static const String NOW_PLAYING_MOVIES='movie/now_playing';
  static String SIMILAR_MOVIES(int movieId) {
    return 'movie/$movieId/recommendations';
  }
  // static String CAST(int movieId) {
  //   return 'movie/$movieId/credits';
  // }

}