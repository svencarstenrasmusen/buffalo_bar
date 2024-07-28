import 'dart:convert';

import 'package:buffalo_bar/config.dart';
import 'package:buffalo_bar/data/models/group.dart';
import 'package:buffalo_bar/data/parsers/group_parser.dart';
import 'package:flutter/services.dart';

class GroupService {
  final JSONGroupParser _parser = JSONGroupParser();
  final String _baseApi = mockDataPath;

  Future<List<Group>> getAllJoinedGroups() async {
    String path = '$_baseApi/groups.json';
    try {
      final response = await rootBundle.loadString(path);
      var data = jsonDecode(response);
      return _parser.parseListOfGroups(data);
    } catch (e) {
      rethrow;
    }
  }
}
