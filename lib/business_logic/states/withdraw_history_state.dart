import 'package:flutter/foundation.dart';
import 'package:shipper_app/data/models/order_model.dart';
import 'package:shipper_app/data/models/with_draw_model.dart';
import 'package:shipper_app/exception/app_message.dart';

import '../../data/models/paging_model.dart';
import '../../data/models/profile_model.dart';

@immutable
abstract class WithdrawHistoryState {}

class WithdrawHistoryInitial extends WithdrawHistoryState {}

class WithdrawHistoryLoading extends WithdrawHistoryState {}

class WithdrawHistoryLoaded extends WithdrawHistoryState {
  final List<WithdrawModel> list;

  WithdrawHistoryLoaded({
    required this.list,
  });

  WithdrawHistoryLoaded copyWith({
    List<WithdrawModel>? list,
  }) {
    return WithdrawHistoryLoaded(
      list: list ?? this.list,
    );
  }
}

class WithdrawHistoryFailure extends WithdrawHistoryState {
  final AppMessage message;
  WithdrawHistoryFailure({required this.message});
}
