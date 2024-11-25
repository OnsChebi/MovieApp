import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filmood/models/movies_model.dart';
import 'package:flutter/material.dart';

class WatchLaterProvider with ChangeNotifier {
  List<MovieModel> _watchLater = [];
  final String userId;

  WatchLaterProvider(this.userId) {
    _loadWatchLater();
  }

  List<MovieModel> get watchLater => _watchLater;

  // Load the "Watch Later" movies from Firestore
  void _loadWatchLater() async {
    try {
      final docRef =
          FirebaseFirestore.instance.collection('watchlater').doc(userId);
      final snapshot = await docRef.collection('userwatchlater').get();

      _watchLater =
          snapshot.docs.map((doc) => MovieModel.fromJson(doc.data())).toList();
      notifyListeners();
    } catch (e) {
      print('Error loading "Watch Later" movies: $e');
    }
    print(_watchLater);
  }

  // Add a movie to "Watch Later" in Firestore
  void addWatchLater(MovieModel movie) async {
    if (userId.isEmpty || movie.id == null || movie.id.toString().isEmpty) {
      print('Error: Invalid userId or movie.id');
      print(userId);
      print(movie.id);
      return;
    }
    try {
      final docRef =
          FirebaseFirestore.instance.collection('watchlater').doc(userId);
      await docRef.collection('userwatchlater').doc(movie.id.toString()).set({
        'id': movie.id,
        'title': movie.title,
        'overview': movie.overview,
        'posterPath': movie.posterPath,
        'backdropPath': movie.backdropPath,
        'voteAverage': movie.voteAverage,
        'releaseDate': movie.releaseDate,
      });

      _watchLater.add(movie);
      notifyListeners();
    } catch (e) {
      print('Error adding movie to "Watch Later": $e');
    }
  }

  // Remove a movie from "Watch Later" in Firestore
  void removeWatchLater(MovieModel movie) async {
    try {
      final docRef =
          FirebaseFirestore.instance.collection('watchlater').doc(userId);
      await docRef
          .collection('userwatchlater')
          .doc(movie.id.toString())
          .delete();

      _watchLater.remove(movie);
      notifyListeners();
    } catch (e) {
      print('Error removing movie from "Watch Later": $e');
    }
  }

  // Check if the movie is already in the "Watch Later"
  bool isWatchLater(MovieModel movie) {
    return _watchLater.contains(movie);
  }
}
