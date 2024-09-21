import 'dart:convert';

import 'package:doacao_leite/provider/storage/storage_provider.dart';
import 'package:doacao_leite/utils/constants.dart';
import 'package:http/http.dart' as http;

class GetCountAllOrders {
  final requestBaseUrl = AppUrl.baseURL;

  Future<String> getCountAllOrders() async {
    final token = await StorageProvider().getToken();

    String url = "$requestBaseUrl/orders/count";

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
        return Future.value(body);
      } else {
        return Future.error(body);
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
