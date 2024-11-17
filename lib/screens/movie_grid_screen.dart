// import 'package:filmood/models/movies_model.dart';
// import 'package:filmood/screens/movie_details.dart';
// import 'package:flutter/material.dart';

// class MovieGridScreen extends StatelessWidget {
//   final List<MovieModel> movies;
//   final String category;

//   const MovieGridScreen({super.key, required this.movies, required this.category});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(category)),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: GridView.builder(
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 3, // Number of columns in the grid
//             mainAxisSpacing: 8.0,
//             crossAxisSpacing: 8.0,
//             childAspectRatio: 0.7, // Aspect ratio for each movie item
//           ),
//           itemCount: movies.length,
//           itemBuilder: (context, index) {
//             final movie = movies[index];
//             return GestureDetector(
//               onTap: () {
//                 // Pass movieId instead of the whole MovieModel object
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => MoviesDetailScreen(movie: movie), // Pass movieId
//                   ),
//                 );
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8),
//                   image: DecorationImage(
//                     fit: BoxFit.cover,
//                     image: NetworkImage('https://image.tmdb.org/t/p/w500${movie.posterPath}'),
//                   ),
//                 ),
//                 alignment: Alignment.bottomLeft,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     movie.title,
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                       backgroundColor: Colors.black54, // Adds a background to improve text visibility
//                     ),
//                     overflow: TextOverflow.ellipsis, // Truncate text if too long
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
import 'package:filmood/screens/movie_details.dart';
import 'package:flutter/material.dart';
import 'package:filmood/models/movies_model.dart';

class MovieGridScreen extends StatelessWidget {
  final List<MovieModel> movies;
  final String title;

  const MovieGridScreen({Key? key, required this.movies, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.7,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return GestureDetector(
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
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Center(child: Text('Image not available')),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  movie.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
