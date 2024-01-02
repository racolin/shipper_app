import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipper_app/presentation/pages/initial_page.dart';
import 'package:shipper_app/presentation/pages/loading_page.dart';
import 'package:shipper_app/supports/convert.dart';

import '../../business_logic/cubits/order_detail_cubit.dart';
import '../../business_logic/states/order_detail_state.dart';
import '../res/dimen/dimens.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          splashRadius: spaceXL,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_outlined),
        ),
        title: Text(
          'Chi tiết đơn',
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      body: BlocBuilder<OrderDetailCubit, OrderDetailState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case OrderDetailInitial:
              return const InitialPage();
            case OrderDetailLoading:
              return const LoadingPage();
            case OrderDetailLoaded:
              var model = (state as OrderDetailLoaded).model;
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: spaceXS),
                    _getRowItemWidget('Mã đơn hàng:', model.code),
                    const Divider(height: 1, color: Colors.grey),
                    _getColumnItemExpandWidget(
                      'Danh sách sảnn phẩm',
                      model.items.map((e) => 'x${e.amount} ${e.name}').toList(),
                    ),
                    const Divider(height: 1, color: Colors.grey),
                    _getRowItemWidget(
                      'Tổng giá:',
                      numberToCurrency(model.totalPrice, 'đ'),
                    ),
                    const Divider(height: 1, color: Colors.grey),
                    _getRowItemWidget(
                      'Phí ship:',
                      '${numberToCurrency(model.shipperIncome, 'đ')}(${meterToString(model.shipDistance.toInt())})',
                    ),
                    const Divider(height: 1, color: Colors.grey),
                    _getRowItemExpandWidget('Người nhận:', [
                      model.receiver.name,
                      model.receiver.phone,
                      model.receiver.address,
                    ]),
                    const Divider(height: 1, color: Colors.grey),
                    _getRowItemExpandWidget('Cửa hàng:', [
                      model.store.name,
                      model.store.phone,
                      model.store.address,
                    ]),
                    if (model.review != null) ...[
                    const Divider(height: 1, color: Colors.grey),
                    _getRateItemWidget('Đánh giá:', model.review!.rate),
                    const Divider(height: 1, color: Colors.grey),
                    _getRowItemWidget('Nhận xét', model.review!.description),
                    ],
                  ],
                ),
              );
            case OrderDetailFailure:
              return const InitialPage();
          }
          return const InitialPage();
        },
      ),
    );
  }

  Widget _getRowItemWidget(String title, String value) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: spaceXS, vertical: spaceMD),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              title,
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.black54),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getRateItemWidget(String title, int rate) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: spaceXS, vertical: spaceMD),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              title,
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.black54),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                for (var i = 1; i < 6; i++)
                  Icon(
                    Icons.star_rounded,
                    color: i <= rate ? Colors.orange : Colors.grey,
                    size: 32,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getRowItemExpandWidget(String title, List<String> values) {
    if (values.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.all(spaceXS),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: ExpansionTile(
                shape: const Border(),
                tilePadding: EdgeInsets.zero,
                childrenPadding: EdgeInsets.zero,
                expandedAlignment: Alignment.topLeft,
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                title: Text(
                  values[0],
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                children: [
                  for (var i = 1; i < values.length; i++)
                    Padding(
                      padding: const EdgeInsets.only(bottom: spaceMD),
                      child: Text(
                        values[i],
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _getColumnItemExpandWidget(String title, List<String> values) {
    if (values.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.all(spaceXS),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            ExpansionTile(
              shape: const Border(),
              tilePadding: EdgeInsets.zero,
              childrenPadding: EdgeInsets.zero,
              expandedAlignment: Alignment.topLeft,
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              title: Text(
                values[0],
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              children: [
                for (var i = 1; i < values.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: spaceMD),
                    child: Text(
                      values[i],
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: fontMD,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
