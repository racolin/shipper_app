import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shipper_app/data/models/order_model.dart';
import 'package:shipper_app/exception/app_message.dart';

import '../../data/models/paging_model.dart';
import '../../data/models/profile_model.dart';

@immutable
abstract class SettingState {}

class SettingInitial extends SettingState {}

class SettingLoading extends SettingState {}

class SettingLoaded extends SettingState {
  final ProfileModel profile;
  final PagingModel<OrderModel> paging;

  SettingLoaded({
    required this.profile,
    required this.paging,
  });

  SettingLoaded copyWith({
    ProfileModel? profile,
    PagingModel<OrderModel>? paging,
  }) {
    return SettingLoaded(
      profile: profile ?? this.profile,
      paging: paging ?? this.paging,
    );
  }
}

class SettingFailure extends SettingState {
  final AppMessage message;
  SettingFailure({required this.message});
}
