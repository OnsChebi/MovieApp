import 'package:filmood/models/movies_model.dart';
import 'package:filmood/screens/movie_details.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final MovieModel movie; 
  final double height;

  const CustomListTile({
    Key? key,
    required this.movie,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          // Navigate to the movie details screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MoviesDetailScreen(movie: movie),
            ),
          );
        },
        child: SizedBox(
          height: height,
          child: Row(
            children: [
              
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                    width: 50, 
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      movie.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
