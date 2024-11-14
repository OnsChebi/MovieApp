import 'package:flutter/material.dart';

class MovieDetails extends StatelessWidget {
  final String title;
  final String posterPath;
  final String overview;
  final String releaseDate;
  final double voteAverage;

  const MovieDetails({
    super.key,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.releaseDate,
    required this.voteAverage,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView( // To ensure everything scrolls when it's too long
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Movie poster image
          Container(
            height: 300,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.network(
                'https://image.tmdb.org/t/p/w500$posterPath', // Use passed posterPath
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(child: Text('Image not found'));
                },
              ),
            ),
          ),
          // Centered title
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              title, // Use passed title
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          // Overview section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
            child: Text(
              overview.isNotEmpty ? overview : 'No description available', // Use passed overview
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
                height: 1.5,
              ),
              textAlign: TextAlign.start,
              softWrap: true,
            ),
          ),
          // Movie details section (Release Date and Vote Average)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Release Date
                Row(
                  children: [
                    Icon(Icons.calendar_today, color: Colors.grey[700]),
                    SizedBox(width: 8),
                    Text(
                      releaseDate.isNotEmpty ? releaseDate : 'Release Date Unavailable',
                      style: TextStyle(color: Colors.grey[700], fontSize: 16),
                    ),
                  ],
                ),
                // Vote Average
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber),
                    SizedBox(width: 8),
                    Text(
                      voteAverage.toStringAsFixed(1),
                      style: TextStyle(color: Colors.grey[700], fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
