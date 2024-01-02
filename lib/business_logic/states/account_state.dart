import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:shipper_app/exception/app_message.dart';

@immutable
abstract class AccountState extends Equatable {}

class AccountInitial extends AccountState {
  @override
  List<Object?> get props => [];
}

class AccountLoading extends AccountState {
  @override
  List<Object?> get props => [];
}

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

  @override
  List<Object?> get props => [isLogin];
}

class AccountFailure extends AccountState {
  final AppMessage message;

  AccountFailure({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
