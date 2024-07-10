import 'dart:convert';

import 'package:buffalo_bar/config.dart';
import 'package:buffalo_bar/data/models/buffalo.dart';
import 'package:buffalo_bar/data/parsers/buffalo_parser.dart';
import 'package:flutter/services.dart';

class BuffaloService {
  final JSONBuffaloParser _parser = JSONBuffaloParser();
  final String _baseApi = mockDataPath;

  Future<List<Buffalo>> getAllBuffaloes() async {
    String path = '$_baseApi/scalps.json';
    try {
      final response = await rootBundle.loadString(path);
      var data = jsonDecode(response);
      return _parser.parseListOfBuffaloes(data);
    } catch (e) {
      rethrow;
    }
  }
}
