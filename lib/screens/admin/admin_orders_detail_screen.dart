import 'package:doacao_leite/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class AdminOrdersDetailScreen extends StatefulWidget {
  const AdminOrdersDetailScreen({
    Key? key,
    this.orderId,
    this.productName,
    this.estimatedPrice,
    this.createdAt,
    required this.updatedAt,
    this.receiverId,
    this.receiverName,
    this.receiverPhone,
    this.donorId,
    this.donorName,
    this.donorPhone,
    this.status,
  }) : super(key: key);

  final String? orderId;
  final String? productName;
  final String? estimatedPrice;
  final String? createdAt;
  final String updatedAt;
  final String? receiverId;
  final String? receiverName;
  final String? receiverPhone;
  final String? donorId;
  final String? donorName;
  final String? donorPhone;
  final String? status;

  @override
  State<AdminOrdersDetailScreen> createState() =>
      _AdminOrdersDetailScreenState();
}

class _AdminOrdersDetailScreenState extends State<AdminOrdersDetailScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('pt_BR', null);
    DateTime dateCreated = DateTime.parse(widget.createdAt!).toLocal();
    DateTime dateUpdated = DateTime.parse(widget.updatedAt).toLocal();
    String orderId = widget.orderId!;
    String productName = widget.productName!;
    String estimatedPrice = widget.estimatedPrice!;
    String statusOrder = widget.status!;
    String createdAt =
        DateFormat('dd/MM/yyyy HH:mm', 'pt_BR').format(dateCreated);
    String updatedAt =
        DateFormat('dd/MM/yyyy HH:mm', 'pt_BR').format(dateUpdated);
    String receiverId = widget.receiverId!;
    String receiverName = widget.receiverName!;
    String receiverPhone = widget.receiverPhone!;
    String donorId = widget.donorId!;
    String donorName = widget.donorName!;
    String donorPhone = widget.donorPhone!;

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
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Status da doação: $statusOrder',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Nome do Produto: $productName',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Preço estimado: R\$ $estimatedPrice',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Data de Criação: $createdAt',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Data de Atualização: $updatedAt',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'ID do Recebedor: $receiverId',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Nome do Recebedor: $receiverName',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Telefone do Recebedor: $receiverPhone',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'ID do Doador: $donorId',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Nome do Doador: $donorName',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Telefone do Doador: $donorPhone',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
