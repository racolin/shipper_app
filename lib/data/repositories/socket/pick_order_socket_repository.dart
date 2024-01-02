import 'dart:async';

import 'package:shipper_app/data/models/error_socket_model.dart';
import 'package:shipper_app/data/models/order_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:dio/dio.dart';
import 'package:shipper_app/business_logic/repositories/pick_order_repository.dart';
import 'package:shipper_app/data/models/order_error_model.dart';
import 'package:shipper_app/data/services/api_client.dart';
import 'package:shipper_app/data/services/secure_storage.dart';

import '../../../exception/app_message.dart';
import '../../../presentation/res/strings/values.dart';
import '../../models/raw_failure_model.dart';
import '../../models/raw_success_model.dart';
import '../../models/response_model.dart';
import '../../models/token_model.dart';
import '../../services/config.dart';

class PickOrderSocketRepository extends PickOrderRepository {
  final _storage = SecureStorage();
  final _dioNoAuth = ApiClient.dioNoAuth;
  final _dioAuth = ApiClient.dioAuth;
  final _socket = IO.io(
      Environment.env().ws,
      IO.OptionBuilder().setTransports(['websocket'])
          .build());

  TokenModel? token;

  final _controllerNewOrder = StreamController<OrderModel>();
  final _controllerCancelOrder = StreamController<String>();
  final _controllerPickOrderError = StreamController<OrderErrorModel>();
  final _controllerPickOrderSuccess = StreamController<String>();
  final _controllerRemovePickedOrder = StreamController<String>();
  final _controllerError = StreamController<ErrorSocketModel>();

  PickOrderSocketRepository() {
    // Lấy access token và tiến hành xác thực socket
    _storage.getToken().then((res) {
      // print('PickOrderSocketRepository: Connected2');
      // Nếu lấy được token thì emit xác thực
      // Nếu không thì báo lỗi
      if (res.type == ResponseModelType.success) {
        // print('PickOrderSocketRepository: Connected3');
        token = res.data;

        // Khi socket kết nối thì emit authen
        _socket.onConnect((dt) {
          // print('PickOrderSocketRepository: Connected');
          _socket.emit(SocketRouter.emitAuthenticate, {
            'token': token!.accessToken,
          });
        });
      } else {
        _controllerError.sink.add(
          const ErrorSocketModel(
            name: 'Thất bại',
            message: 'Không thể xác định tài khoản này!',
          ),
        );
      }
    });

    _socket.on(SocketRouter.onUnauthorized, (data) {
      _controllerError.sink.add(
        const ErrorSocketModel(
          name: 'Thất bại',
          message: 'Hãy đợi trong giây lát và thử lại!',
        ),
      );
      _refreshToken(refreshToken: token!.refreshToken).then((res) {
        _socket.emit(SocketRouter.emitAuthenticate, {
          'token': token!.accessToken,
        });
      });
    });

    // setup các stream
    _socket.on(SocketRouter.onNewOrder, (data) {
      // print('onNewOrder');
      // print(data);
      try {
        var res = OrderModel.fromMap(data);
        _controllerNewOrder.sink.add(res);
      } catch (ex) {
        _controllerError.sink.add(
          const ErrorSocketModel(
            name: 'Thất bại',
            message: 'Dữ liệu trả về không chính xác',
          ),
        );
      }
    });

    _socket.on(SocketRouter.onCancelOrder, (data) {
      var orderId = data['orderId'];
      if (orderId is String) {
        _controllerCancelOrder.sink.add(orderId);
      } else {
        _controllerError.sink.add(
          const ErrorSocketModel(
            name: 'Thất bại',
            message: 'Dữ liệu trả về không chính xác',
          ),
        );
      }
    });

    _socket.on(SocketRouter.onPickOrderError, (data) {
      // print('onPickOrderError');
      // print(data);
      try {
        var res = OrderErrorModel.fromMap(data);
        _controllerPickOrderError.sink.add(res);
      } catch (ex) {
        _controllerError.sink.add(
          const ErrorSocketModel(
            name: 'Thất bại',
            message: 'Dữ liệu trả về không chính xác',
          ),
        );
      }
    });

    _socket.on(SocketRouter.onPickOrderSuccess, (data) {
      // print('onPickOrderSuccess');
      // print(data);
      var orderId = data['orderId'];
      if (orderId is String) {
        _controllerPickOrderSuccess.sink.add(orderId);
      } else {
        _controllerError.sink.add(
          const ErrorSocketModel(
            name: 'Thất bại',
            message: 'Dữ liệu trả về không chính xác',
          ),
        );
      }
    });

    _socket.on(SocketRouter.onRemovePickedOrder, (data) {
      var orderId = data['orderId'];
      if (orderId is String) {
        _controllerRemovePickedOrder.sink.add(orderId);
      } else {
        _controllerError.sink.add(
          const ErrorSocketModel(
            name: 'Thất bại',
            message: 'Dữ liệu trả về không chính xác',
          ),
        );
      }
    });

    _socket.on(SocketRouter.onError, (data) {
      try {
        var res = ErrorSocketModel.fromMap(data);
        _controllerError.sink.add(res);
      } catch (ex) {
        _controllerError.sink.add(
          const ErrorSocketModel(
            name: 'Thất bại',
            message: 'Dữ liệu trả về không chính xác',
          ),
        );
      }
    });
  }

  @override
  void pickOrder({required String orderId}) {
    _socket.emit(SocketRouter.emitPickOrder, {
      'orderId': orderId,
    });
  }

  @override
  Stream<OrderModel> get newOrder => _controllerNewOrder.stream;

  @override
  Stream<String> get cancelOrder => _controllerCancelOrder.stream;

  @override
  Stream<OrderErrorModel> get pickOrderError =>
      _controllerPickOrderError.stream;

  @override
  Stream<String> get pickOrderSuccess => _controllerPickOrderSuccess.stream;

  @override
  Stream<String> get removePickedOrder => _controllerRemovePickedOrder.stream;

  @override
  Stream<ErrorSocketModel> get error => _controllerError.stream;

  Future<ResponseModel<bool>> _refreshToken(
      {required String refreshToken}) async {
    try {
      var res = await _dioNoAuth.post(
        ApiRouter.authRefresh,
        options: Options(
          headers: {'Authorization': 'Bearer $refreshToken'},
        ),
      );
      var raw = RawSuccessModel.fromMap(res.data);
      var newToken = TokenModel.fromMap(raw.data);
      token = newToken;
      await _storage.persistToken(newToken);
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

  @override
  void close() async {
    _socket.destroy();
    _controllerNewOrder.close();
    _controllerCancelOrder.close();
    _controllerPickOrderError.close();
    _controllerPickOrderSuccess.close();
    _controllerRemovePickedOrder.close();
    _controllerError.close();
  }

  @override
  Future<ResponseModel<List<OrderModel>>> getCurrentOrder({
    required double lat,
    required double lng,
  }) async {
    try {
      var res = await _dioAuth.get(
        ApiRouter.currentOrder,
        queryParameters: {
          'lat': lat,
          'lng': lng,
        },
      );
      var raw = RawSuccessModel.fromMap(res.data);
      return ResponseModel<List<OrderModel>>(
        type: ResponseModelType.success,
        data: (raw.data as List).map((e) => OrderModel.fromMap(e)).toList(),
      );
    } on DioError catch (ex) {
      if (ex.error is AppMessage) {
        return ResponseModel<List<OrderModel>>(
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
        return ResponseModel<List<OrderModel>>(
          type: ResponseModelType.failure,
          message: AppMessage(
            type: AppMessageType.error,
            title: raw.error ?? txtErrorTitle,
            content: raw.message ?? 'Không có dữ liệu trả về!',
          ),
        );
      }
    } on Exception catch (ex) {
      return ResponseModel<List<OrderModel>>(
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
