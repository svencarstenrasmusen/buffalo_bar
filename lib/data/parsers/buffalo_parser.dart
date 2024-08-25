import 'package:buffalo_bar/data/models/buffalo.dart';
import 'package:buffalo_bar/data/parsers/user_parser.dart';

class JSONBuffaloParser {
  final JSONUserParser userParser = JSONUserParser();

  Buffalo parseBuffalo(Map json) {
    return Buffalo(
        id: json['id'],
        scalper: userParser.parseUser(json['scalper']),
        snaggee: userParser.parseUser(json['snaggee']),
        dateTime: DateTime.parse(json['dateTime']));
  }

  List<Buffalo> parseListOfBuffaloes(List jsonList) {
    return jsonList.map((json) => parseBuffalo(json)).toList();
  }
}
