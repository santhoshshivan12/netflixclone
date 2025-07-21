import 'package:dio/dio.dart';
import '../Model/model.dart';

class MovieService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      headers: {
        'Authorization': 'Bearer YOUR_API_KEY',
        'accept': 'application/json',
      },
    ),
  );

  Future<List<Movie>> fetchTopRatedMovies({int page = 1}) async {
    try {
      final response = await _dio.get(
        '/discover/movie',
        queryParameters: {
          'include_adult': false,
          'include_video': false,
          'language': 'en-US',
          'page': page,
          'sort_by': 'vote_average.desc',
          'without_genres': '99,10755,10749',
          'vote_count.gte': 200,
        },
      );

      List<dynamic> results = response.data['results'];
      return results.map((json) => Movie.fromJson(json)).toList();
    } on DioException catch (e) {
      print('Dio error: ${e.response?.statusCode} - ${e.message}');
      return [];
    }
  }
}
