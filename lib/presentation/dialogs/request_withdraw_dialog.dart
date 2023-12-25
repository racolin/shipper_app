import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shipper_app/presentation/res/strings/values.dart';

import '../../presentation/res/dimen/dimens.dart';

class RequestWithdrawDialog extends StatefulWidget {
  const RequestWithdrawDialog({Key? key}) : super(key: key);

  @override
  State<RequestWithdrawDialog> createState() => _RequestWithdrawDialogState();
}

class _RequestWithdrawDialogState extends State<RequestWithdrawDialog> {
  int? amount;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text(
        'Yêu cầu rút tiền',
        style: TextStyle(
          color: Colors.black87,
          fontSize: fontLG,
          fontWeight: FontWeight.w600,
        ),
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: spaceSM),
          Text(
            'Số tiền (đ)',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(height: spaceXS),
          Container(
            width: double.maxFinite,
            height: 48,
            padding: const EdgeInsets.all(spaceSM),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(spaceXS),
              border: Border.all(color: Colors.black54, width: 0.5),
            ),
            child: Material(
              color: Colors.transparent,
              child: TextField(
                keyboardType: TextInputType.phone,
                onChanged: (value) {
                  amount = int.tryParse(value);
                },
                style: Theme.of(context).textTheme.bodyLarge,
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                  // filled: true,
                ),
              ),
            ),
          ),
        ],
      ),
      actions: [
        CupertinoDialogAction(
          child: const Text(txtCancel),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        CupertinoDialogAction(
          child: const Text(txtConfirm),
          onPressed: () {
            Navigator.pop(context, amount);
          },
        ),
      ],
    );
  }
}
