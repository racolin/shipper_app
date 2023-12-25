import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shipper_app/supports/extension.dart';

import '../../presentation/res/dimen/dimens.dart';
import '../../presentation/res/strings/values.dart';
import '../../supports/convert.dart';
import '../clippers/vertical_ticket_clipper.dart';

class VoucherBottomSheet extends StatelessWidget {
  final bool notUsed;

  const VoucherBottomSheet({
    Key? key,
    this.notUsed = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 1,
      minChildSize: 1,
      maxChildSize: 1,
      builder: (context, scrollController) {
        return Container(
          height: double.maxFinite,
          margin: const EdgeInsets.only(top: dimMD),
          padding: const EdgeInsets.all(spaceSM),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(spaceLG),
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(spaceLG),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipPath(
                        clipper: VerticalTicketClipper(numberOfSmall: 28),
                        child: Container(
                          height: spaceXS,
                          width: double.maxFinite,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                      ),
                      const SizedBox(height: spaceLG),
                      const SizedBox(height: spaceMD),
                      if (notUsed)
                        ElevatedButton(
                          onPressed: () async {
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(spaceMD),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all(
                              Colors.black,
                            ),
                          ),
                          child: const Text(
                            txtOrderStarted,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      _getExpire(),
                      const SizedBox(
                        height: dimMD,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.black,
                    size: fontXL,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _getQRCode(BuildContext context, String code) {
    return Column(
      children: [
        SvgPicture.string(
          code.qrCode(200, 200),
        ),
        const SizedBox(
          height: spaceMD,
        ),
        Text(
          code.toUpperCase(),
          style: const TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w700,
            fontSize: fontMD,
          ),
        ),
        const SizedBox(
          height: spaceXXS,
        ),
        TextButton.icon(
          onPressed: () {
            Clipboard.setData(ClipboardData(text: code));
            Navigator.pop(context);
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(txtCopyCode),
              ),
            );
          },
          icon: const Icon(
            Icons.copy,
            color: Colors.orange,
            size: fontLG,
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              Colors.green.withAlpha(50),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(spaceMD),
              ),
            ),
          ),
          label: const Text(
            txtCopy,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: fontMD,
              color: Colors.black54,
            ),
          ),
        )
      ],
    );
  }

  Widget _getExpire() {
    return Container(
      padding: const EdgeInsets.all(spaceMD),
      child: Column(
        children: [
          const Divider(height: 1),
          const SizedBox(height: spaceMD),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '$txtExpired:',
                style: TextStyle(
                  fontSize: fontMD,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: spaceMD),
          const Divider(height: 1),
        ],
      ),
    );
  }
}
