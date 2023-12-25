import 'package:flutter/foundation.dart';
import 'package:shipper_app/exception/app_message.dart';

@immutable
abstract class AccountState {}

class AccountInitial extends AccountState {}

class AccountLoading extends AccountState {}

class AccountLoaded extends AccountState {
  final bool isLogin;

  AccountLoaded({
    required this.isLogin,
  });

  AccountLoaded copyWith({
    bool? isLogin,
  }) {
    return AccountLoaded(
      isLogin: isLogin ?? this.isLogin,
    );
  }
}

class AccountFailure extends AccountState {
  final AppMessage message;

  AccountFailure({
    required this.message,
  });
}
