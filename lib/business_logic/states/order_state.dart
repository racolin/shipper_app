import 'package:shipper_app/data/models/order_model.dart';
import 'package:shipper_app/exception/app_message.dart';

abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  final double lat;
  final double lng;
  final List<OrderModel> orders;

  OrderLoaded({
    required this.orders,
    required this.lat,
    required this.lng,
  });

  OrderLoaded copyWith({
    List<OrderModel>? orders,
    double? lat,
    double? lng,
  }) {
    return OrderLoaded(
      orders: orders ?? this.orders,
      lng: lng ?? this.lng,
      lat: lat ?? this.lat,
    );
  }
}

class OrderFailure extends OrderState {
  final AppMessage message;

  OrderFailure({
    required this.message,
  });
}
