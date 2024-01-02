import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:shipper_app/presentation/res/dimen/dimens.dart';

class CapturePictureScreen extends StatefulWidget {
  const CapturePictureScreen({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  CapturePictureScreenState createState() => CapturePictureScreenState();
}

class CapturePictureScreenState extends State<CapturePictureScreen> {
  late CameraController _controller;
  late Future<void> _futureController;
  String? imagePath;

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      // To display the current output from the Camera,
      // create a CameraController.
      _controller = CameraController(
        // Get a specific camera from the list of available cameras.
        widget.camera,
        // Define the resolution to use.
        ResolutionPreset.medium,
      );

      // Next, initialize the controller. This returns a Future.
      _futureController = _controller.initialize();
    } else if (state == AppLifecycleState.paused) {
      _controller.dispose();
    } else if (state == AppLifecycleState.inactive) {
      _controller.dispose();
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );

    _futureController = _controller.initialize();
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
        title: const Text(
          'Chụp ảnh xác nhận đơn hàng',
          style: TextStyle(fontSize: fontLG),
        ),
        actions: [
          if (imagePath != null)
            TextButton(
                onPressed: () {
                  Navigator.pop(context, imagePath);
                },
                child: const Text('GỬI')),
        ],
      ),
      body: imagePath != null
          ? SizedBox(
              height: double.maxFinite,
              child: Image.file(
                File(imagePath!),
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.center,
              ))
          : SizedBox(
              height: double.maxFinite,
              child: FutureBuilder<void>(
                future: _futureController,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return CameraPreview(_controller);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (imagePath != null) {
            setState(() {
              imagePath = null;
            });
            return;
          }
          try {
            await _futureController;
            final image = await _controller.takePicture();

            if (!mounted) return;
            setState(() {
              imagePath = image.path;
            });
          } catch (e) {
            // If an error occurs, log the error to the console.
            // print(e);
          }
        },
        child: imagePath == null
            ? const Icon(
                Icons.camera_alt,
                color: Colors.white,
              )
            : const Icon(
                Icons.refresh_rounded,
                color: Colors.white,
              ),
      ),
    );
  }
}
