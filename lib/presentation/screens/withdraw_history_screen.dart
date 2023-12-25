import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipper_app/business_logic/cubits/setting_cubit.dart';
import 'package:shipper_app/presentation/pages/home_body.dart';
import 'package:shipper_app/presentation/pages/initial_page.dart';
import 'package:shipper_app/presentation/pages/loading_page.dart';
import 'package:shipper_app/presentation/pages/profile_page.dart';
import 'package:shipper_app/presentation/res/dimen/dimens.dart';

import '../../business_logic/cubits/withdraw_history_cubit.dart';
import '../../business_logic/states/setting_state.dart';
import '../../business_logic/states/withdraw_history_state.dart';
import '../../supports/convert.dart';
import '../widgets/order_widget.dart';

class WithdrawHistoryScreen extends StatefulWidget {
  const WithdrawHistoryScreen({Key? key}) : super(key: key);

  @override
  State<WithdrawHistoryScreen> createState() => _WithdrawHistoryScreenState();
}

class _WithdrawHistoryScreenState extends State<WithdrawHistoryScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          splashRadius: spaceXL,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.white,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(spaceXXS),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(42 / 2),
              ),
              width: 42,
              height: 42,
              child: Image.asset(
                'assets/images/logo_shipper.png',
              ),
            ),
            const SizedBox(width: spaceSM),
            const Text(
              'Lịch sử rút tiền',
              style: TextStyle(
                fontSize: fontLG,
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.blue,
      ),
      body: BlocBuilder<WithdrawHistoryCubit, WithdrawHistoryState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case WithdrawHistoryInitial:
              return const InitialPage();
            case WithdrawHistoryLoading:
              return const LoadingPage();
            case WithdrawHistoryLoaded:
              var list = (state as WithdrawHistoryLoaded).list;
              return ListView.builder(
                padding: const EdgeInsets.only(
                  left: spaceSM,
                  right: spaceSM,
                  bottom: dimMD,
                  top: spaceSM,
                ),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  var model = list[index];
                  return Card(
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: spaceSM,
                        horizontal: spaceMD,
                      ),
                      child: Row(
                        children: [
                          model.status == 'approved'
                              ? const Icon(
                                  Icons.check_circle_rounded,
                                  color: Colors.green,
                                  size: 36,
                                )
                              : model.status == 'declined'
                                  ? const Icon(
                                      Icons.cancel_rounded,
                                      color: Colors.red,
                                      size: 36,
                                    )
                                  : const Icon(
                                      Icons.pending_rounded,
                                      color: Colors.orange,
                                      size: 36,
                                    ),
                          const SizedBox(width: spaceMD),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '#${model.id}',
                                  style: const TextStyle(
                                    fontSize: fontLG,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: spaceXXS),
                                Text(
                                  'Số tiền: ${numberToCurrency(model.amount, 'đ')}',
                                  style: const TextStyle(
                                    fontSize: fontLG,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: spaceXXS),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    dateToString(
                                      model.createAt,
                                      'HH:mm dd/MM/yyyy',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            case WithdrawHistoryFailure:
              return const InitialPage();
          }
          return const InitialPage();
        },
      ),
    );
  }
}
