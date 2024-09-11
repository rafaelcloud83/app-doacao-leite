import 'package:doacao_leite/utils/colors.dart';
import 'package:flutter/material.dart';

class OrderDonorStatusDetailScreen extends StatefulWidget {
  const OrderDonorStatusDetailScreen({
    Key? key,
    this.orderId,
    this.productName,
    this.estimatedPrice,
    this.receiverId,
    this.receiverName,
    this.receiverPhone,
    this.receiverAddress,
    this.donorId,
    this.status,
  }) : super(key: key);

  final String? orderId;
  final String? productName;
  final String? estimatedPrice;
  final String? receiverId;
  final String? receiverName;
  final String? receiverPhone;
  final String? receiverAddress;
  final String? donorId;
  final String? status;

  @override
  State<OrderDonorStatusDetailScreen> createState() =>
      _OrderDonorStatusDetailScreenState();
}

class _OrderDonorStatusDetailScreenState
    extends State<OrderDonorStatusDetailScreen> {
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
    String receiverName = widget.receiverName!;
    String receiverPhone = widget.receiverPhone!;
    String receiverAddress = widget.receiverAddress!;
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Nome do Recebedor: $receiverName',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Telefone do Recebedor: $receiverPhone',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Endereço do Recebedor: $receiverAddress',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
