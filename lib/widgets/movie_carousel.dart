import 'dart:ui';

import 'package:filmood/models/movies_model.dart';
import 'package:filmood/screens/movie_details.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MovieCarousel extends StatefulWidget {
  final List<MovieModel> movies;
  final String title;

  MovieCarousel({required this.movies, required this.title});

  @override
  _MovieCarouselState createState() => _MovieCarouselState();
}

class _MovieCarouselState extends State<MovieCarousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Dynamic Background Image
        Positioned.fill(
          child: Stack(
            fit: StackFit.expand,
            children: [
              widget.movies[_currentIndex].backdropPath != null
                  ? Image.network(
                      'https://image.tmdb.org/t/p/w500${widget.movies[_currentIndex].backdropPath}',
                      fit: BoxFit.cover,
                    )
                  : Container(
                      color: Colors.black, // Fallback color if no backdropPath
                    ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
              ],
          ),
        ),
        // Carousel with Movie Posters in Card
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                widget.title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            CarouselSlider(
              options: CarouselOptions(
                height: 300.0,
                autoPlay: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index; 
                  });
                },
              ),
              items: widget.movies.map((movie) {
                return Builder(
                  builder: (BuildContext context) {
                    return Column(
                      children: [
                        SizedBox(height: 40), 
                        Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                           child: GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MoviesDetailScreen(movie: movie),
        ),
      );
    },
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        'https://image.tmdb.org/t/p/w500${movie.posterPath}',
        height: 200,
        width: 150,
        fit: BoxFit.cover,
      ),
    ),
  ),
),
                      ],
                    );
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ],
    );
  }
}
