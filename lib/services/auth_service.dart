import 'package:fazfinance/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService with ChangeNotifier {
  Box<UserModel>? _userBox;
  static const String _loggedInKey = 'isLoggedIn';
  Future<void> openBox() async {
    _userBox = await Hive.openBox('users');
  }

  Future<bool> registerUser(UserModel user) async {
    if (_userBox == null) {
      await openBox();
    }
    await _userBox!.add(user);

    notifyListeners();

    return true;
  }

  Future<UserModel?> loginUser(String email, String password) async {
    if (_userBox == null) {
      await openBox();
    }
    for (var user in _userBox!.values) {
      if (user.email == email && user.password == password) {
        await setLoggedInState(true, user.id);
        return user;
      }
    }
    return null;
  }

  Future<void> setLoggedInState(bool isLoggedIn, String id) async {
    final _pref = await SharedPreferences.getInstance();
    await _pref.setBool(_loggedInKey, isLoggedIn);
    await _pref.setString('id', id);
  }

  Future<bool> isUserLoggedIn() async {
    final _pref = await SharedPreferences.getInstance();
    return _pref.getBool(_loggedInKey) ?? false;
  }

 Future<UserModel?> getCurrentUser() async {
    
    final isLoggedIn = await isUserLoggedIn();

    if (isLoggedIn) {
      final loggedInUserId = await getLoggedInUserId();
     
      if (_userBox == null) {
        await openBox();
      }
      for (var user in _userBox!.values) {
    
        if (user.id == loggedInUserId) {
          return user;
        }
      }
    }
    return null;
  }


  Future<String?> getLoggedInUserId() async {
    final _pref = await SharedPreferences.getInstance();
    final id =  _pref.getString('id');
    return id;
  }


 Future<void> logout(BuildContext context) async {
    await setLoggedInState(false, ''); 
    Navigator.pushReplacementNamed(context, 'login');
  }

}
