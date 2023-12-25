import '../../data/models/order_detail_model.dart';
import '../../data/models/response_model.dart';

abstract class OrderDetailRepository {
  Future<ResponseModel<OrderDetailModel>> getDetailOrder({
    required String orderId,
  });
}
