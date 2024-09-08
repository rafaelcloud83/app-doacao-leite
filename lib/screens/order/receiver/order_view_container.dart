import 'package:doacao_leite/screens/order/receiver/order_details_screen.dart';
import 'package:doacao_leite/screens/order/receiver/order_status_detail.dart';
import 'package:doacao_leite/utils/routers.dart';
import 'package:doacao_leite/utils/snack_message.dart';
import 'package:flutter/material.dart';

class OrderField extends StatefulWidget {
  OrderField({
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
  _OrderFieldState createState() => _OrderFieldState();
}

class _OrderFieldState extends State<OrderField> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (widget.status == 'AGUARDANDO') {
          //pagina para alterar a doação
          PageNavigator(ctx: context).nextPage(
              page: OrderDetailsScreen(
            id: widget.id,
            productName: widget.productName,
            estimatedPrice: widget.estimatedPrice,
            userId: widget.userId,
          ));
        } else if (widget.status == 'DOADO') {
          // pagina de confirmação que recebeu a doação
          PageNavigator(ctx: context).nextPage(
              page: OrderStatusDetailScreen(
            id: widget.id,
            productName: widget.productName,
            estimatedPrice: widget.estimatedPrice,
            userId: widget.userId,
            status: widget.status,
          ));
        } else if (widget.status == 'CONCLUIDO') {
          errorMessage(
              message: 'A doação já foi concluída e não pode ser alterada',
              ctx: context);
          return;
        }
      },
      contentPadding: const EdgeInsets.all(0),
      title: Text(
        widget.productName!,
        style: const TextStyle(fontSize: 18),
      ),
      subtitle: Row(
        children: [
          const Text('R\$ '),
          Text(
            widget.estimatedPrice!,
            overflow: TextOverflow.ellipsis,
          ),
          const Text(' -- Status: '),
          Text(
            style: const TextStyle(fontWeight: FontWeight.bold),
            widget.status!,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      leading: Text(
        widget.id!,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      //trailing:
    );
  }
}
