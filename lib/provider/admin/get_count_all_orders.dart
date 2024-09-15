import 'dart:convert';

import 'package:doacao_leite/provider/storage/storage_provider.dart';
import 'package:doacao_leite/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetCountAllOrders {
  final requestBaseUrl = AppUrl.baseURL;

  Future<String> getCountAllOrders() async {
    final token = await StorageProvider().getToken();

    String url = "$requestBaseUrl/orders/count";
    debugPrint('URL: $url');

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-type': 'application/json; charset=UTF-8',
        },
      );

      //converto o response.body para o português br
      var body = utf8.decode(latin1.encode(response.body));
      //debugPrint('Body http: $body');
      int statusCode = response.statusCode;

      debugPrint('Request status: $statusCode');
      if (response.statusCode == 200) {
        debugPrint('Body 200: $body');
        return Future.value(body);
      } else {
        return Future.error(body);
      }
    } catch (e) {
      debugPrint('Erro catch: $e');
      return Future.error(e.toString());
    }
  }
}
