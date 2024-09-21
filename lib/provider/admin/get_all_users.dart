import 'dart:convert';

import 'package:doacao_leite/models/user/user_response_model.dart';
import 'package:doacao_leite/provider/storage/storage_provider.dart';
import 'package:doacao_leite/utils/constants.dart';
import 'package:http/http.dart' as http;

class GetAllUsers {
  final requestBaseUrl = AppUrl.baseURL;
  Future<UserResponseModel> getAllUsers() async {
    final token = await StorageProvider().getToken();

    String url = "$requestBaseUrl/users";

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-type': 'application/json; charset=UTF-8',
        },
      );

      var body = utf8.decode(latin1.encode(response.body));

      if (response.statusCode == 200) {
        if (json.decode(body)['users'] != null) {
          final userModel = userResponseModelFromJson(body);
          return userModel;
        } else {
          return UserResponseModel();
        }
      } else {
        return UserResponseModel();
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
