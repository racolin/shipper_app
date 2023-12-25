import '../../data/models/order_model.dart';
import '../../data/models/response_model.dart';

abstract class OrderRepository {
  ///
  /// Success: data is [ResponseModel<MapEntry<int, List<OrderModel>>>], message = null
  ///
  /// - key (int) is maxCount
  ///
  /// - value is List<OrderModel>
  ///
  /// Failure: data = null, message != null
  ///
  Future<ResponseModel<List<OrderModel>>> getCurrentOrder({
    required double lat,
    required double lng,
  });
}
