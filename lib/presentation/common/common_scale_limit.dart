import 'package:flutter/material.dart';

class CommonScaleLimit extends StatelessWidget {
  const CommonScaleLimit({
    Key? key,
    required this.child,
    required this.maxScaleFactor,
  }) : super(key: key);

  final Widget child;
  final double maxScaleFactor;

  @override
  Widget build(BuildContext context) {
    final currentScaler =
        MediaQuery.of(context).textScaler.clamp(maxScaleFactor: maxScaleFactor);
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: currentScaler),
      child: child,
    );
  }
}
