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
          raw.data['maxCount'] ?? 0,
          (raw.data['orders'] as List)
              .map((e) => OrderModel.fromMap(e))
              .toList(),
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
        data: ProfileModel.fromMap(raw.data),
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

      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        'AIzaSyCY1GxZRKukIY8KO2_FMorMmtOxAjzv1tY', // Google Maps API Key
        PointLatLng(start.lat, start.lng),
        PointLatLng(destination.lat, destination.lng),
        travelMode: TravelMode.driving,
      );

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
