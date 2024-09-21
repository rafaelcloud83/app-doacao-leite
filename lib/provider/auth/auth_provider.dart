import 'dart:convert';
import 'dart:io';

import 'package:doacao_leite/models/user/user_model.dart';
import 'package:doacao_leite/provider/storage/storage_provider.dart';
import 'package:doacao_leite/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthenticationProvider extends ChangeNotifier {
  final requestBaseUrl = AppUrl.baseURL;

  bool _isLoading = false;
  String _resMessage = '';

  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;

  void loginUser({
    required String email,
    required String password,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    String url = '$requestBaseUrl/auth/login';

    UserModel user = UserModel(email: email, password: password);

    try {
      http.Response response = await http.post(
        Uri.parse(url),
        body: user.toJson(),
        headers: {
          "Content-type": "application/json; charset=UTF-8",
        },
      );

      if (response.statusCode == 201) {
        _isLoading = false;
        _resMessage = 'success';
        notifyListeners();
        Map<String, dynamic> map = jsonDecode(response.body);
        String token = map['token'];
        String userId = map['userId'];
        String userName = map['userName'];
        String userRole = map['userRole'];
        StorageProvider().saveToken(token);
        StorageProvider().saveUserId(userId);
        StorageProvider().saveUserName(utf8.decode(latin1.encode(userName)));
        StorageProvider().saveUserRole(userRole);
      } else {
        _isLoading = false;
        _resMessage = 'Credenciais inválidas';
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = 'Sem conexão com internet/servidor';
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessage = 'Por favor, tente novamente';
      notifyListeners();
    }
  }

  void registerUser({
    required String name,
    required String email,
    required String phone,
    required String address,
    required String password,
    required String role,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    String url = '$requestBaseUrl/users/create';

    UserModel user = UserModel(
      name: name,
      email: email,
      phone: phone,
      address: address,
      password: password,
      role: role,
    );

    try {
      http.Response response = await http.post(
        Uri.parse(url),
        body: user.toJson(),
        headers: {
          "Content-type": "application/json; charset=UTF-8",
        },
      );

      if (response.statusCode == 201) {
        _isLoading = false;
        _resMessage = 'success';
        notifyListeners();
      } else {
        _isLoading = false;
        _resMessage = 'Esse email ja foi cadastrado';
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = 'Sem conexão com internet/servidor';
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessage = 'Por favor, tente novamente';
      notifyListeners();
    }
  }

  void clear() {
    _resMessage = '';
    notifyListeners();
  }
}
