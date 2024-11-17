// import 'package:filmood/models/movies_model.dart';
// import 'package:filmood/screens/movie_details.dart';
// import 'package:flutter/material.dart';

// class HorizontalMovieList extends StatelessWidget {
//   final List<MovieModel> movies;
//   final String title;

//   HorizontalMovieList({required this.movies, required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(
//             title,
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//         ),
//         SizedBox(
//           height: 200, // Height of the movie posters
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: movies.length,
//             itemBuilder: (context, index) {
//               final movie = movies[index];
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => MoviesDetailScreen(movie: movie),
//                       ),
//                     );
//                   },
//                   child: Column(
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(8),
//                         child: Image.network(
//                           'https://image.tmdb.org/t/p/w500${movie.posterPath}',
//                           width: 100,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'package:filmood/models/movies_model.dart';
import 'package:filmood/screens/movie_details.dart';
import 'package:flutter/material.dart';

class HorizontalMovieList extends StatelessWidget {
  final List<MovieModel> movies;
  final String title;

  const HorizontalMovieList({Key? key, required this.movies, this.title = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MoviesDetailScreen(movie: movie),
                      ),
                    );
              },
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                      height: 150,
                      width: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Center(child: Text('Image not available')),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Text(
                  //   movie.title,
                  //   maxLines: 1,
                  //   overflow: TextOverflow.ellipsis,
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

