import 'package:filmood/models/movies_model.dart';
import 'package:flutter/material.dart';
import 'package:filmood/services/tmdb_api.dart';
import 'package:filmood/utils/api_constants.dart';
import 'package:http/http.dart';

class MovieProvider with ChangeNotifier {
  final TmdbApi _apiService = TmdbApi(Client());

//initializing categories
  List<MovieModel> trendingMovies = [];
  List<MovieModel> upcomingMovies = [];
  List<MovieModel> popularMovies = [];
  List<MovieModel> topRatedMovies = [];
  List<MovieModel> nowPlayingMovies = [];
  List<MovieModel> movieDetails = [];
  List<MovieModel> movieSimilar = [];
  List<MovieModel> allMovies = [];
  

Future<void> getSimilarMovies(int id) async {
  try {
    final data = await _apiService.fetchSimilarMovies(id);
    if (data != null && data['results'] != null) {
      final movies = (data['results'] as List)
          .map((movieJson) => MovieModel.fromJson(movieJson))
          .toList();
      movieSimilar = movies;
      notifyListeners();
    } else {
      movieSimilar = []; 
      notifyListeners();
    }
  } catch (e) {
    movieSimilar = []; 
    notifyListeners();
  }
}





  // Fetching movies 
  Future<void> fetchMovies(String path, String category) async {
    try {
      final data = await _apiService.get(path);
      if (data['results'] != null) {
        final movies = (data['results'] as List)
            .map((movieJson) => MovieModel.fromJson(movieJson))
            .toList();

        switch (category) {
          case 'trending':
            trendingMovies = movies;
            break;
          case 'upcoming':
            upcomingMovies = movies;
            break;
          case 'popular':
            popularMovies = movies;
            break;
            case 'top_rated':
            topRatedMovies = movies;
            break;
            case 'now_playing':
            nowPlayingMovies = movies;
            break;
            case 'similar':
            nowPlayingMovies = movies;
            break;
            case 'all':
            allMovies = movies;
            break;
        }
        notifyListeners();
      }
    } catch (e) {
      //print('Failed to fetch $category movies: $e');
    }
  }

  // Fetch all categories on app load
  Future<void> fetchAllMovies() async {
    await fetchMovies(ApiConstants.TRENDING_MOVIES, 'trending');
    await fetchMovies(ApiConstants.UPCOMING_MOVIES, 'upcoming');
    await fetchMovies(ApiConstants.POPULAR_MOVIES, 'popular');
    await fetchMovies(ApiConstants.TOP_RATED_MOVIES, 'top_rated');
    await fetchMovies(ApiConstants.NOW_PLAYING_MOVIES, 'now_playing');
    await fetchMovies(ApiConstants.ALL_MOVIES, 'all');

  }
}
