import 'package:dio/dio.dart';
import '../Model/model.dart';

class MovieService {
  late final Dio _dio;

  MovieService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.themoviedb.org/3',
        headers: {
          'Authorization': 'Bearer YOUR_API_KEY',
          'accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print('\n🌐 API Request:');
          print('URL: ${options.uri}');
          print('Method: ${options.method}');
          print('Headers: ${options.headers}');
          print('Query Parameters: ${options.queryParameters}');
          if (options.data != null) {
            print('Body: ${options.data}');
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print('\n✅ API Response:');
          print('Status Code: ${response.statusCode}');
          print('Headers: ${response.headers}');
          print('Response Data: ${response.data}');
          return handler.next(response);
        },
        onError: (error, handler) {
          print('\n❌ API Error:');
          print('Error: ${error.message}');
          print('Response: ${error.response?.data}');
          return handler.next(error);
        },
      ),
    );
  }

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
      final movies = results.map((json) => Movie.fromJson(json)).toList();
      
      // Fetch trailers for each movie
      for (var movie in movies) {
        movie.trailerKey = await fetchMovieTrailer(movie.id);
      }
      
      return movies;
    } on DioException catch (e) {
      print('Dio error: ${e.response?.statusCode} - ${e.message}');
      return [];
    }
  }

  Future<List<Movie>> searchMovies(String query, {String? genreId}) async {
    if (query.isEmpty && genreId == null) return [];
    
    try {
      final response = await _dio.get(
        '/search/movie',
        queryParameters: {
          'query': query,
          'include_adult': false,
          'language': 'en-US',
          'page': 1,
          if (genreId != null) 'with_genres': genreId,
        },
      );

      List<dynamic> results = response.data['results'];
      final movies = results.map((json) => Movie.fromJson(json)).toList();
      
      // Fetch trailers for each movie
      for (var movie in movies) {
        movie.trailerKey = await fetchMovieTrailer(movie.id);
      }
      
      return movies;
    } on DioException catch (e) {
      print('Search error: ${e.response?.statusCode} - ${e.message}');
      return [];
    }
  }

  Future<String?> fetchMovieTrailer(int movieId) async {
    try {
      print('Fetching trailer for movie ID: $movieId');
      final response = await _dio.get('/movie/$movieId/videos');
      final results = response.data['results'] as List;
      
      print('Found ${results.length} videos for movie ID: $movieId');
      
      // First try to find official trailer
      final officialTrailer = results.firstWhere(
        (video) => 
          video['type'].toString().toLowerCase() == 'trailer' && 
          video['site'].toString().toLowerCase() == 'youtube' &&
          video['official'] == true,
        orElse: () => null,
      );

      // If no official trailer, get any trailer
      final anyTrailer = results.firstWhere(
        (video) => 
          video['type'].toString().toLowerCase() == 'trailer' && 
          video['site'].toString().toLowerCase() == 'youtube',
        orElse: () => null,
      );

      // If no trailer, get any teaser
      final teaser = results.firstWhere(
        (video) => 
          video['type'].toString().toLowerCase() == 'teaser' && 
          video['site'].toString().toLowerCase() == 'youtube',
        orElse: () => null,
      );

      // If nothing else, get any YouTube video
      final anyVideo = results.firstWhere(
        (video) => video['site'].toString().toLowerCase() == 'youtube',
        orElse: () => null,
      );

      final video = officialTrailer ?? anyTrailer ?? teaser ?? anyVideo;
      
      if (video != null) {
        print('Selected video: ${video['name']} (${video['type']}) - Key: ${video['key']}');
        return video['key'].toString();
      } else {
        print('No suitable video found for movie ID: $movieId');
        return null;
      }
    } catch (e) {
      print('Error fetching trailer: $e');
      return null;
    }
  }

  Future<List<Movie>> fetchTrendingMovies({String timeWindow = 'day'}) async {
    try {
      final response = await _dio.get('/trending/movie/$timeWindow');
      List<dynamic> results = response.data['results'];
      final movies = results.map((json) => Movie.fromJson(json)).toList();
      
      // Fetch trailers for each movie
      for (var movie in movies) {
        movie.trailerKey = await fetchMovieTrailer(movie.id);
      }
      
      return movies;
    } on DioException catch (e) {
      print('Trending error: ${e.response?.statusCode} - ${e.message}');
      return [];
    }
  }

  Future<List<Movie>> fetchLatestReleases() async {
    try {
      final response = await _dio.get(
        '/movie/now_playing',
        queryParameters: {
          'language': 'en-US',
          'page': 1,
        },
      );
      List<dynamic> results = response.data['results'];
      final movies = results.map((json) => Movie.fromJson(json)).toList();
      
      // Fetch trailers for each movie
      for (var movie in movies) {
        movie.trailerKey = await fetchMovieTrailer(movie.id);
      }
      
      return movies;
    } on DioException catch (e) {
      print('Latest releases error: ${e.response?.statusCode} - ${e.message}');
      return [];
    }
  }

  Future<List<Movie>> fetchUpcomingMovies() async {
    try {
      final response = await _dio.get(
        '/movie/upcoming',
        queryParameters: {
          'language': 'en-US',
          'page': 1,
        },
      );
      List<dynamic> results = response.data['results'];
      final movies = results.map((json) => Movie.fromJson(json)).toList();
      
      // Fetch trailers for each movie
      for (var movie in movies) {
        movie.trailerKey = await fetchMovieTrailer(movie.id);
      }
      
      return movies;
    } on DioException catch (e) {
      print('Upcoming error: ${e.response?.statusCode} - ${e.message}');
      return [];
    }
  }

  Future<List<Genre>> fetchGenres() async {
    try {
      final response = await _dio.get('/genre/movie/list');
      List<dynamic> results = response.data['genres'];
      return results.map((json) => Genre.fromJson(json)).toList();
    } on DioException catch (e) {
      print('Genres error: ${e.response?.statusCode} - ${e.message}');
      return [];
    }
  }
}
