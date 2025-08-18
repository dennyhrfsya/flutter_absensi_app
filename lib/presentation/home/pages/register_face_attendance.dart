import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absensi_app/core/assets/assets.gen.dart';

import '../../../core/core.dart';

class RegisterFaceAttendancePage extends StatefulWidget {
  const RegisterFaceAttendancePage({super.key});

  @override
  State<RegisterFaceAttendancePage> createState() =>
      _RegisterFaceAttendancePageState();
}

class _RegisterFaceAttendancePageState
    extends State<RegisterFaceAttendancePage> {
  List<CameraDescription>? _availableCameras;
  late CameraDescription description = _availableCameras![1];
  CameraController? _controller;
  CameraLensDirection camDirec = CameraLensDirection.front;
  bool register = false;
  late Size size;

  @override
  void initState() {
    _initializeCamera();
    super.initState();
  }

  // instal kamera
  void _initializeCamera() async {
    _availableCameras = await availableCameras();
    _controller = CameraController(description, ResolutionPreset.high);

    // size = _controller!.value.previewSize!;

    await _controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  // fungsi untuk kamera depan
  void _reverseCamera() async {
    if (camDirec == CameraLensDirection.back) {
      camDirec = CameraLensDirection.front;
      description = _availableCameras![1];
    } else {
      camDirec = CameraLensDirection.back;
      description = _availableCameras![0];
    }
    // await _controller!.stopImageStream();
    // setState(() {
    //   _controller;
    // });
    _initializeCamera();
  }

  // fungsi untuk register muka default false
  void _takePicture() async {
    await _controller!.takePicture();
    if (mounted) {
      return;
    }
    setState(() {
      register = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    if (_controller == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 0.0,
              left: 0.0,
              width: size.width,
              height: size.height,
              child: AspectRatio(
                aspectRatio: _controller!.value.aspectRatio,
                child: CameraPreview(_controller!),
              ),
            ),
            // Positioned(
            //   top: 0.0,
            //   left: 0.0,
            //   width: size.width,
            //   height: size.height,
            //   child: buildResult(),
            // ),
            Positioned(
              bottom: 5.0,
              left: 0.0,
              right: 0.0,
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: _reverseCamera,
                          icon: Assets.icons.reverse.svg(width: 48.0),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: _takePicture,
                          icon: const Icon(Icons.circle, size: 70.0),
                          color: AppColors.red,
                        ),
                        const Spacer(),
                        const SpaceWidth(48.0),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
