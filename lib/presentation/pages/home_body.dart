import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipper_app/business_logic/cubits/setting_cubit.dart';
import 'package:shipper_app/business_logic/cubits/withdraw_history_cubit.dart';
import 'package:shipper_app/presentation/app_router.dart';
import 'package:shipper_app/presentation/dialogs/request_withdraw_dialog.dart';
import 'package:shipper_app/presentation/widgets/app_image_widget.dart';
import 'package:shipper_app/presentation/widgets/card_widget.dart';
import 'package:shipper_app/supports/convert.dart';
import '../../business_logic/states/setting_state.dart';
import '../dialogs/app_dialog.dart';
import '../res/dimen/dimens.dart';
import '../res/strings/values.dart';
import '../widgets/order_widget.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  double oldPixel = 0;
  double gap = 2;
  double direction = -1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {},
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(
          top: spaceXS,
          right: spaceXS,
          left: spaceXS,
        ),
        physics: const ClampingScrollPhysics(),
        child: BlocBuilder<SettingCubit, SettingState>(
          builder: (context, state) {
            switch (state.runtimeType) {
              case SettingInitial:
                return Container();
              case SettingLoading:
                return Container();
              case SettingLoaded:
                var st = state as SettingLoaded;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CardWidget(
                      profile: st.profile,
                    ),
                    const SizedBox(height: spaceXS),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.orangeAccent),
                            ),
                            icon: const Icon(
                              Icons.history,
                              color: Colors.white,
                              size: fontXXL,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, AppRouter.withdrawHistory);
                            },
                            label: const Text(
                              'Lịch sử rút',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fontLG,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: spaceSM),
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue),
                            ),
                            icon: const Icon(
                              Icons.credit_card,
                              color: Colors.white,
                              size: fontXXL,
                            ),
                            onPressed: () async {
                              var amount = await showCupertinoDialog<int?>(
                                context: context,
                                builder: (context) {
                                  return const RequestWithdrawDialog();
                                },
                              );
                              if (mounted && amount != null) {
                                var message = await context
                                    .read<SettingCubit>()
                                    .requestWithdraw(
                                      amount,
                                    );
                                if (mounted) {
                                  if (message == null) {
                                    ScaffoldMessenger.of(context)
                                        .clearSnackBars();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Yêu cầu của bạn đã được gửi thành công!',
                                        ),
                                      ),
                                    );
                                  } else {
                                    showCupertinoDialog(
                                      context: context,
                                      builder: (context) {
                                        return AppDialog(
                                          message: message,
                                          actions: [
                                            CupertinoDialogAction(
                                              child: const Text(txtConfirm),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                }
                              }
                            },
                            label: const Text(
                              'Rút tiền',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fontLG,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Đã giao gần đây',
                          style: TextStyle(
                            fontSize: fontXL,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, AppRouter.listOrder);
                          },
                          child: const Text(
                            'Xem tất cả',
                            style: TextStyle(
                                fontSize: fontLG, color: Colors.orange),
                          ),
                        ),
                      ],
                    ),
                    for (var order in st.paging.list) OrderWidget(order: order),
                    const SizedBox(height: dimMD),
                  ],
                );
              case SettingFailure:
                return Container();
            }
            return Container();
          },
        ),
      ),
    );
  }
}
