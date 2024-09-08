import 'package:doacao_leite/models/order/receiver/order_create_model.dart';
import 'package:doacao_leite/provider/storage/storage_provider.dart';
import 'package:doacao_leite/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddOrderProvider extends ChangeNotifier {
  final requestBaseUrl = AppUrl.baseURL;

  bool _status = false;
  String _response = '';

  bool get status => _status;
  String get response => _response;

  void addOrder({
    required int userId,
    required String productName,
    required String estimatedPrice,
    BuildContext? context,
  }) async {
    final token = await StorageProvider().getToken();
    debugPrint('token -> $token');
    debugPrint('userId -> $userId');
    _status = true;
    notifyListeners();

    String url = '$requestBaseUrl/orders/create';
    debugPrint('URL: $url');

    OrderCreateModel order = OrderCreateModel(
      productName: productName,
      estimatedPrice: estimatedPrice,
      receiver: Receiver(
        id: userId,
      ),
    );
    debugPrint('Order: $order');

    http.Response response = await http.post(
      Uri.parse(url),
      body: order.toJson(),
      headers: {
        "Authorization": "Bearer $token",
        "Content-type": "application/json; charset=UTF-8",
      },
    );
    debugPrint('Body http: ${response.body}');
    debugPrint('Response status: ${response.statusCode}');

    if (response.statusCode == 201) {
      final res = response.body;
      debugPrint('Response: $res');
      _status = false;
      _response = 'success';
      notifyListeners();
    } else {
      final res = response.body;
      debugPrint('Response: $res');
      _status = false;
      _response = 'Credenciais inválidas';
      notifyListeners();
    }
  }

  void clear() {
    _response = '';
    notifyListeners();
  }
}

//request para salvar
/* {
	"productName" : "leite nan",
	"estimatedPrice": "70,90",
	"receiver" : {
		"id" : 3
	}
} */
