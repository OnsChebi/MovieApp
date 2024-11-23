import 'package:filmood/screens/CategorieScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:filmood/providers/movie_provider.dart';
import 'package:filmood/models/movies_model.dart';
import 'package:filmood/screens/movie_grid_screen.dart';
import 'package:filmood/widgets/custom_list_tile.dart';
import 'package:filmood/widgets/horizontal_movie_list.dart';
import 'package:filmood/widgets/movie_carousel.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double xOffset = 0;
  double yOffset = 0;
  bool isDrawerOpen = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MovieProvider>(context, listen: false).fetchAllMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 121, 0),
      appBar: AppBar(
        title: Image.asset(
          'assets/logo.png',
          height: 200,
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 116, 16, 184),
        actions: [
          IconButton(
            icon:const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // Search button
              showSearch(
                context: context,
                delegate: MovieSearchDelegate(),
              );
            },
          ),
        ],
        leading: GestureDetector(
          onTap: () {
            setState(() {
              if (isDrawerOpen) {
                xOffset = 0;
                yOffset = 0;
                isDrawerOpen = false;
              } else {
                xOffset = 200;
                yOffset = 50;
                isDrawerOpen = true;
              }
            });
          },
          child: Icon(
            isDrawerOpen ? Icons.arrow_back_ios : Icons.menu,
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          // Drawer Menu
          Container(
            padding: const EdgeInsets.only(top: 50, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategorieScreen(),
                      ),
                    );
                  },
                  child: const Text("Categorie"),
                ),
              ],
            ),
          ),
          // Main Content
          AnimatedContainer(
            transform: Matrix4.translationValues(xOffset, yOffset, 0)
              ..scale(isDrawerOpen ? 0.85 : 1.00),
            duration: const Duration(milliseconds: 250),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: isDrawerOpen
                  ? BorderRadius.circular(20)
                  : BorderRadius.circular(0),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  // Movie Carousels
                  if (movieProvider.trendingMovies.isNotEmpty)
                    MovieCarousel(
                      movies: movieProvider.trendingMovies,
                      title: 'Trending Now',
                    ),
                  if (movieProvider.upcomingMovies.isNotEmpty)
                    _buildSection(
                      context,
                      title: 'Upcoming Movies',
                      movies: movieProvider.upcomingMovies,
                    ),
                  if (movieProvider.popularMovies.isNotEmpty)
                    _buildSection(
                      context,
                      title: 'Popular Movies',
                      movies: movieProvider.popularMovies,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context,
      {required String title, required List<MovieModel> movies}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieGridScreen(
                    title: title,
                    movies: movies,
                  ),
                ),
              );
            },
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 116, 16, 184),
              ),
            ),
          ),
        ),
        HorizontalMovieList(movies: movies),
      ],
    );
  }
}

