import 'package:shipper_app/exception/app_message.dart';

import '../../data/models/order_detail_model.dart';

abstract class OrderDetailState {}

class OrderDetailInitial extends OrderDetailState {}

class OrderDetailLoading extends OrderDetailState {}

class OrderDetailLoaded extends OrderDetailState {
  final OrderDetailModel model;

  OrderDetailLoaded({
    required this.model,
  });

  OrderDetailLoaded copyWith({
    OrderDetailModel? model,
  }) {
    return OrderDetailLoaded(
      model: model ?? this.model,
    );
  }
}

class OrderDetailFailure extends OrderDetailState {
  final AppMessage message;

  OrderDetailFailure({
    required this.message,
  });
}
