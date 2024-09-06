import 'dart:convert';

import 'package:doacao_leite/provider/storage/storage_provider.dart';
import 'package:doacao_leite/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdateOrderProvider extends ChangeNotifier {
  bool _status = false;
  String _response = '';

  bool get status => _status;
  String get response => _response;

  void updateOrder(
      {String? id, String? productName, String? estimatedPrice}) async {
    final token = await StorageProvider().getToken();
    final userId = await StorageProvider().getUserId();
    debugPrint('token -> $token');
    debugPrint('userId -> $userId');
    _status = true;
    notifyListeners();

    final _url = '${AppUrl.baseURL}/orders/update';
    debugPrint('URL: $_url');

    final body = {
      'id': id,
      'product_name': productName,
      'estimated_price': estimatedPrice,
      'status': 'AGUARDANDO',
      'receiver': {
        'id': userId,
      },
    };

    final result = await http.put(
      Uri.parse(_url),
      body: json.encode(body),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    debugPrint('Response status: ${result.statusCode}');

    if (result.statusCode == 200) {
      final res = result.body;
      debugPrint('Response: $res');
      _status = false;
      _response = json.decode(res)['message'];
      notifyListeners();
    } else {
      final res = result.body;
      debugPrint('Response: $res');
      _status = false;
      _response = json.decode(res)['message'];
      notifyListeners();
    }
  }

  void clear() {
    _response = '';
    notifyListeners();
  }
}

//request para atualizar
/*{
	"id" : 1,
	"productName": "Ninho Fases 1 - Fórmula Infantil, 1.2 kg",
	"estimatedPrice": "74,99",
	"status" : "DOADO",
	"receiver" : {
		"id" : 2
	},
	"donor" : {
		"id" : 5
	}
} */
