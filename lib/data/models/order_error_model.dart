class OrderErrorModel {
  final String message;
  final String orderId;

  const OrderErrorModel({
    required this.message,
    required this.orderId,
  });

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'message': message,
    };
  }

  factory OrderErrorModel.fromMap(Map<String, dynamic> map) {
    return OrderErrorModel(
      orderId: map['orderId'] as String,
      message: map['message'] as String,
    );
  }
}