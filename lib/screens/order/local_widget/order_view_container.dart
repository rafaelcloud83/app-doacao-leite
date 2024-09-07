import 'package:doacao_leite/screens/order/order_details_screen.dart';
import 'package:doacao_leite/utils/routers.dart';
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
        PageNavigator(ctx: context).nextPage(
            page: OrderDetailsScreen(
          id: widget.id,
          productName: widget.productName,
          estimatedPrice: widget.estimatedPrice,
          userId: widget.userId,
        ));
      },
      contentPadding: const EdgeInsets.all(0),
      title: Text(
        widget.productName!,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Row(
        children: [
          const Text('R\$ '),
          Text(
            widget.estimatedPrice!,
            overflow: TextOverflow.ellipsis,
          ),
          const Text(' -- '),
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
      ),
      //trailing:
    );
  }
}
