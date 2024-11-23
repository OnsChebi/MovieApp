import 'package:filmood/screens/GenreScreen.dart';
import 'package:filmood/screens/movie_grid_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategorieScreen extends StatefulWidget {
  @override
  _CategorieScreenState createState() => _CategorieScreenState();
}

class _CategorieScreenState extends State<CategorieScreen> {
  List<dynamic> genres = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchGenres();
  }

  Future<void> fetchGenres() async {
    const String apiKey = 'fdceff17720035d6117544b1f21a75d4';
    const String url =
        'https://api.themoviedb.org/3/genre/movie/list?api_key=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          genres = data['genres'];
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        throw Exception('Failed to load genres');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error: $e');
    }
  }

  // Mapping genre names to icons (you can use different icons here)
  IconData getGenreIcon(String genreName) {
    switch (genreName.toLowerCase()) {
      case 'action':
        return Icons.flash_on;
      case 'comedy':
        return Icons.emoji_emotions;
      case 'drama':
        return Icons.theaters;
      case 'horror':
        return Icons.bedtime;
      case 'romance':
        return Icons.favorite;
      case 'science fiction':
        return Icons.fingerprint;
      default:
        return Icons.movie;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Categorie",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 116, 16, 184),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Set the number of columns
                  crossAxisSpacing: 10.0, // Space between columns
                  mainAxisSpacing: 10.0, // Space between rows
                  childAspectRatio: 1.0, // Aspect ratio for each item
                ),
                itemCount: genres.length,
                itemBuilder: (context, index) {
                  final genre = genres[index];
                  final genreName = genre['name'];
                  final genreId = genre['id'];

                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      onTap: () {
                        // Navigate to the genre-specific screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GenreScreen(
                              genreId:genreId,
                              genreName:genreName
                            ),
                          ),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(getGenreIcon(genreName),
                              size: 40, color: Colors.purple),
                          const SizedBox(height: 8),
                          Text(
                            genreName,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
