import 'package:doacao_leite/provider/order/add_order_provider.dart';
import 'package:doacao_leite/screens/home/home_receiver_screen.dart';
import 'package:doacao_leite/utils/colors.dart';
import 'package:doacao_leite/utils/routers.dart';
import 'package:doacao_leite/utils/snack_message.dart';
import 'package:doacao_leite/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateOrderScreen extends StatefulWidget {
  const CreateOrderScreen({
    Key? key,
    this.userId,
  }) : super(key: key);

  final String? userId;

  @override
  State<CreateOrderScreen> createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  final TextEditingController _productName = TextEditingController();
  final TextEditingController _estimatedPrice = TextEditingController();
  final TextEditingController _userId = TextEditingController();

  @override
  void dispose() {
    _productName.dispose();
    _estimatedPrice.dispose();
    _userId.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _userId.text = widget.userId!;
    });
  }

  @override
  Widget build(BuildContext context) {
    String userIdLogged = widget.userId!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('Criar Pedido'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text('Id do Recebedor: $userIdLogged'),
                  /* TextField(
                    controller: _userId,
                    decoration: const InputDecoration(
                      hintText: "Id do Usuário",
                    ),
                  ), */
                  const SizedBox(height: 16),
                  TextField(
                    controller: _productName,
                    decoration: const InputDecoration(
                      hintText: "Nome do Produto",
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: _estimatedPrice,
                    decoration: const InputDecoration(
                      hintText: "Preço estimado",
                    ),
                  ),
                  const SizedBox(height: 16),
                  Consumer<AddOrderProvider>(
                      builder: (context, addOrder, child) {
                    WidgetsBinding.instance.addPostFrameCallback(
                      (_) {
                        if (addOrder.response != '') {
                          if (addOrder.response == 'success') {
                            successMessage(
                              message: 'Pedido criado com sucesso',
                              ctx: context,
                            );
                            PageNavigator(ctx: context)
                                .nextPageOnly(page: const HomeReceiverScreen());
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
                            userId: int.parse(userIdLogged),
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
