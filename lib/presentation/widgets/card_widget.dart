import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shipper_app/data/models/profile_model.dart';
import 'package:shipper_app/supports/convert.dart';
import '../../presentation/res/dimen/dimens.dart';

import 'app_image_widget.dart';

class CardWidget extends StatelessWidget {
  final ProfileModel profile;
  final bool isDetail;
  final double barHeight = 76;
  final double barCoverHeight = 56;
  final double barWidth = 300;
  final double cardHeight = 160;
  final double top = 172;

  const CardWidget({
    Key? key,
    required this.profile,
    this.isDetail = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(spaceXS),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(spaceXS),
            image: const DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                'assets/images/shipper_card.png',
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(spaceXS),
                  ),
                  color: Colors.black.withOpacity(0.2),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppImageWidget(
                      image: profile.avatar,
                      width: dimXL,
                      height: dimXL,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(spaceXS),
                        bottomRight: Radius.circular(spaceXS),
                      ),
                    ),
                    const SizedBox(width: spaceSM),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profile.name,
                            style: const TextStyle(
                              fontSize: fontXL,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: spaceXS),
                          Row(
                            children: [
                              const Text(
                                'Biển số: ',
                                style: TextStyle(
                                  fontSize: fontXL,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                profile.numberPlate,
                                style: const TextStyle(
                                  fontSize: fontXL,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: spaceSM),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Số dư: ',
                    style: TextStyle(
                      fontSize: fontXL,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    numberToCurrency(profile.wallet, 'đ'),
                    style: const TextStyle(
                      fontSize: fontXXL,
                      fontWeight: FontWeight.w700,
                      color: Colors.white
                    ),
                  ),
                ],
              ),
              const SizedBox(height: spaceSM),
            ],
          ),
        ),
      ),
    );
  }
}
