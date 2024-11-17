import 'package:filmood/models/movies_model.dart';
import 'package:filmood/screens/movie_grid_screen.dart';
import 'package:filmood/widgets/custom_list_tile.dart';
import 'package:filmood/widgets/horizontal_movie_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:filmood/providers/movie_provider.dart';
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
    // Fetching movies after initialization
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MovieProvider>(context, listen: false).fetchAllMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Access to the provider to retrieve movie data
    final movieProvider = Provider.of<MovieProvider>(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 116, 16, 184),
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
              // Toggle drawer
              if (isDrawerOpen) {
                xOffset = 0;
                yOffset = 0;
                isDrawerOpen = false;
              } else {
                xOffset = 200;
                yOffset = 10;
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
      //animation for the drawer
      body: AnimatedContainer(
        transform: Matrix4.translationValues(xOffset, yOffset, 0)
          // For the translation
          ..scale(isDrawerOpen ? 0.85 : 1.00)
          ..rotateZ(isDrawerOpen ? -50 : 0),
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: isDrawerOpen ? BorderRadius.circular(40) : BorderRadius.circular(0),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // Movie Carousels
              if (movieProvider.trendingMovies.isNotEmpty)
                MovieCarousel(
                  movies: movieProvider.trendingMovies,
                  title: '',
                ),
              if (movieProvider.upcomingMovies.isNotEmpty)
                _buildSection(
                context,
                title: 'Upcoming Movies',
                movies: movieProvider.upcomingMovies,
              ),
              // Horizontal List of Popular Movies
              if (movieProvider.popularMovies.isNotEmpty)
                _buildSection(
                  context,
                  movies: movieProvider.popularMovies,
                  title: 'Popular Movies',
                ),
            ],
          ),
        ),
      ),
    );
  }
}

 Widget _buildSection(BuildContext context, {required String title, required List<MovieModel> movies}) {
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
                color: Color.fromARGB(255, 116, 16, 184)
              ),
            ),
          ),
        ),
        HorizontalMovieList(movies: movies, title: ''),
      ],
    );
  }

//rsearch fct
class MovieSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = ''; // Clear the search input
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon:const  Icon(Icons.arrow_back), // Back to home page
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Retrieve movies for search result
    final movieProvider = Provider.of<MovieProvider>(context);
    //filtrartion selon search
    final searchResults = movieProvider.allMovies
        .where((movie) => movie.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (searchResults.isEmpty) {
      return Center(child: Text('No results found for: $query'));
    }

    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final movie = searchResults[index];
        return ListTile(
          leading: Image.network(
            'https://image.tmdb.org/t/p/w500${movie.posterPath}', 
            width: 50,
            height: 75,
            fit: BoxFit.cover,
          ),
          title: Text(
            movie.title,
            style:const  TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);
    final suggestions = movieProvider.allMovies
        .where((movie) => movie.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (suggestions.isEmpty) {
      return  const Center(
        child: CircularProgressIndicator());
    }

    return ListView.builder(
  padding: const EdgeInsets.all(8),
  itemCount: suggestions.length,
  itemBuilder: (context, index) {
    final movie = suggestions[index];
    return CustomListTile(
      movie: movie, // Pass the movie object directly
      height: 130,  // Adjust the height as needed
    );
  },
);

  }
}
