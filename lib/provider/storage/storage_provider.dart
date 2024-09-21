import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageProvider extends ChangeNotifier {
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  String _token = '';
  String _userId = '';
  String _userName = '';
  String _userRole = '';

  String get token => _token;
  String get userId => _userId;
  String get userName => _userName;
  String get userRole => _userRole;

  void saveToken(String token) async {
    SharedPreferences value = await _pref;
    value.setString('token', token);
  }

  void saveUserId(String userId) async {
    SharedPreferences value = await _pref;
    value.setString('id', userId);
  }

  void saveUserName(String userName) async {
    SharedPreferences value = await _pref;
    value.setString('userName', userName);
  }

  void saveUserRole(String userRole) async {
    SharedPreferences value = await _pref;
    value.setString('userRole', userRole);
  }

  Future<String> getToken() async {
    SharedPreferences value = await _pref;
    if (value.containsKey('token')) {
      String data = value.getString('token')!;
      _token = data;
      notifyListeners();
      return data;
    } else {
      _token = '';
      notifyListeners();
      return '';
    }
  }

  Future<String> getUserId() async {
    SharedPreferences value = await _pref;
    if (value.containsKey('id')) {
      String data = value.getString('id')!;
      _userId = data;
      notifyListeners();
      return data;
    } else {
      _userId = '';
      notifyListeners();
      return '';
    }
  }

  Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userName');
  }

  Future<String> getUserRole() async {
    SharedPreferences value = await _pref;
    if (value.containsKey('userRole')) {
      String data = value.getString('userRole')!;
      _userRole = data;
      notifyListeners();
      return data;
    } else {
      _userRole = '';
      notifyListeners();
      return '';
    }
  }

  void logout() async {
    final value = await _pref;
    value.clear();
  }
}
