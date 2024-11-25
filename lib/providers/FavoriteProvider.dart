import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filmood/models/movies_model.dart';
import 'package:flutter/material.dart';

class FavoriteProvider with ChangeNotifier {
  List<MovieModel> _favorites = [];
  final String userId;

  FavoriteProvider(this.userId) {
    _loadFavorites();
  }

  List<MovieModel> get favorites => _favorites;

  // Load favorites from Firestore
  void _loadFavorites() async {
    try {
      final docRef = FirebaseFirestore.instance.collection('favorites').doc(userId);
      final snapshot = await docRef.collection('userFavorites').get();

      _favorites = snapshot.docs
          .map((doc) => MovieModel.fromJson(doc.data()))
          .toList();
      notifyListeners();
    } catch (e) {
      print('Error loading favorites: $e');
    }
  }

  // Add a movie to favorites in Firestore
  void addFavorite(MovieModel movie) async {
    try {
      final docRef = FirebaseFirestore.instance.collection('favorites').doc(userId);
      await docRef.collection('userFavorites').doc(movie.id.toString()).set({
        'id': movie.id,
        'title': movie.title,
        'overview': movie.overview,
        'posterPath': movie.posterPath,
        'backdropPath': movie.backdropPath,
        'voteAverage': movie.voteAverage,
        'releaseDate': movie.releaseDate,
      });
      _favorites.add(movie);
      notifyListeners();
    } catch (e) {
      print('Error adding favorite: $e');
    }
  }

  // Remove a movie from favorites in Firestore
  void removeFavorite(MovieModel movie) async {
    try {
      final docRef = FirebaseFirestore.instance.collection('favorites').doc(userId);
      await docRef.collection('userFavorites').doc(movie.id.toString()).delete();

      _favorites.remove(movie);
      notifyListeners();
    } catch (e) {
      print('Error removing favorite: $e');
    }
  }

  // Check if the movie is already in the favorites
  bool isFavorite(MovieModel movie) {
    return _favorites.contains(movie);
  }
}
