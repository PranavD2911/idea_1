import 'package:clock_loader/clock_loader.dart';
import 'package:flutter/material.dart';

class LoadingScreenWidget extends StatefulWidget {
  final VoidCallback? onPop;
  const LoadingScreenWidget({super.key, this.onPop});

  @override
  State<LoadingScreenWidget> createState() => _LoadingScreenWidgetState();
}

class _LoadingScreenWidgetState extends State<LoadingScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () => widget.onPop ?? Navigator.pop(context),
        child: ClockLoader(
          clockLoaderModel: ClockLoaderModel(
            shapeOfParticles: ShapeOfParticlesEnum.circle,
            mainHandleColor: Colors.white,
            particlesColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
