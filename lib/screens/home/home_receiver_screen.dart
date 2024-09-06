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
  List order = [];

  @override
  void initState() {
    super.initState();
    _loadReceiverName();
    _loadReceiverId();
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
        title: Text('Recebedor $receiverName - $receiverId'),
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
        //mini: true,
        onPressed: () {
          PageNavigator(ctx: context)
              .nextPage(page: CreateOrderScreen(userId: receiverId));
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: order.isNotEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Nenhum pedido',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
              )
            : ListView(
                children: List.generate(5, (index) {
                  return OrderField(
                    //id: "ID",
                    id: "${index + 1}",
                    productName: "Product Name",
                    estimatedPrice: "10,99",
                    userId: receiverId,
                  );
                }),
              ),
      ),
    );
  }
}
