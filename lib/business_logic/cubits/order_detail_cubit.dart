import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipper_app/data/models/response_model.dart';

import '../repositories/order_detial_repository.dart';
import '../states/order_detail_state.dart';

class OrderDetailCubit extends Cubit<OrderDetailState> {
  final OrderDetailRepository _repository;

  OrderDetailCubit({
    required OrderDetailRepository repository,
    required String id,
  })  : _repository = repository,
        super(OrderDetailInitial()) {
    _repository.getDetailOrder(orderId: id).then((res) {
      if (res.type == ResponseModelType.success) {
        emit(
          OrderDetailLoaded(
            model: res.data,
          ),
        );
      } else {
        emit(OrderDetailFailure(message: res.message));
      }
    });
  }
}
