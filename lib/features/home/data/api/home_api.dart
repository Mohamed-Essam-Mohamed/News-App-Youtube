import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:news_app/core/api/result_api.dart';
import 'package:news_app/features/home/data/models/news_dto.dart';

class HomeApi {
  Future<ResultApi<NewsDto>> getNews() async {
    try {
      final url = Uri.https('newsapi.org', '/v2/everything', {
        'q': 'bitcoin',
        'apiKey': 'd3f2db7feec7495bb3f78db7f506f2ae',
      });

      final response = await http.get(url).timeout(Duration(seconds: 3));
      final body = jsonDecode(response.body);

      if (body is! Map<String, dynamic>) {
        return Failure('Invalid response received from the news service.');
      }
      if (response.statusCode < 200 || response.statusCode >= 300) {
        return Failure(
          body['message'] as String? ??
              'News service returned status ${response.statusCode}.',
        );
      }
      final data = NewsDto.fromJson(body);
      if (data.status != 'ok') {
        return Failure(
          body['message'] as String? ?? 'Unable to load news right now.',
        );
      }
      return Success<NewsDto>(data);
    } on SocketException {
      return Failure('No internet connection. Please try again.');
    } on HttpException {
      return Failure('Could not connect to the news service.');
    } on FormatException {
      return Failure('Invalid response received from the news service.');
    } on TimeoutException {
      return Failure('Request timed out. Please try again.');
    } catch (_) {
      return Failure('Unable to load news right now.');
    }
  }
}
