import 'package:buffalo_bar/data/models/group.dart';
import 'package:buffalo_bar/data/models/user.dart';

class JSONGroupParser {
  Group parseGroup(Map<String, dynamic> json) {
    return Group.fromJson(json);
  }

  Group parseCreatedGroup(Map<String, dynamic> json) {
    return Group(
        id: json['id'],
        name: json['name'],
        createdAt: json['createdAt'],
        numMembers: json['numMembers']);
  }

  List<Group> parseListOfGroups(List jsonList) {
    return jsonList.map((json) => parseGroup(json)).toList();
  }

  User parsePlayerFromGroup(Map<String, dynamic> json) {
    return User.fromJson(json['player']);
  }

  List<User> parseLifOfPlayersFromGroup(List jsonList) {
    return jsonList.map((json) => parsePlayerFromGroup(json)).toList();
  }
}
