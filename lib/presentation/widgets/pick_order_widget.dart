import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipper_app/business_logic/cubits/pick_order_cubit.dart';
import 'package:shipper_app/data/models/order_model.dart';
import 'package:shipper_app/presentation/app_router.dart';

import '../../supports/convert.dart';
import '../res/dimen/dimens.dart';

class PickOrderWidget extends StatelessWidget {
  final OrderModel order;

  const PickOrderWidget({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: spaceXXS,
        horizontal: 0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          spaceXS,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(spaceSM),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Column(
                  children: [
                    Image.asset(
                      order.paymentType == 0
                          ? 'assets/images/cash.png'
                          : 'assets/images/momo.png',
                      width: dimXS,
                      height: dimXS,
                    ),
                    const SizedBox(height: spaceXS),
                    Text(
                      numberToCurrency(
                        order.paymentType == 0
                            ? order.totalPrice
                            : order.shippingFee,
                        'đ',
                      ),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: spaceXS),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 1),
                            child: Icon(
                              Icons.account_circle_rounded,
                              color: Colors.grey,
                              size: fontXL,
                            ),
                          ),
                          const SizedBox(width: spaceXXS),
                          Expanded(
                            child: Text(
                              'Địa chỉ: ${order.receiver.address}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, height: 1.4),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: spaceXS),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 1),
                            child: Icon(
                              Icons.store_rounded,
                              color: Colors.grey,
                              size: fontXL,
                            ),
                          ),
                          const SizedBox(width: spaceXXS),
                          Expanded(
                            child: Text(
                              'Địa chỉ: ${order.store.address}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: spaceXS),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.social_distance_rounded,
                            color: Colors.grey,
                            size: fontXL,
                          ),
                          const SizedBox(width: spaceXXS),
                          Expanded(
                            child: Text(
                              'Khoảng cách: ${meterToString(order.shipDistance.toInt())}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                context.read<PickOrderCubit>().pickOrder(
                      order.id,
                    );
              },
              child: const Text('Chọn'),
            ),
          ],
        ),
      ),
    );
  }
}
