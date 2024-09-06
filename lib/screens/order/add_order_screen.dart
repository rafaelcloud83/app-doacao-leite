import 'package:doacao_leite/utils/colors.dart';
import 'package:doacao_leite/widgets/button.dart';
import 'package:flutter/material.dart';

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
                  customButton(
                    status: false,
                    tap: () {
                      //TODO: criar pedido
                    },
                    context: context,
                    text: 'Criar pedido',
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
