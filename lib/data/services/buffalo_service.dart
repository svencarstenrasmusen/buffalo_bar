import 'dart:convert';

import 'package:buffalo_bar/data/models/buffalo.dart';
import 'package:buffalo_bar/data/parsers/buffalo_parser.dart';
import 'package:buffalo_bar/environment_config.dart';
import 'package:dio/browser.dart';
import 'package:dio/dio.dart';

class BuffaloService {
  final Dio dio = Dio();
  final JSONBuffaloParser _parser = JSONBuffaloParser();

  Future<List<Buffalo>> getAllBuffaloes() async {
    String path = '$apiUrl/api/v1/buffalo/all';

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
    } on DioException catch (e) {
      if (e.response!.statusCode == 401) {
        throw 'Log in again.';
      } else if (e.response!.statusCode == 404) {
        throw 'No buffaloes found.';
      } else {
        rethrow;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> buffalo(
      {required String scalperId, required String snaggeeId}) async {
    String path = '$apiUrl/api/v1/buffalo/add';

    BrowserHttpClientAdapter adapter = BrowserHttpClientAdapter();
    adapter.withCredentials = true;
    dio.httpClientAdapter = adapter;

    var body = {
      'scalperId': scalperId,
      'snaggeeId': snaggeeId,
      'latitude': 0,
      'longitude': 0
    };

    try {
      final response = await dio.post(path, data: jsonEncode(body));
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Unexpected error getting ALL buffaloes.');
      }
    } on DioException catch (e) {
      if (e.response!.statusCode == 401) {
        throw 'Log in again.';
      } else if (e.response!.statusCode == 404) {
        throw 'No common groups found.';
      } else {
        rethrow;
      }
    } catch (e) {
      rethrow;
    }
  }
}
