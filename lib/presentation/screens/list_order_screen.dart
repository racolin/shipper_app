import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipper_app/business_logic/cubits/setting_cubit.dart';
import 'package:shipper_app/presentation/pages/initial_page.dart';
import 'package:shipper_app/presentation/pages/loading_page.dart';
import 'package:shipper_app/presentation/res/dimen/dimens.dart';

import '../../business_logic/states/setting_state.dart';
import '../widgets/order_widget.dart';

class ListOrderScreen extends StatefulWidget {
  const ListOrderScreen({Key? key}) : super(key: key);

  @override
  State<ListOrderScreen> createState() => _ListOrderScreenState();
}

class _ListOrderScreenState extends State<ListOrderScreen> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    _controller.addListener(() {
      if (_controller.position.atEdge) {
        if (_controller.position.pixels == 0) {
          // atTop
        } else {
          if (context.read<SettingCubit>().hasNext()) {
            context.read<SettingCubit>().loadMore();
          }
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
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
              'Các đơn đã giao',
              style: TextStyle(
                fontSize: fontLG,
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.blue,
      ),
      body: BlocBuilder<SettingCubit, SettingState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case SettingInitial:
              return const InitialPage();
            case SettingLoading:
              return const LoadingPage();
            case SettingLoaded:
              var list = (state as SettingLoaded).paging.list;
              return ListView.builder(
                controller: _controller,
                padding: const EdgeInsets.only(
                  left: spaceSM,
                  right: spaceSM,
                  bottom: dimMD,
                  top: spaceSM,
                ),
                itemCount: list.length,
                itemBuilder: (context, index) => OrderWidget(
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
