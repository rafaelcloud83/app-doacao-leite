import 'dart:convert';

class OrderUpdateModel {
  int? id;
  String? productName;
  String? estimatedPrice;
  String? status;
  Receiver? receiver;
  Donor? donor;
  OrderUpdateModel({
    this.id,
    this.productName,
    this.estimatedPrice,
    this.status,
    this.receiver,
    this.donor,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'productName': productName,
      'estimatedPrice': estimatedPrice,
      'status': status,
      'receiver': receiver?.toMap(),
      'donor': donor?.toMap(),
    };
  }

  factory OrderUpdateModel.fromMap(Map<String, dynamic> map) {
    return OrderUpdateModel(
      id: map['id'] as int,
      productName:
          map['productName'] != null ? map['productName'] as String : null,
      estimatedPrice: map['estimatedPrice'] != null
          ? map['estimatedPrice'] as String
          : null,
      status: map['status'] != null ? map['status'] as String : null,
      receiver: map['receiver'] != null
          ? Receiver.fromMap(map['receiver'] as Map<String, dynamic>)
          : null,
      donor: map['donor'] != null
          ? Donor.fromMap(map['donor'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderUpdateModel.fromJson(String source) =>
      OrderUpdateModel.fromMap(json.decode(source) as Map<String, dynamic>);
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

class Donor {
  final int id;
  Donor({
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
    };
  }

  factory Donor.fromMap(Map<String, dynamic> map) {
    return Donor(
      id: map['id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Donor.fromJson(String source) =>
      Donor.fromMap(json.decode(source) as Map<String, dynamic>);
}
