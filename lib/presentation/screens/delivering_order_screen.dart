import 'package:camera/camera.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shipper_app/business_logic/cubits/setting_cubit.dart';
import 'package:shipper_app/data/models/delivering_model.dart';
import 'package:shipper_app/presentation/screens/take_picture_screen.dart';
import 'package:shipper_app/presentation/widgets/order_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../res/dimen/dimens.dart';

class DeliveringOrderScreen extends StatefulWidget {
  const DeliveringOrderScreen({Key? key}) : super(key: key);

  @override
  State<DeliveringOrderScreen> createState() => _DeliveringOrderScreenState();
}

class _DeliveringOrderScreenState extends State<DeliveringOrderScreen> {
  late DeliveringModel delivering;
  bool started = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    delivering = ModalRoute.of(context)?.settings.arguments as DeliveringModel;
    if (delivering.orders[0].status == 'delivering') {
      started = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var s = <Polyline>{};
    s.clear();
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
              'Đơn đang giao',
              style: TextStyle(
                fontSize: fontLG,
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: GoogleMap(
              polylines: <Polyline>{delivering.route},
              initialCameraPosition: CameraPosition(
                target: LatLng(delivering.orders[0].store.lat,
                    delivering.orders[0].store.lng),
                zoom: 18,
              ),
            ),
          ),
          const SizedBox(height: spaceXS),
          RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: 'Trong trường hợp Map bị lỗi, hãy tới ứng dụng ',
                  style: TextStyle(color: Colors.black87),
                ),
                TextSpan(
                  text: 'Google Map',
                  style: const TextStyle(color: Colors.blue),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      var model = delivering.orders[0];
                      String url =
                          'https://www.google.com/maps/dir/?api=1&origin=${model.store.lat},${model.store.lng}&destination=${model.receiver.lat},${model.receiver.lng}&travelmode=driving&dir_action=navigate';
                      final Uri launchUri = Uri.parse(url);
                      launchUrl(launchUri);
                    },
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                const SizedBox(
                  height: spaceSM,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        for (var e in delivering.orders)
                          OrderWidget(
                            order: e,
                          ),
                      ],
                    ),
                  ),
                ),
                // ElevatedButton(
                //   onPressed: () {
                //     context
                //         .read<SettingCubit>()
                //         .updateOrderStatus(delivering.orders[0].id)
                //         .then((res) {
                //       if (res) {
                //         Navigator.pop(context);
                //       }
                //     });
                //   },
                //   child: const Text('Hoàn thành đơn'),
                // ),
                if (started)
                  ElevatedButton(
                    onPressed: () async {
                      // Đảm bảo các plugin service được khởi tạo trước khi chạy App
                      WidgetsFlutterBinding.ensureInitialized();

                      // Lấy ra các danh sách camera có sẵn trên thiết bị của user
                      final cameras = await availableCameras();

                      // Lấy một camera cụ thể từ danh sách cách camera
                      final firstCamera = cameras.first;
                      if (mounted) {
                        var file = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return CapturePictureScreen(camera: firstCamera);
                            },
                          ),
                        );
                        if (mounted && file is String) {
                          context
                              .read<SettingCubit>()
                              .finishOrder(
                                delivering.orders[0].id,
                                file,
                              )
                              .then((res) {
                            if (res) {
                              Navigator.pop(context);
                            }
                          });
                        }
                      }
                    },
                    child: const Text('Chụp ảnh và hoàn thành đơn'),
                  )
                else
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<SettingCubit>()
                          .startOrder(delivering.orders[0].id)
                          .then((value) {
                        setState(() {
                          started = value;
                        });
                      });
                    },
                    child: const Text('Đã nhận đơn từ cửa hàng'),
                  ),
                const SizedBox(height: dimMD),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
