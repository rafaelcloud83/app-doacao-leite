import 'dart:io';

import 'package:doacao_leite/models/user_model.dart';
import 'package:doacao_leite/screens/auth/login_screen.dart';
import 'package:doacao_leite/utils/constants.dart';
import 'package:doacao_leite/utils/routers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthenticationProvider extends ChangeNotifier {
  final requestBaseUrl = AppUrl.baseURL;

  //Setter
  bool _isLoading = false;
  String _resMessage = '';

  //Getter
  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;

  //login
  void loginUser({
    required String email,
    required String password,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    String url = '$requestBaseUrl/auth/login';

    //cria objeto User
    UserModel user = UserModel(email: email, password: password);

    try {
      http.Response response = await http.post(
        Uri.parse(url),
        //converte objeto em json
        body: user.toJson(),
        headers: {
          "Content-type": "application/json; charset=UTF-8",
        },
      );

      /* debugPrint('response -> ${response.body}'); //resposta do Post
      debugPrint('statusCode ->' +
          response.statusCode.toString()); //statusCode do Post */

      //final responseBody = response.body; //variável criada para debugar

      if (response.statusCode == 201) {
        _isLoading = false;
        _resMessage = 'success'; //retorna para o login_screen
        notifyListeners();
        //debugPrint('if -> $responseBody');
      } else {
        _isLoading = false;
        _resMessage = 'Credenciais inválidas';
        notifyListeners();
        //debugPrint('else -> $responseBody');
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = 'Sem conexão com internet';
      notifyListeners();
      //debugPrint('socket -> $_resMessage');
    } catch (e) {
      _isLoading = false;
      _resMessage = 'Por favor, tente novamente';
      notifyListeners();
      //debugPrint('Erro ao fazer login ->' + e.toString());
    }
  }

  //criar usuário
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

    //cria objeto User
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
        //converte objeto em json
        body: user.toJson(),
        headers: {
          "Content-type": "application/json; charset=UTF-8",
        },
      );

      //final responseBody = response.body; //variável criada para debugar

      if (response.statusCode == 201) {
        _isLoading = false;
        _resMessage = 'success'; //retorna para o login_screen
        notifyListeners();
        PageNavigator(ctx: context).nextPageOnly(page: const LoginScreen());
        //debugPrint('if -> $responseBody');
      } else {
        _isLoading = false;
        _resMessage = 'Esse email ja foi cadastrado'; //statusCode 500
        notifyListeners();
        //debugPrint('else -> $responseBody');
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = 'Sem conexão com internet';
      notifyListeners();
      debugPrint('socket -> $_resMessage');
    } catch (e) {
      _isLoading = false;
      _resMessage = 'Por favor, tente novamente';
      notifyListeners();
      //debugPrint('Erro ao fazer cadatro ->' + e.toString());
    }
  }

  void clear() {
    _resMessage = '';
    notifyListeners();
  }
}
