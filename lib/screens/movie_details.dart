import 'package:filmood/providers/movie_provider.dart';
import 'package:flutter/material.dart';
import 'package:filmood/models/movies_model.dart';
import 'package:provider/provider.dart';

class MoviesDetailScreen extends StatefulWidget {
  final MovieModel movie;

  const MoviesDetailScreen({super.key, required this.movie});


  @override
  State<MoviesDetailScreen> createState() => _MoviesDetailScreenState();
}


class _MoviesDetailScreenState extends State<MoviesDetailScreen> {
  bool isExpanded=false;
  @override
  void initState() {
    super.initState();
    final movieProvider = Provider.of<MovieProvider>(context, listen: false);
    movieProvider.getSimilarMovies(widget.movie.id); 
    
  }
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final String poster = 'https://image.tmdb.org/t/p/w500${widget.movie.backdropPath}';

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
                    widget.movie.title,
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
                        '${widget.movie.voteAverage}/10',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        'Release Date: ${widget.movie.releaseDate}',
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    isExpanded?widget.movie.overview ?? 'No description available.':
                    (widget.movie.overview?.substring(0, 100) ?? 'No description available.')+'...',
                    
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    child: Text(
                      isExpanded ?'See Less':'See More',
                      style: const TextStyle(color: Colors.blue),
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
                  _buildRelatedMoviesList(context),
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

  Widget _buildRelatedMoviesList(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);

    final List<MovieModel> SimilarMovies =movieProvider.movieSimilar;
    if (SimilarMovies.isEmpty) {
    return const Center(
      child: Text('No related movies available.'),
    );
  }

    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: SimilarMovies.length,
        itemBuilder: (context, index) {
          final movie = SimilarMovies[index];
          final posterPath = 'https://image.tmdb.org/t/p/w500${movie.posterPath}';
          return GestureDetector(
            onTap: () {
Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MoviesDetailScreen(movie: movie),
                  ),
                );
            },
          child: Container(
            width: 100,
            margin: const EdgeInsets.only(right: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    posterPath,
                    height: 120,
                    width: 100,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Container(
                          color: Colors.grey,
                          child: const Center(
                            child: Icon(Icons.image_not_supported),
                          ),
                        ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  movie.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}
}