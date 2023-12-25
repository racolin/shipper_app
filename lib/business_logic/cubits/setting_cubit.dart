import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipper_app/data/models/delivering_model.dart';
import 'package:shipper_app/data/models/order_model.dart';
import 'package:shipper_app/data/models/profile_model.dart';

import '../../data/models/paging_model.dart';
import '../../business_logic/states/setting_state.dart';
import 'package:shipper_app/data/models/response_model.dart';
import '../../exception/app_message.dart';
import '../../presentation/res/strings/values.dart';
import '../repositories/setting_repository.dart';

class SettingCubit extends Cubit<SettingState> {
  final SettingRepository _repository;

  SettingCubit({required SettingRepository repository})
      : _repository = repository,
        super(SettingInitial()) {
    emit(SettingLoading());
    reloadProfile();
  }

  void reloadProfile() async {

    _repository.getProfile().then((res) {
      if (res.type == ResponseModelType.success) {
        _repository
            .getListOrder(
          page: 1,
          limit: 10,
          time: 3,
        )
            .then((resMap) {
          if (resMap.type == ResponseModelType.success) {
            var mapEntry = resMap.data;
            emit(SettingLoaded(
              profile: res.data,
              paging: PagingModel<OrderModel>(
                limit: 10,
                list: mapEntry.value,
                maxCount: mapEntry.key,
                page: 2,
              ),
            ));
          } else {
            emit(SettingLoaded(
              profile: res.data,
              paging: PagingModel<OrderModel>(
                limit: 10,
                list: [],
                maxCount: 0,
                page: 2,
              ),
            ));
          }
        });
      } else {
        emit(SettingFailure(message: res.message));
      }
    });
  }

  bool hasNext() {
    if (state is SettingLoaded) {
      var state = this.state as SettingLoaded;
      return state.paging.hasNext();
    }
    return false;
  }

  Future<AppMessage?> requestWithdraw(int amount) async {
    var res = await _repository.requestWithdraw(amount: amount);

    if (res.type == ResponseModelType.success) {
      return null;
    } else {
      return res.message;
    }
  }

  Future<AppMessage?> loadMore() async {
    if (this.state is! SettingLoaded) {
      return AppMessage(
        type: AppMessageType.failure,
        title: txtFailureTitle,
        content: txtToFast,
      );
    }
    var state = this.state as SettingLoaded;
    if (state.paging.hasNext()) {
      var res = await _repository.getListOrder(
        page: state.paging.page,
        limit: state.paging.limit,
      );
      var mapEntry = res.data;
      if (res.type == ResponseModelType.success) {
        state.paging.next(mapEntry.value, mapEntry.key);
        emit(state.copyWith(paging: state.paging.copyWith()));
        return null;
      } else {
        emit(SettingFailure(message: res.message));
      }
    }
    return null;
  }

  Future<bool> updateOrderStatus(String orderId) async {
    var res = await _repository.updateOrderState(
      orderId: orderId,
      status: 2,
    );
    if (res.type == ResponseModelType.success) {
      reloadProfile();
      return res.data;
    } else {
      return false;
    }
  }

  Future<DeliveringModel?> checkDelivering() async {
    var res = await _repository.deliveringOrder();
    if (res.type == ResponseModelType.success) {
      return res.data;
    } else {
      return null;
    }
  }

  // base method: return response model, use to avoid repeat code.

  // action method, change state and return AppMessage?, null when success

  // get data method: return model if state is loaded, else return null

  ProfileModel? get profile {
    if (state is SettingLoaded) {
      return (state as SettingLoaded).profile;
    }
    return null;
  }
}
