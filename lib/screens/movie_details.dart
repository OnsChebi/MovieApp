import 'package:flutter/material.dart';
import 'package:filmood/models/movies_model.dart';

class MoviesDetailScreen extends StatelessWidget {
  final MovieModel movie;

  const MoviesDetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    String poster = 'https://image.tmdb.org/t/p/w500${movie.posterPath}';

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMovieImage(poster),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMovieTitle(movie.title),
                  const SizedBox(height: 10),
                  _buildMovieOverview(movie.overview),
                  const SizedBox(height: 20),
                  _buildMovieInfo(movie),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMovieImage(String posterPath) {
    return Stack(
      children: [
        Image.network(
          posterPath,
          height: 400,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
              const Center(child: Text('Image not available')),
        ),
        Positioned(
          top: 30,
          left: 16,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
             // Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMovieTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildMovieOverview(String? overview) {
    return Text(
      overview ?? 'No description available.',
      style: const TextStyle(
        fontSize: 16,
        color: Colors.grey,
        height: 1.5,
      ),
    );
  }

  Widget _buildMovieInfo(MovieModel movie) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow('Release Date:', movie.releaseDate),
        _buildInfoRow('Rating:', '${movie.voteAverage}/10'),
      ],
    );
  }

  Widget _buildInfoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: RichText(
        text: TextSpan(
          text: '$label ',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
          children: [
            TextSpan(
              text: value ?? 'Unknown',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
