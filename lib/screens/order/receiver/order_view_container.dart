import 'package:doacao_leite/screens/order/receiver/order_details_screen.dart';
import 'package:doacao_leite/screens/order/receiver/order_status_concluido.dart';
import 'package:doacao_leite/screens/order/receiver/order_status_detail.dart';
import 'package:doacao_leite/utils/routers.dart';
import 'package:flutter/material.dart';

class OrderField extends StatefulWidget {
  OrderField({
    Key? key,
    this.id,
    this.productName,
    this.estimatedPrice,
    this.receiverId,
    this.donorId,
    this.status,
  }) : super(key: key);

  final String? id;
  final String? productName;
  final String? estimatedPrice;
  final String? receiverId;
  final String? donorId;
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
          PageNavigator(ctx: context).nextPage(
            page: OrderDetailsScreen(
              orderId: widget.id,
              productName: widget.productName,
              estimatedPrice: widget.estimatedPrice,
              receiverId: widget.receiverId,
              donorId: widget.donorId,
              status: widget.status,
            ),
          );
        } else if (widget.status == 'DOADO') {
          PageNavigator(ctx: context).nextPage(
            page: OrderStatusDetailScreen(
              orderId: widget.id,
              productName: widget.productName,
              estimatedPrice: widget.estimatedPrice,
              receiverId: widget.receiverId,
              donorId: widget.donorId,
              status: widget.status,
            ),
          );
        } else if (widget.status == 'CONCLUIDO') {
          PageNavigator(ctx: context).nextPage(
            page: OrderStatusConcluido(
              orderId: widget.id,
              productName: widget.productName,
              estimatedPrice: widget.estimatedPrice,
              receiverId: widget.receiverId,
              donorId: widget.donorId,
              status: widget.status,
            ),
          );
        }
      },
      contentPadding: const EdgeInsets.all(0),
      title: Text(
        widget.productName!,
        style: const TextStyle(fontSize: 18),
      ),
      subtitle: Row(
        children: [
          const Text(
            'R\$ ',
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            widget.estimatedPrice!,
            overflow: TextOverflow.ellipsis,
          ),
          const Text(
            ' -- Status: ',
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            widget.status!,
            style: const TextStyle(fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      minLeadingWidth: 28,
      leading: Text(
        widget.id!,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      //trailing:
    );
  }
}
