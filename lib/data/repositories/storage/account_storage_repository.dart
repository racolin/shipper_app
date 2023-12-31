import 'package:flutter/services.dart';
import 'package:shipper_app/presentation/res/strings/values.dart';

import '../../../data/models/response_model.dart';
import '../../../business_logic/repositories/account_repository.dart';
import '../../services/secure_storage.dart';
import '../../../exception/app_message.dart';

class AccountStorageRepository extends AccountRepository {
  final _storage = SecureStorage();

  @override
  Future<ResponseModel<bool>> logout() async {
    try {
      await _storage.deleteAll();
      return const ResponseModel<bool>(
        type: ResponseModelType.success,
        data: true,
      );
    } on PlatformException catch (ex) {
      return ResponseModel<bool>(
        type: ResponseModelType.failure,
        message: AppMessage(
          type: AppMessageType.failure,
          title: 'Có lỗi',
          content: 'Quá trình đăng xuất gặp vấn đề. Hãy thử lại!',
          description: ex.toString(),
        ),
      );
    }
  }

  @override
  Future<ResponseModel<bool>> isLogin() async {
    try {
      var res = await _storage.getToken();
      if (res.type == ResponseModelType.success) {
        return const ResponseModel<bool>(
          type: ResponseModelType.success,
          data: true,
        );
      } else {
        return const ResponseModel<bool>(
          type: ResponseModelType.success,
          data: false,
        );
      }
    } on PlatformException catch (ex) {
      return ResponseModel<bool>(
        type: ResponseModelType.failure,
        message: AppMessage(
          type: AppMessageType.error,
          title: txtErrorTitle,
          content: 'Lỗi khi kiểm tra trạng thái đăng nhập',
          description: ex.toString(),
        ),
      );
    }
  }
}
