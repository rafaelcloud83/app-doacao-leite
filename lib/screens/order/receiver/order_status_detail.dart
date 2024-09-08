import 'package:doacao_leite/utils/colors.dart';
import 'package:doacao_leite/widgets/button.dart';
import 'package:flutter/material.dart';

class OrderStatusDetailScreen extends StatefulWidget {
  const OrderStatusDetailScreen({
    Key? key,
    this.id,
    this.productName,
    this.estimatedPrice,
    this.userId,
    this.status,
  }) : super(key: key);

  final String? id;
  final String? productName;
  final String? estimatedPrice;
  final String? userId;
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
    //String userIdLogged = widget.userId!;
    String idOrder = widget.id!;
    String productName = widget.productName!;
    String estimatedPrice = widget.estimatedPrice!;
    String statusOrder = widget.status!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'Detalhes da Doação',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                    'Doação número: $idOrder',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Status da doação: $statusOrder',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Nome do Produto: $productName',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Preço estimado: R\$ $estimatedPrice',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 24),
                  customButton(
                    status: false,
                    tap: () {
                      //TODO: atualizar o status para CONCLUIDO
                    },
                    context: context,
                    text: 'Confirmo doação recebida',
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
