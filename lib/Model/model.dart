
import 'package:flutter/material.dart';

class Movie {
  final String title;
  final String image;
  final String rating;
  final String director;
  final String desc; // Placeholder (optional)

  Movie({
    required this.title,
    required this.image,
    required this.rating,
    required this.desc, // Placeholder (optional)
    this.director = '',
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'] ?? '',
      image: json['poster_path'] != null
          ? 'https://image.tmdb.org/t/p/w500${json['poster_path']}'
          : '',
      rating: json['vote_average'].toString(),
      desc: json['overview'] ?? '',
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