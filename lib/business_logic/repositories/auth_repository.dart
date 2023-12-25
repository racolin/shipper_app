import 'package:shipper_app/data/models/response_model.dart';

abstract class AuthRepository {

  ///
  /// Success: data = true, message = null (data always true)
  ///
  /// Failure: data = null, message != null
  ///
  Future<ResponseModel<bool>> login({
    required String phone,
  });

  ///
  /// Success: data = true, message = null (data always true)
  ///
  /// Failure: data = null, message != null
  ///
  Future<ResponseModel<bool>> otpCheck({
    required String phone,
    required String otp,
  });
}
