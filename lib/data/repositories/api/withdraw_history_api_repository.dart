import 'dart:math';

import 'package:dio/dio.dart';
import 'package:shipper_app/data/models/order_model.dart';
import 'package:shipper_app/data/models/profile_model.dart';
import 'package:shipper_app/data/models/with_draw_model.dart';

import '../../../business_logic/repositories/withdraw_history_repository.dart';
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

class WithdrawHistoryApiRepository extends WithdrawHistoryRepository {
  final _dio = ApiClient.dioAuth;

  @override
  Future<ResponseModel<List<WithdrawModel>>> withdrawHistory() async {
    try {
      var res = await _dio.get(ApiRouter.withdrawHistory);
      var raw = RawSuccessModel.fromMap(res.data);
      return ResponseModel<List<WithdrawModel>>(
        type: ResponseModelType.success,
        data: (raw.data as List).map((e) => WithdrawModel.fromMap(e)).toList(),
      );
    } on DioError catch (ex) {
      if (ex.error is AppMessage) {
        return ResponseModel<List<WithdrawModel>>(
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
        return ResponseModel<List<WithdrawModel>>(
          type: ResponseModelType.failure,
          message: AppMessage(
            type: AppMessageType.error,
            title: raw.error ?? txtErrorTitle,
            content: raw.message ?? 'Không có dữ liệu trả về!',
          ),
        );
      }
    } on Exception catch (ex) {
      return ResponseModel<List<WithdrawModel>>(
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
