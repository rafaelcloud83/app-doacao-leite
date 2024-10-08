import 'package:doacao_leite/models/order/order_update_model.dart';
import 'package:doacao_leite/provider/storage/storage_provider.dart';
import 'package:doacao_leite/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdateOrderProvider extends ChangeNotifier {
  final requestBaseUrl = AppUrl.baseURL;

  bool _status = false;
  String _response = '';

  bool get status => _status;
  String get response => _response;

  void updateOrder({
    required int orderId,
    required int receiverId,
    required int donorId,
    required String productName,
    required String estimatedPrice,
    required String statusOrder,
    BuildContext? context,
  }) async {
    final token = await StorageProvider().getToken();
    _status = true;
    notifyListeners();

    String url = '$requestBaseUrl/orders/update';

    OrderUpdateModel order = OrderUpdateModel(
      id: orderId,
      productName: productName,
      estimatedPrice: estimatedPrice,
      status: statusOrder,
      receiver: Receiver(
        id: receiverId,
      ),
      donor: Donor(
        id: donorId,
      ),
    );

    http.Response response = await http.put(
      Uri.parse(url),
      body: order.toJson(),
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
      _response = 'Erro ao atualizar a doação';
      notifyListeners();
    }
  }

  void clear() {
    _response = '';
    notifyListeners();
  }
}
