import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipper_app/business_logic/cubits/account_cubit.dart';
import 'package:shipper_app/presentation/pages/alert_page.dart';
import 'package:shipper_app/presentation/res/dimen/dimens.dart';

class AuthFailureScreen extends StatefulWidget {
  const AuthFailureScreen({Key? key}) : super(key: key);

  @override
  State<AuthFailureScreen> createState() => _AuthFailureScreenState();
}

class _AuthFailureScreenState extends State<AuthFailureScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: AlertPage(
        icon: const Icon(
          Icons.sms_failed_rounded,
          size: dimMD,
        ),
        type: AlertType.error,
        description: 'Có lỗi xảy ra trong quá trình đăng nhập. Hãy thử lại!',
        action: () {
          context.read<AccountCubit>().logout();
        },
        actionName: 'Đăng nhập',
      ),
    );
  }
}
