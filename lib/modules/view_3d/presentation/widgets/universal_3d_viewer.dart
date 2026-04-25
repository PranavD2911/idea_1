import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';

class Universal3DViewer extends StatelessWidget {
  final String src;

  const Universal3DViewer({Key? key, required this.src}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      // User model_viewer_plus for Flutter Web
      return ModelViewer(
        src: src,
        alt: 'A 3D model',
        ar: true,
        autoRotate: true,
        autoRotateDelay: 1000,
        cameraControls: true,
        cameraOrbit: '45deg 55deg 2.5m',
        shadowIntensity: 1.0,
        exposure: 1.0,
      );
    } else {
      // Use flutter_3d_controller for Mobile (Android & iOS)
      return Flutter3DViewer(
        src: src,
      );
    }
  }
}
