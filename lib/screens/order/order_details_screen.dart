import 'package:doacao_leite/utils/colors.dart';
import 'package:doacao_leite/widgets/button.dart';
import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({
    Key? key,
    this.id,
    this.productName,
    this.estimatedPrice,
    this.userId,
  }) : super(key: key);

  final String? id;
  final String? productName;
  final String? estimatedPrice;
  final String? userId;

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
    //String userIdLogged = widget.userId!;
    String idOrder = widget.id!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('Detalhes do Pedido'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  //Text('Id do Recebedor: $userIdLogged'),
                  const SizedBox(height: 8),
                  Text('Pedido número: $idOrder'),
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
                      //TODO: atualizar o pedido
                    },
                    context: context,
                    text: 'Atualizar pedido',
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
