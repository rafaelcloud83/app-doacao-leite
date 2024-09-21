import 'dart:convert';

import 'package:doacao_leite/models/order/order_response_model.dart';
import 'package:doacao_leite/provider/storage/storage_provider.dart';
import 'package:doacao_leite/utils/constants.dart';
import 'package:http/http.dart' as http;

class GetUserOrder {
  final requestBaseUrl = AppUrl.baseURL;

  Future<OrderResponseModel> getOrder() async {
    final userId = await StorageProvider().getUserId();
    final token = await StorageProvider().getToken();

    String url = "$requestBaseUrl/orders/receiver/$userId";

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
        if (json.decode(body)['orders'] != null) {
          final orderModel = orderResponseModelFromJson(body);
          return orderModel;
        } else {
          return OrderResponseModel();
        }
      } else {
        return OrderResponseModel();
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
