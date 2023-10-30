import 'package:flutter/material.dart';

class CommonUnFocusByGesture extends StatefulWidget {
  const CommonUnFocusByGesture({Key? key, required this.child, this.nodes})
      : super(key: key);

  final Widget child;
  final Iterable<FocusNode>? nodes;

  @override
  State<CommonUnFocusByGesture> createState() => _CommonUnFocusByGestureState();
}

class _CommonUnFocusByGestureState extends State<CommonUnFocusByGesture> {
  late bool keyboardVisible;
  late double triggerYPos;

  @override
  void didChangeDependencies() {
    final mq = MediaQuery.of(context);
    keyboardVisible = mq.viewInsets.bottom > 60;
    triggerYPos = mq.size.height - mq.viewInsets.bottom;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerMove: (pe) => _onPointerMove(context, pe),
      child: widget.child,
    );
  }

  void _onPointerMove(BuildContext context, PointerMoveEvent pe) {
    // смещение пальца вниз и клавиатура видна
    if (pe.delta.dy >= 0.9 && keyboardVisible) {
      // триггерим закрытие клавиатуры
      if ((pe.position.dy - 50) >= triggerYPos) {
        if (widget.nodes == null) {
          if (FocusScope.of(context).hasFocus) {
            FocusScope.of(context).unfocus();
          }
        } else {
          widget.nodes!.forEach((element) {
            if (element.hasFocus) {
              element.unfocus();
            }
          });
        }
      }
    }
  }
}
