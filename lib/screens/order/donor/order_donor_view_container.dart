import 'package:doacao_leite/screens/order/donor/order_donor_confirm_donate_screen.dart';
import 'package:doacao_leite/screens/order/donor/order_donor_status_detail.dart';
import 'package:doacao_leite/utils/routers.dart';
import 'package:flutter/material.dart';

class OrderDonorField extends StatefulWidget {
  OrderDonorField({
    Key? key,
    this.id,
    this.productName,
    this.estimatedPrice,
    this.receiverId,
    this.receiverName,
    this.receiverPhone,
    this.receiverAddress,
    this.donorId,
    this.status,
  }) : super(key: key);

  final String? id;
  final String? productName;
  final String? estimatedPrice;
  final String? receiverId;
  final String? receiverName;
  final String? receiverPhone;
  final String? receiverAddress;
  final String? donorId;
  final String? status;

  @override
  _OrderDonorFieldState createState() => _OrderDonorFieldState();
}

class _OrderDonorFieldState extends State<OrderDonorField> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (widget.status == 'AGUARDANDO') {
          //ir para página de confirmar doação
          PageNavigator(ctx: context).nextPage(
            page: OrderDonorConfirmDonateScreen(
              orderId: widget.id,
              productName: widget.productName,
              estimatedPrice: widget.estimatedPrice,
              receiverId: widget.receiverId,
              receiverName: widget.receiverName,
              receiverPhone: widget.receiverPhone,
              receiverAddress: widget.receiverAddress,
              donorId: widget.donorId,
              status: widget.status,
            ),
          );
          return;
        } else {
          //mostrar detalhes da doação
          PageNavigator(ctx: context).nextPage(
            page: OrderDonorStatusDetailScreen(
              orderId: widget.id,
              productName: widget.productName,
              estimatedPrice: widget.estimatedPrice,
              receiverId: widget.receiverId,
              receiverName: widget.receiverName,
              receiverPhone: widget.receiverPhone,
              receiverAddress: widget.receiverAddress,
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
