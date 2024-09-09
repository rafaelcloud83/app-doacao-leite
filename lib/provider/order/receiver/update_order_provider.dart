import 'package:doacao_leite/models/order/receiver/order_update_model.dart';
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
    //debugPrint('token -> $token');

    _status = true;
    notifyListeners();

    String url = '$requestBaseUrl/orders/update';
    //debugPrint('URL: $url');

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
    //debugPrint('Order: $order');

    http.Response response = await http.put(
      Uri.parse(url),
      body: order.toJson(),
      headers: {
        'Authorization': 'Bearer $token',
        "Content-type": "application/json; charset=UTF-8",
      },
    );
    //debugPrint('Body http: ${response.body}');
    //debugPrint('Response status: ${response.statusCode}');

    //final res = response.body;
    if (response.statusCode == 200) {
      //debugPrint('Response: $res');
      _status = false;
      _response = 'success';
      notifyListeners();
    } else {
      //debugPrint('Response: $res');
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

//TODO: melhorar a resposta no backend
//response
/* {
	"id": 10,
	"productName": "leite nan alterado",
	"estimatedPrice": "70,90",
	"status": "AGUARDANDO",
	"createdAt": "2024-09-09T22:02:34.101402Z",
	"updatedAt": "2024-09-09T22:07:12.541113299Z",
	"receiver": {
		"id": 4,
		"name": "Maria",
		"email": "maria@email.com",
		"phone": "19993958675",
		"address": "rua dois",
		"password": "$2a$10$Em.2EoqjaYSuWCmw6U/Msuwa3x4.s87R7e5YtgC9qo1W1hdqC/S..",
		"role": "RECEBEDOR",
		"active": true,
		"createdAt": "2024-09-09T21:46:35.399609Z",
		"updatedAt": null,
		"enabled": true,
		"authorities": [
			{
				"authority": "ROLE_RECEBEDOR"
			}
		],
		"username": "maria@email.com",
		"accountNonExpired": true,
		"accountNonLocked": true,
		"credentialsNonExpired": true
	},
	"donor": {
		"id": 1,
		"name": "Nenhum",
		"email": "nenhum@email.com",
		"phone": "1",
		"address": "nenhum",
		"password": "$2a$10$Em.2EoqjaYSuWCmw6U/Msuwa3x4.s87R7e5YtgC9qo1W1hdqC/S..",
		"role": "DOADOR",
		"active": true,
		"createdAt": "2024-09-09T21:46:35.333329Z",
		"updatedAt": null,
		"enabled": true,
		"authorities": [
			{
				"authority": "ROLE_DOADOR"
			}
		],
		"username": "nenhum@email.com",
		"accountNonExpired": true,
		"accountNonLocked": true,
		"credentialsNonExpired": true
	}
} */