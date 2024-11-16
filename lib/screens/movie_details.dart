import 'package:flutter/material.dart';
import 'package:filmood/models/movies_model.dart';

class MoviesDetailScreen extends StatelessWidget {
  final MovieModel movie;

  const MoviesDetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final String poster = 'https://image.tmdb.org/t/p/w500${movie.posterPath}';

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                _buildMoviePoster(poster, screenHeight / 3),
                Positioned(
                  top: 30,
                  left: 16,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Positioned(
                  top: screenHeight / 3 - 40,
                  right: 16,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(12),
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () {
                      // Handle play action
                    },
                    child: const Icon(Icons.play_arrow, color: Colors.black),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        '${movie.voteAverage}/10',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        'Release Date: ${movie.releaseDate}',
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    movie.overview ?? 'No description available.',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Handle see more action
                    },
                    child: const Text(
                      'See More',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          // Handle add to watch later
                        },
                        icon: const Icon(Icons.add),
                        label: const Text('Add to Watch Later'),
                      ),
                      // const SizedBox(width: 16),
                      // ElevatedButton(
                      //   style: ElevatedButton.styleFrom(
                      //     shape: const CircleBorder(),
                      //     padding: const EdgeInsets.all(12),
                      //     backgroundColor: Colors.redAccent,
                      //   ),
                      //   onPressed: () {
                      //     // Handle add to favorites
                      //   },
                      //   child: const Icon(Icons.favorite, color: Colors.white),
                      // ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Related Movies',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildRelatedMoviesList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMoviePoster(String posterPath, double height) {
    return Image.network(
      posterPath,
      height: height,
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) =>
          const Center(child: Text('Image not available')),
    );
  }

  Widget _buildRelatedMoviesList() {
    // Replace with actual related movies list
    final List<String> SimilarMovies = List.generate(10, (index) => 'Movie $index');

    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: SimilarMovies.length,
        itemBuilder: (context, index) {
          return Container(
            width: 100,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey[200],
            ),
            child: Center(child: Text(SimilarMovies[index])),
          );
        },
      ),
    );
  }
}
