import 'package:doacao_leite/models/order/order_response_model.dart';
import 'package:doacao_leite/provider/order/donor/get_order_status_aguardando.dart';
import 'package:doacao_leite/screens/order/donor/order_donor_confirm_donate_screen.dart';
import 'package:doacao_leite/screens/order/donor/order_donor_view_container.dart';
import 'package:doacao_leite/utils/colors.dart';
import 'package:doacao_leite/utils/routers.dart';
import 'package:flutter/material.dart';

class DonateOrderScreen extends StatefulWidget {
  const DonateOrderScreen({
    Key? key,
    this.donorId,
    this.orderId,
    this.productName,
    this.estimatedPrice,
    this.receiverId,
    this.receiverName,
    this.receiverPhone,
    this.receiverAddress,
    this.orderStatus,
  }) : super(key: key);

  final String? donorId;
  final String? orderId;
  final String? productName;
  final String? estimatedPrice;
  final String? receiverId;
  final String? receiverName;
  final String? receiverPhone;
  final String? receiverAddress;
  final String? orderStatus;

  @override
  State<DonateOrderScreen> createState() => _DonateOrderScreenState();
}

class _DonateOrderScreenState extends State<DonateOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'Fazer Doação',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder<OrderResponseModel>(
          future: GetOrderStatusAguardando().getOrder(),
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
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: () {
                          PageNavigator(ctx: context).nextPage(
                            page: OrderDonorConfirmDonateScreen(
                              orderId: widget.orderId,
                              productName: widget.productName,
                              estimatedPrice: widget.estimatedPrice,
                              receiverId: widget.receiverId,
                              receiverName: widget.receiverName,
                              receiverPhone: widget.receiverPhone,
                              receiverAddress: widget.receiverAddress,
                              donorId: widget.donorId,
                              status: widget.orderStatus,
                            ),
                          );
                        },
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
                        receiverName: data.receiver!.receiverName,
                        receiverPhone: data.receiver!.receiverPhone,
                        receiverAddress: data.receiver!.receiverAddress,
                        donorId: widget.donorId,
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
