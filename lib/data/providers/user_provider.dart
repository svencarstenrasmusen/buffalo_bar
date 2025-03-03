import 'package:buffalo_bar/data/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:buffalo_bar/data/models/user.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  bool _isLoading = false;

  User? get user => _user;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _user != null;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void unsetUser() {
    _user = null;
    notifyListeners();
  }

  Future<void> loginAndSetUser(UserService service) async {
    setLoading(true);
    try {
      User user = await service.login();
      setUser(user);
    } catch (e) {
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  @override
  String toString() {
    if (_user != null) {
      return 'Logged in User: ${_user!.username} with ID: ${_user!.id}';
    } else {
      return 'No user is logged in';
    }
  }
}
