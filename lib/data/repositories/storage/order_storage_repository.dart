import '../../../business_logic/repositories/order_repository.dart';
import '../../../data/models/order_detail_model.dart';
import '../../../data/models/order_model.dart';
import '../../models/order_model.dart';
import '../../models/response_model.dart';

class OrderStorageRepository extends OrderRepository {
  @override
  Future<ResponseModel<List<OrderModel>>> getCurrentOrder({required double lat, required double lng}) {
    // TODO: implement getCurrentOrder
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<OrderDetailModel>> getDetailOrder({required String orderId}) {
    // TODO: implement getDetailOrder
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<List<OrderModel>>> getListOrder({int? page, int? limit, int? time}) {
    // TODO: implement getListOrder
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<bool>> updateOrderState({required String orderId, int? status}) {
    // TODO: implement updateOrderState
    throw UnimplementedError();
  }
}
