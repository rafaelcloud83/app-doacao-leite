import 'package:doacao_leite/models/order/receiver/order_response_model.dart';
import 'package:doacao_leite/provider/order/donor/get_donor_order_service.dart';
import 'package:doacao_leite/provider/storage/storage_provider.dart';
import 'package:doacao_leite/screens/auth/login_screen.dart';
import 'package:doacao_leite/screens/order/donor/donate_order_screen.dart';
import 'package:doacao_leite/screens/order/donor/order_donor_view_container.dart';
import 'package:doacao_leite/utils/colors.dart';
import 'package:doacao_leite/utils/routers.dart';
import 'package:flutter/material.dart';

class HomeDonorScreen extends StatefulWidget {
  const HomeDonorScreen({super.key});

  @override
  State<HomeDonorScreen> createState() => _HomeDonorScreenState();
}

class _HomeDonorScreenState extends State<HomeDonorScreen> {
  String? donorName;
  String? donorId;

  @override
  void initState() {
    super.initState();
    _loadDonorName();
    _loadDonorId();
  }

  Future<void> _loadDonorName() async {
    String? name = await StorageProvider().getUserName();
    setState(() {
      donorName = name;
    });
  }

  Future<void> _loadDonorId() async {
    String? id = await StorageProvider().getUserId();
    donorId = id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'OLÁ $donorName',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
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
            page: DonateOrderScreen(donorId: donorId),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder<OrderResponseModel>(
          future: GetDonorOrderService().getOrder(),
          builder: (context, snapshot) {
            //debugPrint('Snapshot: $snapshot');
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
                        'Você não realizou\nnenhuma doação',
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
                      return OrderDonorField(
                        id: '${data.id}',
                        productName: data.productName,
                        estimatedPrice: '${data.estimatedPrice}',
                        receiverId: '${data.receiver!.id}',
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
