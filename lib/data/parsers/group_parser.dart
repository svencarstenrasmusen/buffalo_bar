import 'package:buffalo_bar/data/models/group.dart';

class JSONGroupParser {
  Group parseGroup(Map<String, dynamic> json) {
    return Group.fromJson(json);
  }

  List<Group> parseListOfGroups(List jsonList) {
    return jsonList.map((json) => parseGroup(json)).toList();
  }
}
