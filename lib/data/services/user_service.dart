import 'dart:convert';

import 'package:buffalo_bar/data/models/user.dart';
import 'package:buffalo_bar/data/parsers/user_parser.dart';
import 'package:buffalo_bar/environment_config.dart';
import 'package:dio/browser.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

class UserService {
  final Dio dio = Dio();
  final JSONUserParser _parser = JSONUserParser();

  Future<User> login() async {
    String path = '$mockDataPath/currentUser.json';
    try {
      final response = await rootBundle.loadString(path);
      var data = jsonDecode(response);
      return _parser.parseUser(data);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<User>> mockGetAllGroupUsers() async {
    String path = '$mockDataPath/groupUsers.json';
    try {
      final response = await rootBundle.loadString(path);
      var data = jsonDecode(response);
      return _parser.parseListOfUsers(data);
    } catch (e) {
      throw Exception('Unexpected Error: ${e.toString()}');
    }
  }

  Future<List<User>> getAllUsers() async {
    String path = '$apiUrl/api/v1/player/all';

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
    } on DioException catch (e) {
      if (e.response!.statusCode == 401) {
        throw 'Log in again.';
      } else {
        rethrow;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<User>> getFriends({required String userId}) async {
    String path = '$apiUrl/api/v1/playerPack/friends/$userId';

    BrowserHttpClientAdapter adapter = BrowserHttpClientAdapter();
    adapter.withCredentials = true;
    dio.httpClientAdapter = adapter;

    try {
      final response = await dio.get(path);
      if (response.statusCode == 200) {
        return _parser.parseListOfUsers(response.data);
      } else {
        throw Exception('Unexpected error getting friends.');
      }
    } on DioException catch (e) {
      if (e.response!.statusCode == 401) {
        throw 'Log in again.';
      } else if (e.response!.statusCode == 404) {
        throw 'Player not found.';
      } else {
        rethrow;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<User> getUserByUsername({required String username}) async {
    String path = '$apiUrl/api/v1/player/username/$username';

    BrowserHttpClientAdapter adapter = BrowserHttpClientAdapter();
    adapter.withCredentials = true;
    dio.httpClientAdapter = adapter;

    try {
      final response = await dio.get(path);
      if (response.statusCode == 200) {
        return _parser.parseUser(response.data);
      } else if (response.statusCode == 404) {
        throw Exception('User not found.');
      } else {
        throw Exception('Unexpected error finding a player by username.');
      }
    } on DioException catch (e) {
      if (e.response!.statusCode == 401) {
        throw 'Log in again.';
      } else if (e.response!.statusCode == 404) {
        throw 'Player not found.';
      } else {
        rethrow;
      }
    } catch (e) {
      rethrow;
    }
  }
}
