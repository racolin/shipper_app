enum PaymentType {
  momo('Momo', 'assets/images/momo.png'),
  cash('Tiền mặt', 'assets/images/cash.png');

  final String name;
  final String image;

  const PaymentType(this.name, this.image);
}

class OrderModel {
  final String id;
  final int quantity;
  final int totalPrice;
  final int shippingFee;
  final int paymentType;
  final OrderReceiverModel receiver;
  final OrderStoreModel store;
  final double shipDistance;
  final double? pickDistance;
  final DateTime createAt;

  const OrderModel({
    required this.id,
    required this.quantity,
    required this.totalPrice,
    required this.shippingFee,
    required this.paymentType,
    required this.receiver,
    required this.store,
    this.pickDistance,
    required this.shipDistance,
    required this.createAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quantity': quantity,
      'totalPrice': totalPrice,
      'shippingFee': shippingFee,
      'paymentType': paymentType,
      'receiver': receiver,
      'store': store,
      'shipDistance': shipDistance,
      'pickDistance': pickDistance,
      'createAt': createAt.millisecondsSinceEpoch,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] as String,
      quantity: map['quantity'] as int,
      totalPrice: map['totalPrice'] as int,
      shippingFee: map['shippingFee'] as int,
      paymentType: map['paymentType'] as int,
      pickDistance: map['pickDistance'],
      receiver:  OrderReceiverModel.fromMap(map['receiver']),
      store: OrderStoreModel.fromMap(map['store']),
      shipDistance: (map['shipDistance'] is double) ? map['shipDistance'] : (map['shipDistance'] as int).toDouble(),
      createAt: map['createAt'] != null ? DateTime.fromMillisecondsSinceEpoch(map['createAt']) : DateTime.now(),
    );
  }
}

class OrderReceiverModel {
  final String name;
  final String phone;
  final String address;
  final double lat;
  final double lng;

  const OrderReceiverModel({
    required this.name,
    required this.phone,
    required this.address,
    required this.lat,
    required this.lng,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'address': address,
      'lat': lat,
      'lng': lng,
    };
  }

  factory OrderReceiverModel.fromMap(Map<String, dynamic> map) {
    return OrderReceiverModel(
      name: map['name'] as String,
      phone: map['phone'] as String,
      address: map['address'] as String,
      lat: (map['lat'] as num).toDouble(),
      lng: (map['lng'] as num).toDouble(),
    );
  }

}

class OrderStoreModel {
  final String name;
  final String phone;
  final String address;
  final double lat;
  final double lng;

  const OrderStoreModel({
    required this.name,
    required this.phone,
    required this.address,
    required this.lat,
    required this.lng,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'address': address,
      'lat': lat,
      'lng': lng,
    };
  }

  factory OrderStoreModel.fromMap(Map<String, dynamic> map) {
    return OrderStoreModel(
      name: map['name'] as String,
      phone: map['phone'] as String,
      address: map['address'] as String,
      lat: (map['lat'] as num).toDouble(),
      lng: (map['lng'] as num).toDouble(),
    );
  }
}