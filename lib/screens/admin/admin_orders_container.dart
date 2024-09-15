import 'package:doacao_leite/screens/admin/admin_orders_detail_screen.dart';
import 'package:doacao_leite/utils/routers.dart';
import 'package:flutter/material.dart';

class AdminOrdersField extends StatefulWidget {
  AdminOrdersField({
    Key? key,
    this.id,
    this.productName,
    this.estimatedPrice,
    this.createdAt,
    this.updatedAt,
    this.receiverId,
    this.receiverName,
    this.receiverPhone,
    this.donorId,
    this.donorName,
    this.donorPhone,
    this.status,
  }) : super(key: key);

  final String? id;
  final String? productName;
  final String? estimatedPrice;
  final String? createdAt;
  final String? updatedAt;
  final String? receiverId;
  final String? receiverName;
  final String? receiverPhone;
  final String? donorId;
  final String? donorName;
  final String? donorPhone;
  final String? status;

  @override
  _AdminOrdersFieldState createState() => _AdminOrdersFieldState();
}

class _AdminOrdersFieldState extends State<AdminOrdersField> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        PageNavigator(ctx: context).nextPage(
          page: AdminOrdersDetailScreen(
            orderId: widget.id,
            productName: widget.productName,
            estimatedPrice: widget.estimatedPrice,
            createdAt: widget.createdAt,
            updatedAt: widget.updatedAt ?? '0000-01-01T03:00:00.000000Z',
            receiverId: widget.receiverId,
            receiverName: widget.receiverName,
            receiverPhone: widget.receiverPhone,
            donorId: widget.donorId,
            donorName: widget.donorName,
            donorPhone: widget.donorPhone,
            status: widget.status,
          ),
        );
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
