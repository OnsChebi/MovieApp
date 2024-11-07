import 'package:filmood/models/movies_model.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MovieCarousel extends StatelessWidget {
  final List<MovieModel> movies;
  final String title;

  MovieCarousel({required this.movies, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        CarouselSlider(
          options: CarouselOptions(height: 200.0, autoPlay: true),
          items: movies.map((movie) {
            return Builder(
              builder: (BuildContext context) {
                return Column(
                  children: [
                    Image.network(
                      'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 5),
                    Text(
                      movie.title,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                );
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
