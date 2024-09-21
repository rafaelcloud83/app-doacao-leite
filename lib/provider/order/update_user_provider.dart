import 'package:doacao_leite/models/user/user_model.dart';
import 'package:doacao_leite/provider/storage/storage_provider.dart';
import 'package:doacao_leite/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdateUserProvider extends ChangeNotifier {
  final requestBaseUrl = AppUrl.baseURL;

  bool _status = false;
  String _response = '';

  bool get status => _status;
  String get response => _response;

  void updateUser({
    required int id,
    required String name,
    required String email,
    required String password,
    required String phone,
    required String address,
    required bool active,
    required String role,
    BuildContext? context,
  }) async {
    final token = await StorageProvider().getToken();

    _status = true;
    notifyListeners();

    String url = '$requestBaseUrl/users/update';

    UserModel user = UserModel(
      id: id.toString(),
      name: name,
      email: email,
      password: password,
      phone: phone,
      address: address,
      active: active.toString(),
      role: role,
    );

    http.Response response = await http.put(
      Uri.parse(url),
      body: user.toJson(),
      headers: {
        'Authorization': 'Bearer $token',
        "Content-type": "application/json; charset=UTF-8",
      },
    );

    if (response.statusCode == 200) {
      _status = false;
      _response = 'success';
      notifyListeners();
    } else {
      _status = false;
      _response = 'Erro ao atualizar usuário';
      notifyListeners();
    }
  }

  void clear() {
    _response = '';
    notifyListeners();
  }
}
