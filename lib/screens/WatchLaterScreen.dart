import 'package:filmood/providers/WatchLaterProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchLaterScreen extends StatelessWidget {
  final String userId;

  const WatchLaterScreen({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WatchLaterProvider(userId),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Watch Later'),
          backgroundColor: const Color.fromARGB(255, 250, 121, 0),
        ),
        body: Consumer<WatchLaterProvider>(
          builder: (context, watchlaterProvider, child) {
            return watchlaterProvider.watchLater.isEmpty
                ? const Center(
                    child: Text(
                      'No watch later movie added yet!',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  )
                : ListView.builder(
                    itemCount: watchlaterProvider.watchLater.length,
                    itemBuilder: (context, index) {
                      final movie = watchlaterProvider.watchLater[index];
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
                                    errorBuilder:
                                        (context, error, stackTrace) =>
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
                              watchlaterProvider.removeWatchLater(movie);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      '${movie.title} removed from watch later'),
                                  action: SnackBarAction(
                                    label: 'Undo',
                                    onPressed: () {
                                      watchlaterProvider.addWatchLater(movie);
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
      ),
    );
  }
}
