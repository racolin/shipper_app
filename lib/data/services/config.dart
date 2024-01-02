import 'dart:io';

class Environment {
  final String _base;
  final String _url;
  final String _ws;

  Environment._({
    required String base,
    required String url,
    required String ws,
  })  : _base = base,
        _url = url,
        _ws = ws;

  String get api => _url + _base;

  String get ws => _ws;

  static Environment? _devInstance;

  factory Environment.env() {
    return _dev;
  }

  static Environment get _dev {
    _devInstance ??= Environment._(
        base: 'api/v2/',
        url: Platform.isAndroid
            ? 'http://192.168.2.8/'
            : 'http://127.0.0.1/',
        ws: Platform.isAndroid
            ? 'http://192.168.2.8/shipper'
            : 'http://localhost/shipper');
    return _devInstance!;
  }
}

// Config environment
class AppConfig {
  factory AppConfig({Environment? env}) {
    if (env != null) {
      appConfig.env = env;
    }
    return appConfig;
  }

  AppConfig._private();

  static final AppConfig appConfig = AppConfig._private();
  Environment env = Environment.env();
}

class ApiRouter {
  // Google Places API Key
  static const String googlePlacesApiKey =
      'AIzaSyAl08v6TizYX1xbG21xGCaRmtI6yT8hxwM';

  // Auth
  static const String authInfo = '/shipper/auth/info';
  static const String authLogin = '/shipper/auth/login';
  static const String authSmsVerify = '/shipper/auth/sms-verify';
  static const String authRefresh = '/shipper/auth/refresh';
  static const String withdrawHistory = '/shipper/auth/withdraw-history';
  static const String requestWithdraw = '/shipper/auth/request-withdraw';

  // Order
  static String updateStatusOrder(String orderId) => '/shipper/order/$orderId';
  static const String deliveringOrder = '/shipper/order/delivering';

  static String detailOrder(String orderId) => '/shipper/order/$orderId/detail';
  static const String currentOrder = '/shipper/order/current';
  static const String listOrder = '/shipper/order/list';
  static String evidence(String orderId) => '/shipper/order/$orderId/evidence';
}

class SocketRouter {
  static const String onError = 'error';
  static const String emitAuthenticate = 'authenticate';
  static const String emitCheckAuthenticated = 'check_authenticated';
  static const String onAuthenticated = 'authenticated';
  static const String onUnauthorized = 'unauthorized';
  static const String onNewOrder = 'shipper:new_order';
  static const String onCancelOrder = 'shipper:cancelled_order';
  static const String emitPickOrder = 'shipper:pick_order';
  static const String onPickOrderError = 'shipper:pick_order_error';
  static const String onPickOrderSuccess = 'shipper:pick_order_success';
  static const String onRemovePickedOrder = 'shipper:remove_picked_order';
}
