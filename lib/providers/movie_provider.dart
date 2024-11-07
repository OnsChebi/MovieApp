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
        }
        notifyListeners();
      }
    } catch (e) {
      print('Failed to fetch $category movies: $e');
    }
  }

  // Fetch all categories on app load
  Future<void> fetchAllMovies() async {
    await fetchMovies(ApiConstants.TRENDING_MOVIES, 'trending');
    await fetchMovies(ApiConstants.UPCOMING_MOVIES, 'upcoming');
    await fetchMovies(ApiConstants.POPULAR_MOVIES, 'popular');
  }
}
