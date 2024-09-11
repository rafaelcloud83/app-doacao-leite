import 'package:doacao_leite/utils/colors.dart';
import 'package:flutter/material.dart';

class DonateOrderScreen extends StatefulWidget {
  const DonateOrderScreen({
    Key? key,
    this.donorId,
  }) : super(key: key);

  final String? donorId;

  @override
  State<DonateOrderScreen> createState() => _DonateOrderScreenState();
}

class _DonateOrderScreenState extends State<DonateOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('Doar'),
      ),
      body: Container(
        child: const Text('lista de pedidos de doação com status AGUARDANDO'),
      ),
    );
  }
}
