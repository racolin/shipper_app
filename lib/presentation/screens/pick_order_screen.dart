import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipper_app/business_logic/cubits/pick_order_cubit.dart';
import 'package:shipper_app/business_logic/cubits/setting_cubit.dart';
import 'package:shipper_app/business_logic/states/pick_order_state.dart';
import 'package:shipper_app/presentation/app_router.dart';
import 'package:shipper_app/presentation/pages/home_body.dart';
import 'package:shipper_app/presentation/pages/initial_page.dart';
import 'package:shipper_app/presentation/pages/loading_page.dart';
import 'package:shipper_app/presentation/pages/profile_page.dart';
import 'package:shipper_app/presentation/res/dimen/dimens.dart';
import 'package:shipper_app/presentation/widgets/pick_order_widget.dart';

import '../../business_logic/states/setting_state.dart';
import '../../supports/convert.dart';
import '../widgets/order_widget.dart';

class PickOrderScreen extends StatefulWidget {
  const PickOrderScreen({Key? key}) : super(key: key);

  @override
  State<PickOrderScreen> createState() => _PickOrderScreenState();
}

class _PickOrderScreenState extends State<PickOrderScreen> {
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
              'Danh sách đơn đang có',
              style: TextStyle(
                fontSize: fontLG,
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.blue,
      ),
      body: BlocConsumer<PickOrderCubit, PickOrderState>(
        listener: (context, state) {
          // print('state.runtimeType');
          // print(state is PickOrderSuccess);
          if (state is PickOrderSuccess) {
            Navigator.pop(context, true);
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case PickOrderInitial:
              return const InitialPage();
            case PickOrderLoading:
              return const LoadingPage();
            case PickOrderLoaded:
              var list = (state as PickOrderLoaded).orders;
              if (list.isEmpty) {
                return Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  alignment: Alignment.center,
                  child: const Text(
                    'Không có đơn hàng nào!',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                    ),
                  ),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.only(
                  left: spaceSM,
                  right: spaceSM,
                  bottom: dimMD,
                  top: spaceSM,
                ),
                itemCount: list.length,
                itemBuilder: (context, index) => PickOrderWidget(
                  order: list[index],
                ),
              );
            case SettingFailure:
              return const InitialPage();
          }
          return const InitialPage();
        },
      ),
    );
  }
}
