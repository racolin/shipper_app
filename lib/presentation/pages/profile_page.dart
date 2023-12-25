import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipper_app/business_logic/cubits/account_cubit.dart';
import 'package:shipper_app/presentation/pages/initial_page.dart';
import 'package:shipper_app/presentation/pages/loading_page.dart';
import 'package:shipper_app/presentation/res/strings/values.dart';
import 'package:shipper_app/presentation/widgets/app_image_widget.dart';

import '../../business_logic/cubits/setting_cubit.dart';
import '../../business_logic/states/setting_state.dart';
import '../../supports/convert.dart';
import '../res/dimen/dimens.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingCubit, SettingState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case SettingInitial:
            return const InitialPage();
          case SettingLoading:
            return const LoadingPage();
          case SettingLoaded:
            var model = (state as SettingLoaded).profile;
            return Padding(
              padding: const EdgeInsets.all(spaceSM),
              child: Column(
                children: [
                  const SizedBox(
                    height: spaceMD,
                  ),
                  AppImageWidget(
                    image: model.avatar,
                    borderRadius: BorderRadius.circular(
                      dimXL,
                    ),
                    width: dimXXL,
                    height: dimXXL,
                  ),
                  const SizedBox(
                    height: spaceMD,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Số dư: ${numberToCurrency(model.wallet, 'đ')}',
                        style: const TextStyle(
                          fontSize: fontXXL,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: spaceMD,
                  ),
                  Stack(
                    children: [
                      Container(
                        width: double.maxFinite,
                        height: 48,
                        margin: const EdgeInsets.symmetric(vertical: spaceSM),
                        padding: const EdgeInsets.all(spaceSM),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(spaceXS),
                          border: Border.all(color: Colors.black54, width: 0.5),
                        ),
                        child: Text(
                          model.name,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      Positioned(
                        top: 2,
                        left: spaceSM,
                        child: Text(
                          'Họ và tên',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 48,
                        margin: const EdgeInsets.symmetric(vertical: spaceSM),
                        padding: const EdgeInsets.all(spaceSM),
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(spaceXS),
                          border: Border.all(color: Colors.black54, width: 0.5),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: spaceXXS,
                            ),
                            const CircleAvatar(
                              backgroundImage: AssetImage(
                                'assets/images/vn.jpeg',
                              ),
                              radius: spaceXS,
                            ),
                            const SizedBox(
                              width: spaceXXS,
                            ),
                            Text(
                              '+84',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(
                              width: spaceXS,
                            ),
                            Container(
                              width: 1,
                              color: Colors.black54,
                              height: double.maxFinite,
                            ),
                            const SizedBox(
                              width: spaceXS,
                            ),
                            Expanded(
                              child: Text(
                                model.phone,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 2,
                        left: spaceSM,
                        child: Text(
                          'Số điện thoại',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 48,
                            margin: const EdgeInsets.symmetric(vertical: spaceSM),
                            padding: const EdgeInsets.only(
                              top: spaceXS,
                              bottom: spaceXS,
                              left: spaceXS,
                              right: spaceLG + 2 * spaceSM,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(spaceXS),
                              border:
                                  Border.all(color: Colors.black54, width: 0.5),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(spaceXXS),
                                  child: Container(
                                    color: Colors.blue,
                                    child: Image.asset(
                                      model.gender == 0
                                          ? 'assets/images/men.png'
                                          : 'assets/images/women.png',
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 2,
                            left: spaceSM,
                            child: Text(
                              'Giới',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    backgroundColor:
                                        Theme.of(context).scaffoldBackgroundColor,
                                  ),
                            ),
                          ),
                          Positioned(
                            top: spaceSM,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                border: Border.all(
                                  color: Colors.black54,
                                  width: 0.5,
                                ),
                                borderRadius: const BorderRadius.horizontal(
                                  right: Radius.circular(spaceXS),
                                  left: Radius.zero,
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: spaceSM,
                              ),
                              height: 48,
                              child: const Icon(
                                Icons.keyboard_double_arrow_right_outlined,
                                color: Colors.white,
                                size: fontLG,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: spaceMD),
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              width: double.maxFinite,
                              height: 48,
                              margin:
                                  const EdgeInsets.symmetric(vertical: spaceSM),
                              padding: const EdgeInsets.all(spaceSM),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(spaceXS),
                                border:
                                    Border.all(color: Colors.black54, width: 0.5),
                              ),
                              child: Text(
                                dateToString(model.dob, 'dd/MM/yyyy'),
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                            Positioned(
                              top: 2,
                              left: spaceSM,
                              child: Text(
                                'Ngày sinh',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      backgroundColor: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                    ),
                              ),
                            ),
                            Positioned(
                              top: spaceSM,
                              right: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  border: Border.all(
                                    color: Colors.black54,
                                    width: 0.5,
                                  ),
                                  borderRadius: const BorderRadius.horizontal(
                                    right: Radius.circular(spaceXS),
                                    left: Radius.zero,
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: spaceSM,
                                ),
                                height: 48,
                                child: const Icon(
                                  Icons.ads_click_outlined,
                                  color: Colors.white,
                                  size: fontLG,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 48,
                            margin: const EdgeInsets.symmetric(vertical: spaceSM),
                            padding: const EdgeInsets.all(spaceSM),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(spaceXS),
                              border:
                                  Border.all(color: Colors.black54, width: 0.5),
                            ),
                            child: Text(
                              model.numberPlate,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                          Positioned(
                            top: 2,
                            left: spaceSM,
                            child: Text(
                              'Biển số',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    backgroundColor:
                                        Theme.of(context).scaffoldBackgroundColor,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: spaceMD),
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              width: double.maxFinite,
                              height: 48,
                              margin:
                                  const EdgeInsets.symmetric(vertical: spaceSM),
                              padding: const EdgeInsets.all(spaceSM),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(spaceXS),
                                border:
                                    Border.all(color: Colors.black54, width: 0.5),
                              ),
                              child: Text(
                                dateToString(model.createdAt, 'dd/MM/yyyy'),
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                            Positioned(
                              top: 2,
                              left: spaceSM,
                              child: Text(
                                'Ngày tạo',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      backgroundColor: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                    ),
                              ),
                            ),
                            Positioned(
                              top: spaceSM,
                              right: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  border: Border.all(
                                    color: Colors.black54,
                                    width: 0.5,
                                  ),
                                  borderRadius: const BorderRadius.horizontal(
                                    right: Radius.circular(spaceXS),
                                    left: Radius.zero,
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: spaceSM,
                                ),
                                height: 48,
                                child: const Icon(
                                  Icons.ads_click_outlined,
                                  color: Colors.white,
                                  size: fontLG,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: dimXS,
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () async {
                        context.read<AccountCubit>().logout();
                      },
                      child: Text(
                        txtLogOut,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          case SettingFailure:
            return const InitialPage();
        }
        return const InitialPage();
      },
    );
  }
}
