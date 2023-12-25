import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shipper_app/exception/app_message.dart';
import '../../data/models/response_model.dart';
import '../../data/services/secure_storage.dart';
import '../repositories/pick_order_repository.dart';
import '../states/pick_order_state.dart';

class PickOrderCubit extends Cubit<PickOrderState> {
  final PickOrderRepository _repository;
  final _storage = SecureStorage();

  PickOrderCubit({required PickOrderRepository repository})
      : _repository = repository,
        super(PickOrderInitial()) {
    _storage.getLatLng().then((res) {
      if (res.type == ResponseModelType.success) {
        var lat = res.data.latitude;
        var lng = res.data.longitude;
        _repository.getCurrentOrder(lat: lat, lng: lng).then((res) {
          if (res.type == ResponseModelType.success) {
            emit(
              PickOrderLoaded(
                orders: res.data,
                lat: lat,
                lng: lng,
              ),
            );
            _repository.error.listen((event) {
              emit(
                PickOrderFailure(
                  message: AppMessage(
                    type: AppMessageType.failure,
                    title: event.message,
                    content: '',
                  ),
                ),
              );
            });
            _repository.cancelOrder.listen((event) {
              if (state is PickOrderLoaded) {
                var list = (state as PickOrderLoaded).orders;
                list.removeWhere((e) => e.id == event);

                if (list.length != (state as PickOrderLoaded).orders.length) {
                  emit(PickOrderLoaded(orders: list, lat: lat, lng: lng));
                }
              }
            });
            _repository.newOrder.listen((event) {
              if (state is PickOrderLoaded) {
                var list = (state as PickOrderLoaded).orders;
                list.add(event);
                emit(PickOrderLoaded(orders: list, lat: lat, lng: lng));
              }
            });
            _repository.pickOrderError.listen((event) {
              emit(
                PickOrderFailure(
                  message: AppMessage(
                    type: AppMessageType.failure,
                    title: event.message,
                    content: event.orderId,
                  ),
                ),
              );
            });
            _repository.pickOrderSuccess.listen((event) {
              emit(PickOrderSuccess(orderId: event));
            });
            _repository.removePickedOrder.listen((event) {
              if (state is PickOrderLoaded) {
                var list = (state as PickOrderLoaded).orders;
                list.removeWhere((e) => e.id == event);

                if (list.length != (state as PickOrderLoaded).orders.length) {
                  emit(PickOrderLoaded(orders: list, lat: lat, lng: lng));
                }
              }
            });
          } else {
            emit(PickOrderFailure(message: res.message));
          }
        });
      }
      emit(
        PickOrderFailure(
          message: AppMessage(
            type: AppMessageType.failure,
            title: 'Thất bại',
            content: 'Không lấy được toạ độ hiện tại để nhận đơn hàng!',
          ),
        ),
      );
    });
  }

  void pickOrder(String orderId) {
    _repository.pickOrder(orderId: orderId);
  }

  @override
  Future<void> close() {
    _repository.close();
    return super.close();
  }
// base method: return response model, use to avoid repeat code.
}
