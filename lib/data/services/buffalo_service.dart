import 'dart:convert';

import 'package:buffalo_bar/config.dart';
import 'package:buffalo_bar/data/models/buffalo.dart';
import 'package:buffalo_bar/data/parsers/buffalo_parser.dart';
import 'package:dio/browser.dart';
import 'package:dio/dio.dart';

class BuffaloService {
  final Dio dio = Dio();
  final JSONBuffaloParser _parser = JSONBuffaloParser();

  Future<List<Buffalo>> getAllBuffaloes() async {
    String path = '$API_URL/api/v1/buffalo/all';

    BrowserHttpClientAdapter adapter = BrowserHttpClientAdapter();
    adapter.withCredentials = true;
    dio.httpClientAdapter = adapter;

    try {
      final response = await dio.get(path);
      if (response.statusCode == 200) {
        return _parser.parseListOfBuffaloes(response.data);
      } else {
        throw Exception('Unexpected error getting ALL buffaloes.');
      }
    } catch (e) {
      rethrow;
    }
  }
}
