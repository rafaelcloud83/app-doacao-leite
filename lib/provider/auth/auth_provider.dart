import 'dart:convert';
import 'dart:io';

import 'package:doacao_leite/models/user/user_model.dart';
import 'package:doacao_leite/provider/storage/storage_provider.dart';
import 'package:doacao_leite/utils/constants.dart';
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

        // Converte a string JSON em um mapa
        Map<String, dynamic> map = jsonDecode(response.body);
        // Acessa os valores do token e userId
        String token = map['token'];
        String userId = map['userId'];
        String userName = map['userName'];
        String userRole = map['userRole'];
        //debugPrint('token -> $token');
        //debugPrint('userId -> $userId');
        StorageProvider().saveToken(token);
        StorageProvider().saveUserId(userId);
        StorageProvider().saveUserName(
            utf8.decode(latin1.encode(userName))); //converter para formato ptbr
        StorageProvider().saveUserRole(userRole);
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
        //debugPrint('if -> $responseBody');
      } else {
        _isLoading = false;
        _resMessage = 'Esse email ja foi cadastrado'; //statusCode 500
        notifyListeners();
        //debugPrint('else -> $responseBody');
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = 'Sem conexão com internet/servidor';
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

//loginUser
//request
/* {
	"email" : "maria@email.com",
	"password" : "123"
} */

//response
/* {
	"token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJkb2FjYW8tbGVpdGUiLCJzdWIiOiJtYXJpYUBlbWFpbC5jb20iLCJleHAiOjE3MjU5NjI1MDh9.i9QIAC_V8RdGr6E7hevGa95o4c7QQ-OrfCGlO8VrFSo",
	"userId": "4",
	"userName": "Maria",
	"userRole": "RECEBEDOR"
} */

//------------------------------------------------------------------------------

//registerUser
//request
/* {
	"name" : "Ana",
	"email" : "ana@email.com",
	"password" : "123",
	"phone": "19981821234",
	"address": "rua braga",
	"role" : "RECEBEDOR"
} */

//response
/* {
	"id": 9,
	"name": "Ana",
	"email": "ana@email.com",
	"password": "$2a$10$wkrEqAx2hcwW7U00cFaTNujrrUZTBBW22vhXbcQhRKMw5BkhaUWrO",
	"phone": "19981821234",
	"address": "rua braga",
	"active": true,
	"role": "RECEBEDOR",
	"createdAt": "2024-09-09T22:13:32.781700086Z",
	"updatedAt": null
} */