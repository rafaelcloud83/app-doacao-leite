import 'package:doacao_leite/provider/order/receiver/update_order_provider.dart';
import 'package:doacao_leite/screens/order/receiver/home_receiver_screen.dart';
import 'package:doacao_leite/utils/colors.dart';
import 'package:doacao_leite/utils/routers.dart';
import 'package:doacao_leite/utils/snack_message.dart';
import 'package:doacao_leite/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderStatusDetailScreen extends StatefulWidget {
  const OrderStatusDetailScreen({
    Key? key,
    this.orderId,
    this.productName,
    this.estimatedPrice,
    this.receiverId,
    this.donorId,
    this.status,
  }) : super(key: key);

  final String? orderId;
  final String? productName;
  final String? estimatedPrice;
  final String? receiverId;
  final String? donorId;
  final String? status;

  @override
  State<OrderStatusDetailScreen> createState() =>
      _OrderStatusDetailScreenState();
}

class _OrderStatusDetailScreenState extends State<OrderStatusDetailScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String orderId = widget.orderId!;
    String productName = widget.productName!;
    String estimatedPrice = widget.estimatedPrice!;
    String statusOrder = widget.status!;
    String receiverId = widget.receiverId!;
    String donorId = widget.donorId!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'Detalhes da Doação',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  Text(
                    'Doação número: $orderId',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 24),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Status da doação: $statusOrder',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Nome do Produto: $productName',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Preço estimado: R\$ $estimatedPrice',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Consumer<UpdateOrderProvider>(
                      builder: (context, updateOrder, child) {
                    WidgetsBinding.instance.addPostFrameCallback(
                      (_) {
                        if (updateOrder.response != '') {
                          if (updateOrder.response == 'success') {
                            successMessage(
                              message: 'Doação concluído',
                              ctx: context,
                            );
                            PageNavigator(ctx: context).nextPageOnly(
                              page: const HomeReceiverScreen(),
                            );
                          } else {
                            errorMessage(
                              message: updateOrder.response,
                              ctx: context,
                            );
                          }
                        }
                        updateOrder.clear();
                      },
                    );
                    return customButton(
                      status: updateOrder.status,
                      tap: () {
                        // atualizar o status para CONCLUIDO
                        updateOrder.updateOrder(
                          orderId: int.parse(orderId),
                          receiverId: int.parse(receiverId),
                          donorId: int.parse(donorId),
                          productName: productName,
                          estimatedPrice: estimatedPrice,
                          statusOrder: 'CONCLUIDO',
                        );
                      },
                      context: context,
                      text: 'Confirmo doação recebida',
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
