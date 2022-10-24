import 'dart:io';

import 'package:dio/dio.dart';
import 'package:omdb_movies_app/home/home.dart';

const _baseURL = 'https://www.omdbapi.com';
const _apiKey = 'ccbf6fd8';

class HttpRepository {
  HttpRepository() {
    _dio = Dio()
      ..options.baseUrl = _baseURL
      ..options.queryParameters = {'apiKey': _apiKey};
  }

  late final Dio _dio;

  Future<List<Movie>> searchMovies(String query) async {
    try {
      final response =
          await _dio.get<Map<String, dynamic>>('', queryParameters: {
        's': query,
        'page': 1,
      });
      if (response.data != null) {
        return SearchResult.fromJson(response.data!).movies;
      } else {
        return [];
      }
    } on FormatException catch (_) {
      throw const ApiException('Bad response format from server');
    } on SocketException catch (_) {
      throw const ApiException('Please check your internet connection');
    }
  }

  Future<Movie> getMovie(String movieID) async {
    try {
      final response =
          await _dio.get<Map<String, dynamic>>('', queryParameters: {
        'i': movieID,
      });
      return Movie.fromJson(response.data!);
    } on FormatException catch (_) {
      throw const ApiException('Bad response format from server');
    } on SocketException catch (_) {
      throw const ApiException('Please check your internet connection');
    }
  }
}

class ApiException {
  const ApiException(this.message);
  final String message;
}
