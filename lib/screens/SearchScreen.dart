import 'dart:convert';
import 'package:filmood/models/movies_model.dart';
import 'package:http/http.dart' as http;
import 'package:filmood/screens/movie_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:filmood/providers/movie_provider.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Movies'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: MovieSearchDelegate());
            },
          ),
        ],
      ),
      body: Consumer<MovieProvider>(
        builder: (context, movieProvider, child) {
          if (movieProvider.allMovies.isEmpty) {
            return const Center(
              child: Text('No movies available'),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: movieProvider.allMovies.length,
            itemBuilder: (context, index) {
              final movie = movieProvider.allMovies[index];
              return ListTile(
                leading: Image.network(
                  'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                  width: 50,
                  height: 75,
                  fit: BoxFit.cover,
                ),
                title: Text(
                  movie.title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MoviesDetailScreen(movie: movie),
                      ));
                },
              );
            },
          );
        },
      ),
    );
  }
}

class MovieSearchDelegate extends SearchDelegate {
  final String apiKey =
      '524ed2bf84ff25bf919ce898133917b3'; // Replace with your TMDb API key

  // Fetch movies from TMDb based on the query
  Future<List<dynamic>> fetchMovies(String query) async {
    final url =
        'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$query';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results']; // Return the list of movies
    } else {
      throw Exception('Failed to fetch movies');
    }
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      final movieProvider = Provider.of<MovieProvider>(context, listen: false);
      final popularMovies = movieProvider.topRatedMovies;

      return ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: popularMovies.length,
        itemBuilder: (context, index) {
          final movie = popularMovies[index];
          return ListTile(
            leading: Image.network(
              'https://image.tmdb.org/t/p/w500${movie.posterPath}',
              width: 50,
              height: 75,
              fit: BoxFit.cover,
            ),
            title: Text(
              movie.title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              close(context, movie);
            },
          );
        },
      );
    }

    return FutureBuilder<List<dynamic>>(
      future: fetchMovies(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.data == null || snapshot.data!.isEmpty) {
          return Center(
            child: Text('No results found for "$query"'),
          );
        } else {
          final movies = snapshot.data!;
          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              final posterPath = movie['poster_path'];
              return ListTile(
                leading: posterPath != null
                    ? Image.network(
                        'https://image.tmdb.org/t/p/w500$posterPath',
                        width: 50,
                        height: 75,
                        fit: BoxFit.cover,
                      )
                    : const Icon(Icons.movie, size: 50),
                title: Text(
                  movie['title'] ?? 'No Title',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Release Date: ${movie['release_date'] ?? 'N/A'}',
                  style: const TextStyle(color: Colors.grey),
                ),
                onTap: () {
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
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Show the top-rated movies as default suggestions
    final movieProvider = Provider.of<MovieProvider>(context, listen: false);
    final popularMovies = movieProvider.topRatedMovies;

    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: popularMovies.length,
      itemBuilder: (context, index) {
        final movie = popularMovies[index];
        return ListTile(
          leading: Image.network(
            'https://image.tmdb.org/t/p/w500${movie.posterPath}',
            width: 50,
            height: 75,
            fit: BoxFit.cover,
          ),
          title: Text(
            movie.title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          onTap: () {
            close(context, movie);
          },
        );
      },
    );
  }
}
