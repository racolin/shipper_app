import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shipper_app/data/models/response_model.dart';
import '../repositories/withdraw_history_repository.dart';
import '../states/withdraw_history_state.dart';

class WithdrawHistoryCubit extends Cubit<WithdrawHistoryState> {
  final WithdrawHistoryRepository _repository;

  WithdrawHistoryCubit({required WithdrawHistoryRepository repository})
      : _repository = repository,
        super(WithdrawHistoryInitial()) {
    emit(WithdrawHistoryLoading());
    _repository.withdrawHistory().then((res) {
      if (res.type == ResponseModelType.success) {
        emit(WithdrawHistoryLoaded(
          list: res.data,
        ));
      } else {
        emit(WithdrawHistoryFailure(message: res.message));
      }
    });
  }
}
