import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'order_model.dart';

class DeliveringModel {
  final List<OrderModel> orders;
  final Polyline route;

  const DeliveringModel({
    required this.orders,
    required this.route,
  });
}