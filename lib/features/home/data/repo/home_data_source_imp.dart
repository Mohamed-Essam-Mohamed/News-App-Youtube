import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:news_app/core/api/result_api.dart';
import 'package:news_app/features/home/data/api/home_api.dart';
import 'package:news_app/features/home/data/models/news_dto.dart';
import 'package:news_app/features/home/domain/entities/news_entity.dart';
import 'package:news_app/features/home/domain/repo/home_data_source_interface.dart';

@Injectable(as: HomeDataSourceInterface)
class HomeDataSourceImp implements HomeDataSourceInterface {
  final HomeApi _api;
  HomeDataSourceImp(this._api);
  @override
  Future<ResultApi<NewsEntity>> getNews() async {
    final result = await _api.getNews();
    return switch (result) {
      Success<NewsDto>(data: final data) => Success(data.toEntity()),
      Failure(messageError: final error) => Failure(error),
    };
  }
}
