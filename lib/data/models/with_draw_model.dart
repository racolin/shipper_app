class WithdrawModel {
  final String status;
  final String id;
  final int amount;
  final DateTime createAt;

  const WithdrawModel({
    required this.id,
    required this.status,
    required this.amount,
    required this.createAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'status': status,
      'amount': amount,
      'createAt': createAt.millisecondsSinceEpoch,
    };
  }

  factory WithdrawModel.fromMap(Map<String, dynamic> map) {
    return WithdrawModel(
      id: map['id'] as String,
      status: map['status'] as String,
      amount: map['amount'] as int,
      createAt: map['createAt'] == null
          ? DateTime.now()
          : DateTime.fromMillisecondsSinceEpoch(map['createAt']),
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
