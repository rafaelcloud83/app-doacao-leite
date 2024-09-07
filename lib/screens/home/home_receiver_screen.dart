import 'package:doacao_leite/models/order_response_model.dart';
import 'package:doacao_leite/provider/order/get_order_service.dart';
import 'package:doacao_leite/provider/storage/storage_provider.dart';
import 'package:doacao_leite/screens/auth/login_screen.dart';
import 'package:doacao_leite/screens/order/add_order_screen.dart';
import 'package:doacao_leite/screens/order/local_widget/order_view_container.dart';
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
  //List order = [];

  @override
  void initState() {
    super.initState();
    _loadReceiverName();
    _loadReceiverId();
    //GetUserOrder().getOrder();
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
    //debugPrint('receiverId -> $receiverId');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        //title: Text('Recebedor $receiverName - $receiverId'),
        title: Text('Recebedor $receiverName'),
        actions: [
          IconButton(
            onPressed: () {
              StorageProvider().logout();
              PageNavigator(ctx: context)
                  .nextPageOnly(page: const LoginScreen());
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          PageNavigator(ctx: context)
              .nextPage(page: CreateOrderScreen(userId: receiverId));
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder<OrderResponseModel>(
          future: GetUserOrder().getOrder(),
          builder: (context, snapshot) {
            debugPrint('Snapshot: $snapshot');
            if (snapshot.hasError) {
              return const Center(
                child: Text('Ocorreu um erro'),
              );
            } else if (snapshot.hasData) {
              if (snapshot.data!.orders == null) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Nenhum pedido',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: () {
                          PageNavigator(ctx: context).nextPage(
                              page: CreateOrderScreen(userId: receiverId));
                        },
                        child: Text(
                          'Criar um pedido',
                          style: TextStyle(fontSize: 18, color: black),
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
                        //id: "${index + 1}",
                        id: '${data.id}',
                        productName: data.productName,
                        estimatedPrice: '${data.estimatedPrice}',
                        userId: receiverId,
                        status: data.status,
                      );
                    },
                  ),
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(color: Color(0XffFFFF00)),
              );
            }
          },
        ),
      ),
    );
  }
}
