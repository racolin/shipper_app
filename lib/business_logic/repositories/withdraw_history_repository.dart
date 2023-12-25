import '../../data/models/response_model.dart';
import '../../data/models/with_draw_model.dart';

abstract class WithdrawHistoryRepository {
  Future<ResponseModel<List<WithdrawModel>>> withdrawHistory();
}
