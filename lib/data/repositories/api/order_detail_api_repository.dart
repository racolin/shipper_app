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
        data:
        // OrderDetailModel.fromMap({
        //   "receiver": {
        //     "name": "Tín",
        //     "phone": "+84931592381",
        //     "address": "01 Võ Văn Ngân, Linh Chiểu, Thủ Đức, Thành phố Hồ Chí Minh, Việt Nam",
        //     "lat": 10.8506324,
        //     "lng": 106.7719131
        //   },
        //   "store": {
        //     "name": "TCC Hoàng Diệu 2",
        //     "address": "322 Nguyễn Thị Thập, Phú Thuận, Quận 7, Hồ Chí ",
        //     "phone": "02821201717",
        //     "lat": 10.8526199,
        //     "lng": 106.7450425
        //   },
        //   "code": "O2SFM5EDCW",
        //   "id": "658889ecbdc3d5a9569042ec",
        //   "items": [
        //     {
        //       "id": "644cdd386b1ed80d5ae1cad8",
        //       "name": "Cà phê đen đá",
        //       "amount": 1,
        //       "note": "Vừa"
        //     },
        //     {
        //       "id": "644cdd386b1ed80d5ae1cad8",
        //       "name": "Cà phê sữa",
        //       "amount": 3,
        //       "note": "Vừa"
        //     }
        //   ],
        //   "quantity": 4,
        //   "totalPrice": 135000,
        //   "shippingFee": 25000,
        //   "paymentType": 0,
        //   "timeLog": [
        //     {
        //       "time": 1703447020336,
        //       "title": "Chờ thanh toán",
        //       "description": "Thực hiện thanh toán để hoàn thành đặt đơn hàng"
        //     },
        //     {
        //       "time": 1703447564284,
        //       "title": "Thanh toán thành công"
        //     },
        //     {
        //       "time": 1703447816766,
        //       "title": "Đã tìm thấy tài xế",
        //       "description": "Đơn hàng được nhận bởi tài xế Nguyễn Quang Vinh - SĐT: 0347070634"
        //     }
        //   ],
        //   "review": null,
        //   "createdAt": 1703447020349,
        //   "shipDistance": 2946.0520751615595
        // }),
        OrderDetailModel.fromMap(raw.data),
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
