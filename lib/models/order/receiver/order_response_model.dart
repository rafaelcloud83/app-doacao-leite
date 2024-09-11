import 'dart:convert';

OrderResponseModel orderResponseModelFromJson(String str) =>
    OrderResponseModel.fromJson(json.decode(str));

String orderResponseModelToJson(OrderResponseModel data) =>
    json.encode(data.toJson());

class OrderResponseModel {
  List<Order>? orders;

  OrderResponseModel({
    this.orders,
  });

  factory OrderResponseModel.fromJson(Map<String, dynamic> json) =>
      OrderResponseModel(
        orders: List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "orders": List<dynamic>.from(orders!.map((x) => x.toJson())),
      };
}

class Order {
  int? id;
  String? productName;
  String? estimatedPrice;
  String? status;
  Receiver? receiver;
  Donor? donor;

  Order({
    this.id,
    this.productName,
    this.estimatedPrice,
    this.status,
    this.receiver,
    this.donor,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        productName: json["productName"],
        estimatedPrice: json["estimatedPrice"],
        status: json["status"],
        receiver: Receiver.fromJson(json["receiver"]),
        donor: Donor.fromJson(json["donor"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "productName": productName,
        "estimatedPrice": estimatedPrice,
        "status": status,
        "receiver": receiver?.toJson(),
        "donor": donor?.toJson(),
      };
}

class Donor {
  int? id;
  String? donorName;
  String? donorPhone;
  String? donorAddress;

  Donor({
    this.id,
    this.donorName,
    this.donorPhone,
    this.donorAddress,
  });

  factory Donor.fromJson(Map<String, dynamic> json) => Donor(
        id: json["id"],
        donorName: json["name"],
        donorPhone: json["phone"],
        donorAddress: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": donorName,
        "phone": donorPhone,
        "address": donorAddress,
      };
}

class Receiver {
  int? id;
  String? receiverName;
  String? receiverPhone;
  String? receiverAddress;

  Receiver({
    this.id,
    this.receiverName,
    this.receiverPhone,
    this.receiverAddress,
  });

  factory Receiver.fromJson(Map<String, dynamic> json) => Receiver(
        id: json["id"],
        receiverName: json["name"],
        receiverPhone: json["phone"],
        receiverAddress: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": receiverName,
        "phone": receiverPhone,
        "address": receiverAddress,
      };
}
