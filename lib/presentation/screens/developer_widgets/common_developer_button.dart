import 'package:flutter/material.dart';

class CommonDeveloperButton extends StatelessWidget {
  const CommonDeveloperButton({
    Key? key,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  static const double size = 48;

  final VoidCallback onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
        dimension: size,
        child: Opacity(
            opacity: 0.7,
            child: Stack(
              children: [
                const Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.yellow,
                              Colors.black,
                              Colors.yellow,
                              Colors.black,
                              Colors.yellow,
                              Colors.black,
                              Colors.yellow,
                              Colors.black,
                            ])),
                  ),
                ),
                const Center(
                  child: SizedBox.square(
                    dimension: size - 8,
                    child: DecoratedBox(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white)),
                  ),
                ),
                Center(
                  child: Icon(icon),
                ),
                Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(size * 0.5),
                  child: InkWell(
                      borderRadius: BorderRadius.circular(size * 0.5),
                      onTap: onTap),
                )
              ],
            )));
  }
}
