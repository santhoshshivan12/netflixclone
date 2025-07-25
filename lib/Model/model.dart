
import 'package:flutter/material.dart';

class Movie {
  final String title;
  final String image;
  final String rating;
  final String director;
  final String desc;
  final List<int> genreIds;
  final String backdropPath;
  final String releaseDate;
  final int id;
  String? trailerKey;

  Movie({
    required this.title,
    required this.image,
    required this.rating,
    required this.desc,
    required this.id,
    this.director = '',
    this.genreIds = const [],
    this.backdropPath = '',
    this.releaseDate = '',
    this.trailerKey,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      image: json['poster_path'] != null
          ? 'https://image.tmdb.org/t/p/w500${json['poster_path']}'
          : '',
      backdropPath: json['backdrop_path'] != null
          ? 'https://image.tmdb.org/t/p/original${json['backdrop_path']}'
          : '',
      rating: (json['vote_average'] ?? 0).toString(),
      desc: json['overview'] ?? '',
      genreIds: List<int>.from(json['genre_ids'] ?? []),
      releaseDate: json['release_date'] ?? '',
    );
  }
}

class Genre {
  final int id;
  final String name;

  Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }
}

List<String> time = [
  '8am',
  '11am',
  '1pm',
  '3pm',
  '6pm',
  '8pm'
];

List<Color> colors = [
  Colors.green,
  Colors.black,
  Colors.purple,
  Colors.amber,
  Colors.blueGrey,
  Colors.deepPurple,
  Colors.yellow,
];