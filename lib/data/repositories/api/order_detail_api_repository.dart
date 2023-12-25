import 'dart:math';

import 'package:dio/dio.dart';
import 'package:shipper_app/data/models/order_model.dart';
import 'package:shipper_app/data/models/profile_model.dart';

import '../../../business_logic/repositories/order_detial_repository.dart';
import '../../models/order_detail_model.dart';
import '../../models/order_model.dart';
import '../../models/response_model.dart';
import '../../services/api_client.dart';
import '../../../presentation/res/strings/values.dart';
import '../../../business_logic/repositories/setting_repository.dart';
import '../../../exception/app_message.dart';
import '../../models/raw_failure_model.dart';
import '../../models/raw_success_model.dart';
import '../../services/config.dart';

class OrderDetailApiRepository extends OrderDetailRepository {
  final _dio = ApiClient.dioAuth;
  @override
  Future<ResponseModel<OrderDetailModel>> getDetailOrder({
    required String orderId,
  }) async {
    try {
      var res = await _dio.get(
        ApiRouter.detailOrder(orderId),
      );
      var raw = RawSuccessModel.fromMap(res.data);
      return ResponseModel<OrderDetailModel>(
        type: ResponseModelType.success,
        data: OrderDetailModel.fromMap(raw.data),
      );
    } on DioError catch (ex) {
      if (ex.error is AppMessage) {
        return ResponseModel<OrderDetailModel>(
          type: ResponseModelType.failure,
          message: ex.error,
        );
      } else {
        var raw = RawFailureModel.fromMap(
          ex.response?.data ??
              {
                'statusCode': 444,
                'message': 'Không có dữ liệu trả về!',
              },
        );
        return ResponseModel<OrderDetailModel>(
          type: ResponseModelType.failure,
          message: AppMessage(
            type: AppMessageType.error,
            title: raw.error ?? txtErrorTitle,
            content: raw.message ?? 'Không có dữ liệu trả về!',
          ),
        );
      }
    } on Exception catch (ex) {
      return ResponseModel<OrderDetailModel>(
        type: ResponseModelType.failure,
        message: AppMessage(
          title: txtErrorTitle,
          type: AppMessageType.error,
          content: 'Chưa phân tích được lỗi',
          description: ex.toString(),
        ),
      );
    }
  }
}
