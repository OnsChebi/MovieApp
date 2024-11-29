import 'package:filmood/providers/FavoriteProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  final String userId;

  const FavoriteScreen({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        backgroundColor: const Color.fromARGB(255, 250, 121, 0),
      ),
      body: Consumer<FavoriteProvider>(
        builder: (context, favoriteProvider, child) {
          return favoriteProvider.favorites.isEmpty
              ? const Center(
                  child: Text(
                    'No favorites added yet!',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                )
              : ListView.builder(
                  itemCount: favoriteProvider.favorites.length,
                  itemBuilder: (context, index) {
                    final movie = favoriteProvider.favorites[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 10.0),
                      child: ListTile(
                        leading: movie.posterPath != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.movie, size: 50),
                                ),
                              )
                            : const Icon(Icons.movie, size: 50),
                        title: Text(
                          movie.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          movie.overview ?? 'No description available',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            favoriteProvider.removeFavorite(movie);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    '${movie.title} removed from favorites'),
                                action: SnackBarAction(
                                  label: 'Undo',
                                  onPressed: () {
                                    favoriteProvider.addFavorite(movie);
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
