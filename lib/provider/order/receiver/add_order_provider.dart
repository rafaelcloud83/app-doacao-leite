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
    required int receiverId,
    required String productName,
    required String estimatedPrice,
    BuildContext? context,
  }) async {
    final token = await StorageProvider().getToken();
    //debugPrint('token -> $token');
    //debugPrint('userId -> $receiverId');
    _status = true;
    notifyListeners();

    String url = '$requestBaseUrl/orders/create';
    //debugPrint('URL: $url');

    OrderCreateModel order = OrderCreateModel(
      productName: productName,
      estimatedPrice: estimatedPrice,
      receiver: Receiver(
        id: receiverId,
      ),
    );
    //debugPrint('Order: $order');

    http.Response response = await http.post(
      Uri.parse(url),
      body: order.toJson(),
      headers: {
        "Authorization": "Bearer $token",
        "Content-type": "application/json; charset=UTF-8",
      },
    );
    //debugPrint('Body http: ${response.body}');
    //debugPrint('Response status: ${response.statusCode}');

    //final res = response.body;
    if (response.statusCode == 201) {
      //debugPrint('Response: $res');
      _status = false;
      _response = 'success';
      notifyListeners();
    } else {
      //debugPrint('Response: $res');
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
		"id" : 4
	}
} */

//TODO: melhorar a resposta no backend
//response
/* {
	"id": 10,
	"productName": "leite nan",
	"estimatedPrice": "70,90",
	"status": "AGUARDANDO",
	"createdAt": "2024-09-09T22:02:34.101401876Z",
	"updatedAt": null,
	"receiver": {
		"id": 4,
		"name": null,
		"email": null,
		"phone": null,
		"address": null,
		"password": null,
		"role": null,
		"active": null,
		"createdAt": null,
		"updatedAt": null,
		"enabled": true,
		"authorities": [
			{
				"authority": "ROLE_RECEBEDOR"
			}
		],
		"username": null,
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