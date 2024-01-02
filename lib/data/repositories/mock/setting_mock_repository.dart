import 'package:shipper_app/data/models/delivering_model.dart';
import 'package:shipper_app/data/models/order_model.dart';
import 'package:shipper_app/data/models/profile_model.dart';

import 'package:shipper_app/data/models/response_model.dart';

import '../../../business_logic/repositories/setting_repository.dart';

class SettingMockRepository extends SettingRepository {
  @override
  Future<ResponseModel<bool>> changeNotify() {
    // TODO: implement changeNotify
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<DeliveringModel>> deliveringOrder() {
    // TODO: implement deliveringOrder
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<MapEntry<int, List<OrderModel>>>> getListOrder(
      {int? page, int? limit, int? time}) {
    // TODO: implement getListOrder
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<ProfileModel>> getProfile() {
    // TODO: implement getProfile
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<bool>> requestWithdraw({required int amount}) {
    // TODO: implement requestWithdraw
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<bool>> evidence({
    required String orderId,
    int? status,
    required String evidence,
  }) {
    // TODO: implement updateOrderState
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<bool>> updateProfile(
      {required String lastName, required String firstName}) {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<bool>> updateStatus({required String orderId, int? status}) {
    // TODO: implement updateStatus
    throw UnimplementedError();
  }
}
