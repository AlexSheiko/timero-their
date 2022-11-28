import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';

class CustomLoaderOverlay extends StatelessWidget {
  final Widget child;

  const CustomLoaderOverlay({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100.0),
          child: CustomLoadingIndicator(
            color: Theme.of(context).focusColor,
            size: 50.0,
          ),
        ),
      ),
      overlayOpacity: 0,
      child: child,
    );
  }
}

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({
    this.color = Colors.blue,
    this.size = 50,
    Key? key,
  }) : super(key: key);

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SpinKitDoubleBounce(
      color: color,
      size: size,
    );
  }
}
