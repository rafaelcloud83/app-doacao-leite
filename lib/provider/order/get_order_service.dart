import 'dart:convert';

import 'package:doacao_leite/models/order_response_model.dart';
import 'package:doacao_leite/provider/storage/storage_provider.dart';
import 'package:doacao_leite/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetUserOrder {
  final requestBaseUrl = AppUrl.baseURL;

  Future<OrderResponseModel> getOrder() async {
    final userId = await StorageProvider().getUserId();
    final token = await StorageProvider().getToken();

    String url = "$requestBaseUrl/orders/receiver/$userId";
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
        if (json.decode(body)['orders'] != null) {
          debugPrint('entrei body diferente de null');
          final orderModel = orderResponseModelFromJson(body);
          return orderModel;
        } else {
          debugPrint('erro no else do if decode');
          return OrderResponseModel();
        }
      } else {
        return OrderResponseModel();
      }
    } catch (e) {
      debugPrint('Erro catch: $e');
      return Future.error(e.toString());
    }
  }
}
