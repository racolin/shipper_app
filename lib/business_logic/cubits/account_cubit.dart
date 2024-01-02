import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/response_model.dart';
import '../../business_logic/states/account_state.dart';
import '../repositories/account_repository.dart';

class AccountCubit extends Cubit<AccountState> {
  final AccountRepository _repository;

  AccountCubit({required AccountRepository repository})
      : _repository = repository,
        super(AccountInitial()) {
    emit(AccountLoading());
    _repository.isLogin().then((res) {
      if (res.type == ResponseModelType.success) {
        // print(res.data);
        // print('res.data111');
        emit(AccountLoaded(
          isLogin: res.data,
        ));
      } else {
        emit(AccountFailure(message: res.message));
      }
    });
  }

  void logout() async {
    var res = await _repository.logout();
    if (res.type == ResponseModelType.success) {
      // print('state--11--11');
      // print((state as AccountLoaded).isLogin);
      emit(AccountLoaded(
        isLogin: false,
      ));
    } else {
      emit(AccountFailure(message: res.message));
    }
  }

  void login() {
    emit(AccountLoaded(
      isLogin: true,
    ));
  }

  // base method: return response model, use to avoid repeat code.

  // action method, change state and return AppMessage?, null when success

}