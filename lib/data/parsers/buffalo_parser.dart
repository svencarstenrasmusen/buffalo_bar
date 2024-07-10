import 'package:buffalo_bar/data/models/buffalo.dart';

class JSONBuffaloParser {
  Buffalo parseBuffalo(Map json) {
    return Buffalo(
        id: json['id'],
        scalper: json['scalper'],
        snaggee: json['snaggee'],
        dateTime: DateTime.parse(json['dateTime']));
  }

  List<Buffalo> parseListOfBuffaloes(List jsonList) {
    return jsonList.map((json) => parseBuffalo(json)).toList();
  }
}
