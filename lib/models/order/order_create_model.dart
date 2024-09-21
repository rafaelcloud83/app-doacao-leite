import 'dart:convert';

class OrderCreateModel {
  String? id;
  String? productName;
  String? estimatedPrice;
  Receiver? receiver;
  OrderCreateModel({
    this.id,
    this.productName,
    this.estimatedPrice,
    this.receiver,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'productName': productName,
      'estimatedPrice': estimatedPrice,
      'receiver': receiver?.toMap(),
    };
  }

  factory OrderCreateModel.fromMap(Map<String, dynamic> map) {
    return OrderCreateModel(
      id: map['id'] != null ? map['id'] as String : null,
      productName:
          map['productName'] != null ? map['productName'] as String : null,
      estimatedPrice: map['estimatedPrice'] != null
          ? map['estimatedPrice'] as String
          : null,
      receiver: map['receiver'] != null
          ? Receiver.fromMap(map['receiver'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderCreateModel.fromJson(String source) =>
      OrderCreateModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Receiver {
  final int id;
  Receiver({
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
    };
  }

  factory Receiver.fromMap(Map<String, dynamic> map) {
    return Receiver(
      id: map['id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Receiver.fromJson(String source) =>
      Receiver.fromMap(json.decode(source) as Map<String, dynamic>);
}
