import 'package:shipper_app/data/models/order_error_model.dart';
import 'package:shipper_app/data/models/order_model.dart';

import '../../data/models/error_socket_model.dart';
import '../../data/models/response_model.dart';

abstract class PickOrderRepository {
  Stream<OrderModel> get newOrder;
  Stream<String> get cancelOrder;
  Stream<String> get pickOrderSuccess;
  Stream<OrderErrorModel> get pickOrderError;
  Stream<String> get removePickedOrder;
  Stream<ErrorSocketModel> get error;

  void pickOrder({required String orderId});

  Future<ResponseModel<List<OrderModel>>> getCurrentOrder({
    required double lat,
    required double lng,
  });

  void close();
}