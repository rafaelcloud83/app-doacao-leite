import 'package:doacao_leite/provider/order/receiver/add_order_provider.dart';
import 'package:doacao_leite/screens/order/receiver/home_receiver_screen.dart';
import 'package:doacao_leite/utils/colors.dart';
import 'package:doacao_leite/utils/routers.dart';
import 'package:doacao_leite/utils/snack_message.dart';
import 'package:doacao_leite/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateOrderScreen extends StatefulWidget {
  const CreateOrderScreen({
    Key? key,
    this.receiverId,
  }) : super(key: key);

  final String? receiverId;

  @override
  State<CreateOrderScreen> createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
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
  }

  @override
  Widget build(BuildContext context) {
    String userIdLogged = widget.receiverId!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'Criar Pedido de Doação',
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
                  Text(
                    'Meu número: $userIdLogged',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: _productName,
                    decoration: const InputDecoration(
                      hintText: "Nome do Produto",
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: _estimatedPrice,
                    decoration: const InputDecoration(
                      hintText: "Preço estimado",
                    ),
                  ),
                  const SizedBox(height: 24),
                  Consumer<AddOrderProvider>(
                      builder: (context, addOrder, child) {
                    WidgetsBinding.instance.addPostFrameCallback(
                      (_) {
                        if (addOrder.response != '') {
                          if (addOrder.response == 'success') {
                            successMessage(
                              message: 'Pedido de doação criado com sucesso',
                              ctx: context,
                            );
                            PageNavigator(ctx: context).nextPageOnly(
                              page: const HomeReceiverScreen(),
                            );
                          } else {
                            errorMessage(
                              message: addOrder.response,
                              ctx: context,
                            );
                          }
                        }
                        addOrder.clear();
                      },
                    );
                    return customButton(
                      status: addOrder.status,
                      tap: () {
                        if (_productName.text.isEmpty ||
                            _estimatedPrice.text.isEmpty) {
                          errorMessage(
                              message: 'Preencha todos os campos',
                              ctx: context);
                        } else {
                          addOrder.addOrder(
                            receiverId: int.parse(userIdLogged),
                            productName: _productName.text.trim(),
                            estimatedPrice: _estimatedPrice.text.trim(),
                          );
                        }
                      },
                      context: context,
                      text: 'Criar pedido',
                    );
                  })
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
