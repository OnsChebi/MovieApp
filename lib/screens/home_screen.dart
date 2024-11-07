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

    // Fetch movies after the first frame.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MovieProvider>(context, listen: false).fetchAllMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/logo.png',
          height: 200,
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 116, 16, 184),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // Implement search functionality here
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
      body: AnimatedContainer(
        transform: Matrix4.translationValues(xOffset, yOffset, 0)
          ..scale(isDrawerOpen ? 0.85 : 1.00)
          ..rotateZ(isDrawerOpen ? -50 : 0),
        duration: Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: isDrawerOpen ? BorderRadius.circular(40) : BorderRadius.circular(0),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // Movie Carousels
              SizedBox(height: 50),
              if (movieProvider.trendingMovies.isNotEmpty)
                MovieCarousel(
                  movies: movieProvider.trendingMovies,
                  title: 'Trending Movies',
                ),
              if (movieProvider.upcomingMovies.isNotEmpty)
                MovieCarousel(
                  movies: movieProvider.upcomingMovies,
                  title: 'Upcoming Movies',
                ),
              if (movieProvider.popularMovies.isNotEmpty)
                MovieCarousel(
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

class MovieSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = ''; // Reset the query input
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);
    final searchResults = movieProvider.popularMovies
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
            'https://image.tmdb.org/t/p/w500${movie.posterPath}', // Adjust the image URL
            width: 50,
            height: 75,
            fit: BoxFit.cover,
          ),
          title: Text(
            movie.title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);
    final suggestions = movieProvider.popularMovies
        .where((movie) => movie.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (suggestions.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final movie = suggestions[index];
        return ListTile(
          leading: Image.network(
            'https://image.tmdb.org/t/p/w500${movie.posterPath}',
            width: 50,
            height: 75,
            fit: BoxFit.cover,
          ),
          title: Text(
            movie.title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }
}
