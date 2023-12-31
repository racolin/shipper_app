import 'package:dio/dio.dart';
import 'package:shipper_app/data/models/response_model.dart';

import '../../../business_logic/repositories/auth_repository.dart';
import '../../../exception/app_message.dart';

class AuthMockRepository extends AuthRepository {
  @override
  Future<ResponseModel<bool>> login({
    required String phone,
  }) async {
    return ResponseModel<bool>(
      type: ResponseModelType.success,
      data: true,
      // data: false,
    );
    return ResponseModel<bool>(
      type: ResponseModelType.failure,
      message: AppMessage(
        type: AppMessageType.error,
        title: 'Có lỗi!',
        content: 'Chưa đăng nhập được. Hãy thử lại!',
      ),
    );
  }

  @override
  Future<ResponseModel<bool>> otpCheck({
    required String phone,
    required String otp,
  }) async {
    return ResponseModel<bool>(
      type: ResponseModelType.success,
      data: true,
      // data: false,
    );
    return ResponseModel<bool>(
      type: ResponseModelType.failure,
      message: AppMessage(
        type: AppMessageType.error,
        title: 'Có lỗi!',
        content: 'Gặp sự cố khi kiểm tra OTP. Hãy thử lại!',
      ),
    );
  }
}
