import '../../data/models/delivering_model.dart';
import '../../data/models/order_model.dart';
import '../../data/models/profile_model.dart';
import '../../data/models/response_model.dart';

abstract class SettingRepository {
  Future<ResponseModel<ProfileModel>> getProfile();

  Future<ResponseModel<bool>> updateProfile({
    required String lastName,
    required String firstName,
  });

  Future<ResponseModel<bool>> requestWithdraw({
    required int amount,
  });

  Future<ResponseModel<bool>> changeNotify();

  ///
  /// time:
  /// - time = 0 all
  /// - time = 1 in day
  /// - time = 2 in week
  /// - time = 3 in month
  ///
  Future<ResponseModel<MapEntry<int, List<OrderModel>>>> getListOrder({
    int? page,
    int? limit,
    int? time,
  });

  Future<ResponseModel<DeliveringModel>> deliveringOrder();

  Future<ResponseModel<bool>> updateOrderState({
    required String orderId,
    int? status,
  });
}
