import 'package:doacao_leite/provider/order/receiver/update_order_provider.dart';
import 'package:doacao_leite/screens/order/receiver/home_receiver_screen.dart';
import 'package:doacao_leite/utils/colors.dart';
import 'package:doacao_leite/utils/routers.dart';
import 'package:doacao_leite/utils/snack_message.dart';
import 'package:doacao_leite/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({
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
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final TextEditingController _productName = TextEditingController();
  final TextEditingController _estimatedPrice = TextEditingController();

  @override
  void dispose() {
    _productName.dispose();
    _estimatedPrice.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _productName.text = widget.productName!;
      _estimatedPrice.text = widget.estimatedPrice!;
    });
  }

  @override
  Widget build(BuildContext context) {
    String orderId = widget.orderId!;
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
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Nome do Produto',
                    ),
                  ),
                  TextField(
                    controller: _productName,
                    decoration: const InputDecoration(
                      hintText: "Nome do Produto",
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Preço estimado R\$',
                    ),
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: _estimatedPrice,
                    decoration: const InputDecoration(
                      hintText: "Preço estimado",
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
                              message: 'Doação alterada',
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
                        // atualizar o pedido mas manter status AGUARDANDO
                        if (_productName.text.isEmpty ||
                            _estimatedPrice.text.isEmpty) {
                          errorMessage(
                            message: 'Preencha todos os campos',
                            ctx: context,
                          );
                        } else {
                          updateOrder.updateOrder(
                            orderId: int.parse(orderId),
                            receiverId: int.parse(receiverId),
                            donorId: int.parse(donorId),
                            productName: _productName.text.trim(),
                            estimatedPrice: _estimatedPrice.text.trim(),
                            statusOrder: 'AGUARDANDO',
                          );
                        }
                      },
                      context: context,
                      text: 'Atualizar doação',
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
