import 'package:doacao_leite/models/order/order_response_model.dart';
import 'package:doacao_leite/provider/order/receiver/get_order_service.dart';
import 'package:doacao_leite/provider/storage/storage_provider.dart';
import 'package:doacao_leite/screens/auth/login_screen.dart';
import 'package:doacao_leite/screens/order/receiver/add_order_screen.dart';
import 'package:doacao_leite/screens/order/receiver/order_view_container.dart';
import 'package:doacao_leite/screens/order/user_detail_screen.dart';
import 'package:doacao_leite/utils/colors.dart';
import 'package:doacao_leite/utils/routers.dart';
import 'package:flutter/material.dart';

class HomeReceiverScreen extends StatefulWidget {
  const HomeReceiverScreen({super.key});

  @override
  State<HomeReceiverScreen> createState() => _HomeReceiverScreenState();
}

class _HomeReceiverScreenState extends State<HomeReceiverScreen> {
  String? receiverName;
  String? receiverId;
  String? donorId;

  @override
  void initState() {
    super.initState();
    setState(() {
      _loadReceiverName();
      _loadReceiverId();
    });
  }

  Future<void> _loadReceiverName() async {
    String? name = await StorageProvider().getUserName();
    setState(() {
      receiverName = name;
    });
  }

  Future<void> _loadReceiverId() async {
    String? id = await StorageProvider().getUserId();
    receiverId = id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'OLÁ $receiverName',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              PageNavigator(ctx: context).nextPage(
                page: const UserDetailScreen(),
              );
            },
            icon: const Icon(Icons.person),
          ),
          IconButton(
            onPressed: () {
              StorageProvider().logout();
              PageNavigator(ctx: context).nextPageOnly(
                page: const LoginScreen(),
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          PageNavigator(ctx: context).nextPage(
            page: CreateOrderScreen(receiverId: receiverId),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder<OrderResponseModel>(
          future: GetUserOrder().getOrder(),
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
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Nenhuma doação encontrada',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'Criar uma doação?',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: () {
                          PageNavigator(ctx: context).nextPage(
                            page: CreateOrderScreen(receiverId: receiverId),
                          );
                        },
                        child: Text(
                          'Clique aqui',
                          style: TextStyle(
                              fontSize: 18,
                              color: black,
                              fontWeight: FontWeight.bold),
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
                      return OrderField(
                        id: '${data.id}',
                        productName: data.productName,
                        estimatedPrice: '${data.estimatedPrice}',
                        receiverId: receiverId,
                        donorId: '${data.donor!.id}',
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
