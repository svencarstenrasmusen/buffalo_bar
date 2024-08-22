import 'dart:convert';

import 'package:buffalo_bar/config.dart';
import 'package:buffalo_bar/data/models/user.dart';
import 'package:buffalo_bar/data/parsers/user_parser.dart';
import 'package:dio/browser.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

class UserService {
  final Dio dio = Dio();
  final JSONUserParser _parser = JSONUserParser();
  final String _baseApi = mockDataPath;

  Future<User> login() async {
    String path = '$_baseApi/currentUser.json';
    try {
      final response = await rootBundle.loadString(path);
      var data = jsonDecode(response);
      return _parser.parseUser(data);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<User>> mockGetAllGroupUsers() async {
    String path = '$_baseApi/groupUsers.json';
    try {
      final response = await rootBundle.loadString(path);
      var data = jsonDecode(response);
      return _parser.parseListOfUsers(data);
    } catch (e) {
      throw Exception('Unexpected Error: ${e.toString()}');
    }
  }

  Future<List<User>> getAllUsers() async {
    String path = '$API_URL/api/v1/player/all';

    BrowserHttpClientAdapter adapter = BrowserHttpClientAdapter();
    adapter.withCredentials = true;
    dio.httpClientAdapter = adapter;

    try {
      final response = await dio.get(path);
      if (response.statusCode == 200) {
        return _parser.parseListOfUsers(response.data);
      } else {
        throw Exception('Unexpected error getting all players.');
      }
    } catch (e) {
      rethrow;
    }
  }
}
