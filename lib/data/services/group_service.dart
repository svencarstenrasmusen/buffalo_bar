import 'dart:convert';

import 'package:buffalo_bar/config.dart';
import 'package:buffalo_bar/data/models/group.dart';
import 'package:buffalo_bar/data/models/user.dart';
import 'package:buffalo_bar/data/parsers/group_parser.dart';
import 'package:dio/browser.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GroupService {
  final JSONGroupParser _parser = JSONGroupParser();
  final String _baseApi = mockDataPath;
  Dio dio = Dio();
  String apiURL = dotenv.get('API_URL');

  Future<List<Group>> getAllJoinedGroups({required String id}) async {
    String path = '$apiURL/api/v1/playerPack/packs/$id';

    BrowserHttpClientAdapter adapter = BrowserHttpClientAdapter();
    adapter.withCredentials = true;
    dio.httpClientAdapter = adapter;

    try {
      final response = await dio.get(path);
      return _parser.parseListOfGroups(response.data);
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

  Future<List<User>> getAllPlayersFromGroupId({required String id}) async {
    String path = '$apiURL/api/v1/playerPack/players/$id';

    BrowserHttpClientAdapter adapter = BrowserHttpClientAdapter();
    adapter.withCredentials = true;
    dio.httpClientAdapter = adapter;

    try {
      final response = await dio.get(path);
      return _parser.parseLifOfPlayersFromGroup(response.data);
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

  Future<Group> createNewGroup(
      {required String name, required String playerId}) async {
    String path = '$apiURL/api/v1/pack';

    BrowserHttpClientAdapter adapter = BrowserHttpClientAdapter();
    adapter.withCredentials = true;
    dio.httpClientAdapter = adapter;

    var body = {'name': name, 'playerId': playerId};

    try {
      final response = await dio.post(path, data: jsonEncode(body));
      if (response.statusCode == 200) {
        return _parser.parseCreatedGroup(response.data);
      } else {
        throw Exception('Unexpected error creating group.');
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

  Future<bool> addPlayerToGroup(
      {required String playerId,
      required String groupId,
      required bool isAdmin}) async {
    String path = '$apiURL/api/v1/playerPack';

    BrowserHttpClientAdapter adapter = BrowserHttpClientAdapter();
    adapter.withCredentials = true;
    dio.httpClientAdapter = adapter;

    var body = {'playerId': playerId, 'packId': groupId, 'isAdmin': isAdmin};

    try {
      final response = await dio.post(path, data: jsonEncode(body));
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Unexpected error adding player to group.');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Group> getGroupById({required String id}) async {
    String path = '$_baseApi/$id';
    try {
      final response = await rootBundle.loadString(path);
      var data = jsonDecode(response);
      return _parser.parseGroup(data);
    } catch (e) {
      rethrow;
    }
  }
}
