import 'package:doacao_leite/models/order/order_response_model.dart';
import 'package:doacao_leite/provider/admin/get_all_orders.dart';
import 'package:doacao_leite/screens/admin/admin_orders_container.dart';
import 'package:doacao_leite/utils/colors.dart';
import 'package:flutter/material.dart';

class AdminOrdersScreen extends StatefulWidget {
  const AdminOrdersScreen({super.key});

  @override
  State<AdminOrdersScreen> createState() => _AdminOrdersScreenState();
}

class _AdminOrdersScreenState extends State<AdminOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'Todas as Doações',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder<OrderResponseModel>(
          future: GetAllOrders().getAllOrders(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text(
                  'Ocorreu um erro',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            } else if (snapshot.hasData) {
              if (snapshot.data!.orders == null ||
                  snapshot.data!.orders!.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Nenhuma doação encontrada',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return ListView(
                  children: List.generate(
                    snapshot.data!.orders!.length,
                    (index) {
                      final data = snapshot.data!.orders![index];
                      return AdminOrdersField(
                        id: '${data.id}',
                        productName: data.productName,
                        estimatedPrice: '${data.estimatedPrice}',
                        createdAt: data.createdAt,
                        updatedAt: data.updatedAt,
                        receiverId: '${data.receiver!.id}',
                        receiverName: data.receiver!.receiverName,
                        receiverPhone: data.receiver!.receiverPhone,
                        donorId: '${data.donor!.id}',
                        donorName: data.donor!.donorName,
                        donorPhone: data.donor!.donorPhone,
                        status: data.status,
                      );
                    },
                  ),
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
