import 'package:filmood/models/movies_model.dart';
import 'package:filmood/screens/movie_details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GenreScreen extends StatefulWidget {
  final int genreId;
  final String genreName;

  const GenreScreen({Key? key, required this.genreId, required this.genreName})
      : super(key: key);

  @override
  _GenreScreenState createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  List<dynamic> movies = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMoviesByGenre();
  }

  Future<void> fetchMoviesByGenre() async {
    const String apiKey = 'fdceff17720035d6117544b1f21a75d4';
    final String url =
        'https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&with_genres=${widget.genreId}&sort_by=popularity.desc';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          movies = data['results'];
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        throw Exception('Failed to load movies');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Movies in Genre ${widget.genreName}',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 250, 121, 0),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                final title = movie['title'];
                final posterPath = movie['poster_path'];
                final overview = movie['overview'];
                final rating = movie['vote_average'].toString();

                return GestureDetector(
                  onTap: () {
                    // Navigate to MoviesDetailScreen with selected movie
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MoviesDetailScreen(
                          movie: MovieModel(
                            id: movie['id'],
                            title: movie['title'],
                            overview: movie['overview'],
                            posterPath: movie['poster_path'],
                            backdropPath: movie['backdrop_path'],
                            voteAverage: movie['vote_average'].toDouble(),
                            releaseDate: movie['release_date'],
                          ),
                        ),
                      ),
                    );
                  },
                  child: Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                          ),
                          child: posterPath != null
                              ? Image.network(
                                  'https://image.tmdb.org/t/p/w500/$posterPath',
                                  width: 100,
                                  height: 150,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  color: Colors.grey[300],
                                  width: 100,
                                  height: 150,
                                  child: const Icon(
                                    Icons.movie,
                                    size: 50,
                                    color: Colors.grey,
                                  ),
                                ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      rating,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  overview,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
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
