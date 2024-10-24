import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../services/database_helper.dart';

class UserProvider with ChangeNotifier {
  User? _user;

  // get instance for getter
  final dbHelper = DatabaseHelper.instance;

  User? get user => _user;

  // function to load current user data
  Future<void> loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('userId');
    if (userId != null) {
      User? fetchedUser = await dbHelper.getCurrentUser(userId);
      _user = fetchedUser;
      notifyListeners();
    }
  }

  // update User
  void updateUser(User user) {
    _user = user;
    notifyListeners();
  }
}
