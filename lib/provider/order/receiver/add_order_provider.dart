import 'package:doacao_leite/models/order/order_create_model.dart';
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
    required int receiverId,
    required String productName,
    required String estimatedPrice,
    BuildContext? context,
  }) async {
    final token = await StorageProvider().getToken();
    _status = true;
    notifyListeners();

    String url = '$requestBaseUrl/orders/create';

    OrderCreateModel order = OrderCreateModel(
      productName: productName,
      estimatedPrice: estimatedPrice,
      receiver: Receiver(
        id: receiverId,
      ),
    );

    http.Response response = await http.post(
      Uri.parse(url),
      body: order.toJson(),
      headers: {
        "Authorization": "Bearer $token",
        "Content-type": "application/json; charset=UTF-8",
      },
    );

    if (response.statusCode == 201) {
      _status = false;
      _response = 'success';
      notifyListeners();
    } else {
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
