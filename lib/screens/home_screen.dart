// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:filmood/providers/movie_provider.dart';
import 'package:filmood/widgets/movie_carousel.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<MovieProvider>(context, listen: false).fetchAllMovies();
  }

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);

    return Scaffold(
      appBar: AppBar(
       title:const Text('Filmood'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
    );
  }
}
