import 'package:buffalo_bar/data/models/user.dart';

class JSONUserParser {
  User parseUser(Map<String, dynamic> json) {
    return User.fromJson(json);
  }

  List<User> parseListOfUsers(List jsonList) {
    return jsonList.map((json) => parseUser(json)).toList();
  }
}
