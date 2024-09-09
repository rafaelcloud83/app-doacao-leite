import 'dart:convert';

import 'package:doacao_leite/models/order/receiver/order_response_model.dart';
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

//TODO: melhorar a resposta no backend
//response
/* {
	"orders": [
		{
			"id": 2,
			"productName": "Fórmula Infantil Nestogeno 1 Nestlé 0 a 6 meses 800g",
			"estimatedPrice": "56,99",
			"status": "AGUARDANDO",
			"createdAt": "2024-09-09T21:46:35.420415Z",
			"updatedAt": null,
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
		},
		{
			"id": 6,
			"productName": "Fórmula Infantil Nan Supreme 1 800g",
			"estimatedPrice": "107,99",
			"status": "DOADO",
			"createdAt": "2024-09-09T21:46:35.433079Z",
			"updatedAt": null,
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
				"id": 8,
				"name": "Joana",
				"email": "joana@email.com",
				"phone": "12995552233",
				"address": "rua europa",
				"password": "$2a$10$Em.2EoqjaYSuWCmw6U/Msuwa3x4.s87R7e5YtgC9qo1W1hdqC/S..",
				"role": "DOADOR",
				"active": true,
				"createdAt": "2024-09-09T21:46:35.413222Z",
				"updatedAt": null,
				"enabled": true,
				"authorities": [
					{
						"authority": "ROLE_DOADOR"
					}
				],
				"username": "joana@email.com",
				"accountNonExpired": true,
				"accountNonLocked": true,
				"credentialsNonExpired": true
			}
		},
		{
			"id": 7,
			"productName": "Ninho Fases 1 - Fórmula Infantil, 1.2 kg",
			"estimatedPrice": "74,99",
			"status": "CONCLUIDO",
			"createdAt": "2024-09-09T21:46:35.436343Z",
			"updatedAt": null,
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
				"id": 7,
				"name": "Jose",
				"email": "jose@email.com",
				"phone": "11974879854",
				"address": "rua sorriso",
				"password": "$2a$10$Em.2EoqjaYSuWCmw6U/Msuwa3x4.s87R7e5YtgC9qo1W1hdqC/S..",
				"role": "DOADOR",
				"active": true,
				"createdAt": "2024-09-09T21:46:35.410595Z",
				"updatedAt": null,
				"enabled": true,
				"authorities": [
					{
						"authority": "ROLE_DOADOR"
					}
				],
				"username": "jose@email.com",
				"accountNonExpired": true,
				"accountNonLocked": true,
				"credentialsNonExpired": true
			}
		},
		{
			"id": 10,
			"productName": "leite nan alterado",
			"estimatedPrice": "70,90",
			"status": "AGUARDANDO",
			"createdAt": "2024-09-09T22:02:34.101402Z",
			"updatedAt": "2024-09-09T22:07:12.541113Z",
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
		}
	]
} */