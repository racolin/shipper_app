import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shipper_app/data/models/delivering_model.dart';
import 'package:shipper_app/data/models/order_model.dart';
import 'package:shipper_app/data/models/profile_model.dart';

import '../../models/response_model.dart';
import '../../services/api_client.dart';
import '../../../presentation/res/strings/values.dart';
import '../../../business_logic/repositories/setting_repository.dart';
import '../../../exception/app_message.dart';
import '../../models/raw_failure_model.dart';
import '../../models/raw_success_model.dart';
import '../../services/config.dart';

class SettingApiRepository extends SettingRepository {
  final _dio = ApiClient.dioAuth;

  @override
  Future<ResponseModel<bool>> changeNotify() async {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<MapEntry<int, List<OrderModel>>>> getListOrder({
    int? page,
    int? limit,
    int? time,
  }) async {
    try {
      var res = await _dio.get(
        ApiRouter.listOrder,
        queryParameters: {
          'page': page,
          'limit': limit,
          'time': time,
        },
      );
      var raw = RawSuccessModel.fromMap(res.data);

      return ResponseModel<MapEntry<int, List<OrderModel>>>(
        type: ResponseModelType.success,
        data: MapEntry<int, List<OrderModel>>(
          12,
          [
            {
              "receiver": {
                "name": "Tín",
                "phone": "+84931592381",
                "address": "01 Võ Văn Ngân, Linh Chiểu, Thủ Đức, Thành phố Hồ Chí Minh, Việt Nam",
                "lat": 10.8506324,
                "lng": 106.7719131
              },
              "store": {
                "name": "TCC Hoàng Diệu 2",
                "address": "322 Nguyễn Thị Thập, Phú Thuận, Quận 7, Hồ Chí ",
                "phone": "02821201717",
                "lat": 10.8526199,
                "lng": 106.7450425
              },
              "id": "658889ecbdc3d5a9569042ec",
              "quantity": 1,
              "totalPrice": 35000,
              "shippingFee": 30000,
              "paymentType": 0,
              "createdAt": 1703447020349,
              "shipDistance": 2946.0520751615595
            },
            {
              "receiver": {
                "name": "Tín",
                "phone": "+84931592381",
                "address": "70 Đ. Lữ Gia, Phường 15, Quận 11, Thành phố Hồ Chí Minh 700000, Việt Nam",
                "lat": 10.7715686,
                "lng": 106.6532635
              },
              "store": {
                "name": "TCC Nguyễn Thị Thập",
                "address": "322 Nguyễn Thị Thập, Phú Thuận, Quận 7, Hồ Chí ",
                "phone": "02829284186",
                "lat": 10.739751,
                "lng": 106.7027951
              },
              "id": "65854d38886ec7924af842b7",
              "quantity": 1,
              "totalPrice": 55000,
              "shippingFee": 25000,
              "paymentType": 1,
              "createdAt": 1703234872705,
              "shipDistance": 6472.148222159505
            },
            {
              "receiver": {
                "name": "Tín",
                "phone": "+84931592381",
                "address": "233 Test street, Hồ Chí Minh",
                "lat": 0,
                "lng": 0
              },
              "store": {
                "name": "TCC Nguyễn Thị Thập",
                "address": "322 Nguyễn Thị Thập, Phú Thuận, Quận 7, Hồ Chí ",
                "phone": "02829284186",
                "lat": 10.739751,
                "lng": 106.7027951
              },
              "id": "658520b69306924eec519b38",
              "quantity": 2,
              "totalPrice": 80000,
              "shippingFee": 25000,
              "paymentType": 1,
              "createdAt": 1703223478062,
              "shipDistance": 11844603.19264867
            },
            {
              "receiver": {
                "name": "Any",
                "phone": "+84327165374",
                "address": "Landmark",
                "lat": 10,
                "lng": 100
              },
              "store": {
                "name": "TCC Nguyễn Thị Thập",
                "address": "322 Nguyễn Thị Thập, Phú Thuận, Quận 7, Hồ Chí ",
                "phone": "02829284186",
                "lat": 10.739751,
                "lng": 106.7027951
              },
              "id": "658500c37441f45df03cb5b2",
              "quantity": 1,
              "totalPrice": 55000,
              "shippingFee": 20000,
              "paymentType": 0,
              "createdAt": 1703215299492,
              "shipDistance": 738550.4061370749
            },
            {
              "receiver": {
                "name": "Tín",
                "phone": "+84931592381",
                "address": "233 Test street, Hồ Chí Minh",
                "lat": 0,
                "lng": 0
              },
              "store": {
                "name": "TCC Nguyễn Thị Thập",
                "address": "322 Nguyễn Thị Thập, Phú Thuận, Quận 7, Hồ Chí ",
                "phone": "02829284186",
                "lat": 10.739751,
                "lng": 106.7027951
              },
              "id": "6584d898005f24bae856b814",
              "quantity": 1,
              "totalPrice": 61000,
              "shippingFee": 0,
              "paymentType": 1,
              "createdAt": 1703205016661,
              "shipDistance": 11844603.19264867
            },
            {
              "receiver": {
                "name": "Dhien",
                "phone": "+84931592381",
                "address": "233 Nguyễn Văn Cừ, An Hòa, Cần Thơ",
                "lat": 0,
                "lng": 0
              },
              "store": {
                "name": "TCC Nguyễn Thị Thập",
                "address": "322 Nguyễn Thị Thập, Phú Thuận, Quận 7, Hồ Chí ",
                "phone": "02829284186",
                "lat": 10.739751,
                "lng": 106.7027951
              },
              "id": "6584d785005f24bae856b7cb",
              "quantity": 2,
              "totalPrice": 96000,
              "shippingFee": 0,
              "paymentType": 1,
              "createdAt": 1703204741687,
              "shipDistance": 11844603.19264867
            },
            {
              "receiver": {
                "name": "VinhNQ",
                "phone": "+84327456789",
                "address": "224A Điện Biên Phủ, Quận 3, Hồ Chí Minh",
                "lat": 0,
                "lng": 0
              },
              "store": {
                "name": "TCC Nguyễn Thị Thập",
                "address": "322 Nguyễn Thị Thập, Phú Thuận, Quận 7, Hồ Chí ",
                "phone": "02829284186",
                "lat": 10.739751,
                "lng": 106.7027951
              },
              "id": "6584d6d8005f24bae856b754",
              "quantity": 1,
              "totalPrice": 75000,
              "shippingFee": 0,
              "paymentType": 1,
              "createdAt": 1703204568276,
              "shipDistance": 11844603.19264867
            },
            {
              "receiver": {
                "name": "Dhien",
                "phone": "+84931592381",
                "address": "233 Nguyễn Văn Cừ, An Hòa, Cần Thơ",
                "lat": 0,
                "lng": 0
              },
              "store": {
                "name": "TCC Nguyễn Thị Thập",
                "address": "322 Nguyễn Thị Thập, Phú Thuận, Quận 7, Hồ Chí ",
                "phone": "02829284186",
                "lat": 10.739751,
                "lng": 106.7027951
              },
              "id": "6584d2b1005f24bae856b6e6",
              "quantity": 2,
              "totalPrice": 64000,
              "shippingFee": 0,
              "paymentType": 1,
              "createdAt": 1703203505730,
              "shipDistance": 11844603.19264867
            },
            {
              "receiver": {
                "name": "VinhNQ",
                "phone": "+84327456789",
                "address": "224A Điện Biên Phủ, Quận 3, Hồ Chí Minh",
                "lat": 0,
                "lng": 0
              },
              "store": {
                "name": "TCC Nguyễn Thị Thập",
                "address": "322 Nguyễn Thị Thập, Phú Thuận, Quận 7, Hồ Chí ",
                "phone": "02829284186",
                "lat": 10.739751,
                "lng": 106.7027951
              },
              "id": "6584d170005f24bae856b6cc",
              "quantity": 5,
              "totalPrice": 229000,
              "shippingFee": 0,
              "paymentType": 1,
              "createdAt": 1703203184288,
              "shipDistance": 11844603.19264867
            },
            {
              "receiver": {
                "name": "Tin",
                "phone": "+84344234584",
                "address": "string",
                "lat": 10.715183720857304,
                "lng": 106.73752531942976
              },
              "store": {
                "name": "TCC Huỳnh Tấn Phát",
                "address": "400 Huỳnh Tấn Phát, Phú Thuận, Quận 7, Hồ Chí M",
                "phone": "02823040993",
                "lat": 10.7467194,
                "lng": 106.7288213
              },
              "id": "65849fca26f3f5ea2f6f6ed7",
              "quantity": 1,
              "totalPrice": 35000,
              "shippingFee": 0,
              "paymentType": 0,
              "createdAt": 1703190474911,
              "shipDistance": 3637.3248903369176
            },
            {
              "receiver": {
                "name": "Tin",
                "phone": "+84344234584",
                "address": "string",
                "lat": 0,
                "lng": 0
              },
              "store": {
                "name": "TCC Huỳnh Tấn Phát",
                "address": "400 Huỳnh Tấn Phát, Phú Thuận, Quận 7, Hồ Chí M",
                "phone": "02823040993",
                "lat": 10.7467194,
                "lng": 106.7288213
              },
              "id": "65848a68e39db2b6b68686b5",
              "quantity": 2,
              "totalPrice": 70000,
              "shippingFee": 0,
              "paymentType": 1,
              "createdAt": 1703185000816,
              "shipDistance": 11847401.827130063
            },
            {
              "receiver": {
                "name": "Vinh",
                "phone": "+84347070634",
                "address": "1133 Huỳnh Tấn Phát, Phú Mỹ, Quận 7, Thành phố Hồ Chí Minh, Vietnam",
                "lat": 0,
                "lng": 0
              },
              "store": {
                "name": "TCC Huỳnh Tấn Phát",
                "address": "400 Huỳnh Tấn Phát, Phú Thuận, Quận 7, Hồ Chí M",
                "phone": "02823040993",
                "lat": 10.7467194,
                "lng": 106.7288213
              },
              "id": "6570bb3f17183bfc36ee8163",
              "quantity": 2,
              "totalPrice": 104000,
              "shippingFee": 0,
              "paymentType": 1,
              "createdAt": 1701886783220,
              "shipDistance": 11847401.827130063
            }
          ].map((e) => OrderModel.fromMap(e)).toList(),
        ),
      );
    } on DioError catch (ex) {
      if (ex.error is AppMessage) {
        return ResponseModel<MapEntry<int, List<OrderModel>>>(
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
        return ResponseModel<MapEntry<int, List<OrderModel>>>(
          type: ResponseModelType.failure,
          message: AppMessage(
            type: AppMessageType.error,
            title: raw.error ?? txtErrorTitle,
            content: raw.message ?? 'Không có dữ liệu trả về!',
          ),
        );
      }
    } on Exception catch (ex) {
      return ResponseModel<MapEntry<int, List<OrderModel>>>(
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

  @override
  Future<ResponseModel<ProfileModel>> getProfile() async {
    try {
      var res = await _dio.get(ApiRouter.authInfo);
      var raw = RawSuccessModel.fromMap(res.data);
      return ResponseModel<ProfileModel>(
        type: ResponseModelType.success,
        data: ProfileModel.fromMap({
          "phone": "0347070634",
          "name": "Nguyễn Quang Vinh",
          "gender": 0,
          "numberPlate": "VN-12345-XY",
          "wallet": 1275000,
          "avatar": "https://icon-library.com/images/avatar-icon-images/avatar-icon-images-4.jpg",
          "dob": 978307200000,
          "createdAt": 978307200000
        }),
      );
    } on DioError catch (ex) {
      if (ex.error is AppMessage) {
        return ResponseModel<ProfileModel>(
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
        return ResponseModel<ProfileModel>(
          type: ResponseModelType.failure,
          message: AppMessage(
            type: AppMessageType.error,
            title: raw.error ?? txtErrorTitle,
            content: raw.message ?? 'Không có dữ liệu trả về!',
          ),
        );
      }
    } on Exception catch (ex) {
      return ResponseModel<ProfileModel>(
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

  @override
  Future<ResponseModel<bool>> updateProfile(
      {required String lastName, required String firstName}) {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<bool>> requestWithdraw({required int amount}) async {
    try {
      var res = await _dio.post(
        ApiRouter.requestWithdraw,
        data: {'amount': amount},
      );
      var raw = RawSuccessModel.fromMap(res.data);
      return ResponseModel<bool>(
        type: ResponseModelType.success,
        data: raw.data,
      );
    } on DioError catch (ex) {
      if (ex.error is AppMessage) {
        return ResponseModel<bool>(
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
        return ResponseModel<bool>(
          type: ResponseModelType.failure,
          message: AppMessage(
            type: AppMessageType.error,
            title: raw.error ?? txtErrorTitle,
            content: raw.message ?? 'Không có dữ liệu trả về!',
          ),
        );
      }
    } on Exception catch (ex) {
      return ResponseModel<bool>(
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

  @override
  Future<ResponseModel<DeliveringModel>> deliveringOrder() async {
    try {
      var res = await _dio.get(ApiRouter.deliveringOrder);
      var raw = RawSuccessModel.fromMap(res.data);

      var lst = (raw.data as List).map((e) => OrderModel.fromMap(e)).toList();

      if (lst.isEmpty) {
        return ResponseModel<DeliveringModel>(
          type: ResponseModelType.failure,
          message: AppMessage(type: AppMessageType.failure,
            title: 'Thất bại',
            content: 'Không tìm thấy đơn hàng đang giao nào',),
        );
      }

      var start = lst[0].store;
      var destination = lst[0].receiver;

      // Object for PolylinePoints
      PolylinePoints polylinePoints = PolylinePoints();

      // List of coordinates to join
      List<LatLng> polylineCoordinates = [];

      // // Map storing polylines created by connecting two points
      // Map<PolylineId, Polyline> polylines = {};

      print('objresult.points');
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        'AIzaSyDHkVmVAwW_jLPKK44JZAKUbBGQpFV6a34', // Google Maps API Key
        PointLatLng(start.lat, start.lng),
        PointLatLng(destination.lat, destination.lng),
        travelMode: TravelMode.driving,
      );
      print('objresult.points');
      print(result.points);

      if (result.points.isNotEmpty) {
        for (var point in result.points) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        }
      } // Defining an ID
      PolylineId id = const PolylineId('poly');

      // Initializing Polyline
      Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.red,
        points: polylineCoordinates,
        width: 3,
      );

      // // Adding the polyline to the map
      // polylines[id] = polyline;
      var ob = DeliveringModel(orders: lst, route: polyline);
      print(ob.orders.map((e) => e.toMap()));
      print('object1212');
      if (result.status == "OK") {
        return ResponseModel<DeliveringModel>(
          type: ResponseModelType.success,
          data: DeliveringModel(orders: lst, route: polyline),
        );
      } else {
        throw Exception(result.errorMessage);
      }
    } on DioError catch (ex) {
      if (ex.error is AppMessage) {
        return ResponseModel<DeliveringModel>(
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
        return ResponseModel<DeliveringModel>(
          type: ResponseModelType.failure,
          message: AppMessage(
            type: AppMessageType.error,
            title: raw.error ?? txtErrorTitle,
            content: raw.message ?? 'Không có dữ liệu trả về!',
          ),
        );
      }
    } on Exception catch (ex) {
      print('object1212');
      return ResponseModel<DeliveringModel>(
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

  @override
  Future<ResponseModel<bool>> updateOrderState({
    required String orderId,
    int? status,
  }) async {
    try {
      var res = await _dio.patch(
        ApiRouter.updateStatusOrder(orderId),
        data: {'status': status},
      );
      var raw = RawSuccessModel.fromMap(res.data);
      return ResponseModel<bool>(
        type: ResponseModelType.success,
        data: raw.success ?? false,
      );
    } on DioError catch (ex) {
      if (ex.error is AppMessage) {
        return ResponseModel<bool>(
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
        return ResponseModel<bool>(
          type: ResponseModelType.failure,
          message: AppMessage(
            type: AppMessageType.error,
            title: raw.error ?? txtErrorTitle,
            content: raw.message ?? 'Không có dữ liệu trả về!',
          ),
        );
      }
    } on Exception catch (ex) {
      return ResponseModel<bool>(
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
