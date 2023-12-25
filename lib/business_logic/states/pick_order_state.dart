import 'package:shipper_app/data/models/order_model.dart';
import 'package:shipper_app/exception/app_message.dart';

abstract class PickOrderState {}

class PickOrderInitial extends PickOrderState {}

class PickOrderLoading extends PickOrderState {}

class PickOrderLoaded extends PickOrderState {
  final List<OrderModel> orders;
  final double lat;
  final double lng;

  PickOrderLoaded({
    required this.orders,
    required this.lat,
    required this.lng,
  });

  PickOrderLoaded copyWith({
    List<OrderModel>? orders,
    double? lat,
    double? lng,
  }) {
    return PickOrderLoaded(
      orders: orders ?? this.orders,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }
}

class PickOrderSuccess extends PickOrderState {
  final String orderId;

  PickOrderSuccess({
    required this.orderId,
  });

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
    };
  }

  factory PickOrderSuccess.fromMap(Map<String, dynamic> map) {
    return PickOrderSuccess(
      orderId: map['orderId'] as String,
    );
  }
}

class PickOrderFailure extends PickOrderState {
  final AppMessage message;

  PickOrderFailure({
    required this.message,
  });
}
