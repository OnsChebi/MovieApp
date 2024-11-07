class MovieModel {
  final int id;
  final String title;
  final String? posterPath;
  final String? backdropPath;
  final String? overview;
  final String releaseDate;
  final double voteAverage;

 
  MovieModel({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.backdropPath,
    required this.overview,
    required this.releaseDate,
    required this.voteAverage,
  });

  // Factory method (pour creation des instances)
  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'] ?? 'No Title',
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'] ?? '',
      overview: json['overview'] ?? 'No Overview',
      releaseDate: json['release_date'] ?? 'Unknown',
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
    );
  }

  // Convert an instance to JSON (for saving locally wela for sending data)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'poster_path': posterPath,
      'overview': overview,
      'release_date': releaseDate,
      'vote_average': voteAverage,
      'backdrop_path': backdropPath,
    };
  }
}
