import 'package:shipper_app/data/models/order_model.dart';

class OrderDetailModel extends OrderModel {
  final String code;
  final List<OrderTimeLogModel> timeLog;
  final OrderReviewModel? review;
  final List<OrderItemModel> items;
  final String? shippedEvidence;

  const OrderDetailModel({
    required this.code,
    required this.timeLog,
    required this.items,
    this.review,
    this.shippedEvidence,
    required super.id,
    required super.quantity,
    super.pickDistance,
    required super.totalPrice,
    required super.shippingFee,
    required super.paymentType,
    required super.receiver,
    required super.store,
    required super.shipDistance,
    required super.createAt,
    required super.shipperIncome,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'timeLog': timeLog.map((e) => e.toMap()),
      'review': review?.toMap(),
      'id': id,
      'items': items.map((e) => e.toMap()),
      'quantity': quantity,
      'totalPrice': totalPrice,
      'shippingFee': shippingFee,
      'paymentType': paymentType,
      'pickDistance': pickDistance,
      'receiver': receiver,
      'store': store,
      'shipDistance': shipDistance,
      'shippedEvidence': shippedEvidence,
      'createAt': createAt.millisecondsSinceEpoch,
    };
  }

  @override
  factory OrderDetailModel.fromMap(Map<String, dynamic> map) {
    return OrderDetailModel(
      code: map['code'] as String,
      timeLog: (map['timeLog'] as List).map((e) => OrderTimeLogModel.fromMap(e)).toList(),
      review: map['review'] == null ? null : OrderReviewModel.fromMap(map['review']),
      id: map['id'] as String,
      items: (map['items'] as List).map((e) => OrderItemModel.fromMap(e)).toList(),
      quantity: map['quantity'] as int,
      totalPrice: map['totalPrice'] as int,
      pickDistance: map['pickDistance'],
      shipperIncome: map['shipperIncome'] as int,
      shippingFee: map['shippingFee'] as int,
      paymentType: map['paymentType'] as int,
      shippedEvidence: map['shippedEvidence'],
      receiver:  OrderReceiverModel.fromMap(map['receiver']),
      store: OrderStoreModel.fromMap(map['store']),
      shipDistance: (map['shipDistance'] as num).toInt(),
      createAt: map['createAt'] == null ? DateTime.now() : DateTime.fromMillisecondsSinceEpoch(map['createAt']),
    );
  }
}

class OrderItemModel {
  final String id;
  final String name;
  final int amount;
  final String note;

  const OrderItemModel({
    required this.id,
    required this.name,
    required this.amount,
    required this.note,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
      'note': note,
    };
  }

  factory OrderItemModel.fromMap(Map<String, dynamic> map) {
    return OrderItemModel(
      id: map['id'] as String,
      name: map['name'] as String,
      amount: map['amount'] as int,
      note: map['note'] as String,
    );
  }
}

class OrderTimeLogModel {
  final DateTime time;
  final String title;
  final String description;

  const OrderTimeLogModel({
    required this.time,
    required this.title,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'time': time.millisecondsSinceEpoch,
      'title': title,
      'description': description,
    };
  }

  factory OrderTimeLogModel.fromMap(Map<String, dynamic> map) {
    return OrderTimeLogModel(
      time: map['time'] == null ? DateTime.now() : DateTime.fromMillisecondsSinceEpoch(map['time']),
      title: map['title'] as String,
      description: map['description'] ?? '',
    );
  }
}

class OrderReviewModel {
  final int rate;
  final String description;

  const OrderReviewModel({
    required this.rate,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'rate': rate,
      'description': description,
    };
  }

  factory OrderReviewModel.fromMap(Map<String, dynamic> map) {
    return OrderReviewModel(
      rate: map['rate'] as int,
      description: map['description'] as String,
    );
  }
}