import 'dart:convert';

import 'package:buffalo_bar/config.dart';
import 'package:buffalo_bar/data/models/group.dart';
import 'package:buffalo_bar/data/parsers/group_parser.dart';
import 'package:dio/browser.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

class GroupService {
  final JSONGroupParser _parser = JSONGroupParser();
  final String _baseApi = mockDataPath;
  Dio dio = Dio();

  Future<List<Group>> getAllJoinedGroups({required String id}) async {
    String path = '$API_URL/api/v1/playerPack/packs/$id';

    BrowserHttpClientAdapter adapter = BrowserHttpClientAdapter();
    adapter.withCredentials = true;
    dio.httpClientAdapter = adapter;

    try {
      final response = await dio.get(path);
      return _parser.parseListOfGroups(response.data);
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
