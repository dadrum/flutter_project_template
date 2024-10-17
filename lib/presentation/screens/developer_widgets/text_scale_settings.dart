import 'package:flutter/material.dart';

import 'common_developer_button.dart';
import 'dynamic_media_query.dart';

// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
class TextScaleSettings extends StatefulWidget {
  const TextScaleSettings({Key? key}) : super(key: key);

  @override
  State<TextScaleSettings> createState() => TextScaleSettingsState();
}

class TextScaleSettingsState extends State<TextScaleSettings> {
  bool _controlsVisible = false;

  double? _currentSliderValue;

  @override
  void didChangeDependencies() {
    _currentSliderValue ??= MediaQuery.textScalerOf(context).scale(16) / 16;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _controlsVisible
          ? MediaQuery.of(context).size.width * 0.9
          : CommonDeveloperButton.size,
      child: Material(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: _controlsVisible ? MainAxisSize.max : MainAxisSize.min,
          children: [
            if (_controlsVisible) ...[
              const SizedBox(),
              CommonDeveloperButton(
                  onTap: () {
                    setState(() {
                      _currentSliderValue = 1;
                      DynamicMediaQuery.of(context)?.setTextScale(1);
                    });
                  },
                  icon: Icons.disabled_by_default_outlined),
              SizedBox(
                  width: 70,
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                          'x ' + _currentSliderValue!.toStringAsPrecision(2)))),
              const SizedBox(width: 24),
              Expanded(
                child: _CustomSlider(
                  value: _currentSliderValue!,
                  // max: 2,
                  // min: 0.5,
                  // divisions: 30,
                  // activeColor: Colors.yellow,
                  // inactiveColor: Colors.black,
                  onChanged: (value) {
                    if (_currentSliderValue != value) {
                      setState(() {
                        _currentSliderValue = value;
                        DynamicMediaQuery.of(context)?.setTextScale(value);
                      });
                    }
                  },
                ),
              ),
              const SizedBox(width: 24),
            ],
            CommonDeveloperButton(
              icon: Icons.text_fields_outlined,
              onTap: switchLogVisibility,
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  void switchLogVisibility() {
    setState(() {
      _controlsVisible = !_controlsVisible;
    });
  }
}

// ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------
class _CustomSlider extends StatelessWidget {
  const _CustomSlider({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final double value;
  final Function(double) onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: LayoutBuilder(
          builder: (canvas, constraints) => Listener(
                onPointerMove: (pm) {
                  double pos =
                      (pm.localPosition.dx / constraints.maxWidth).clamp(0, 1) *
                              1.5 +
                          0.5;

                  pos = (pos * 10).ceilToDouble() / 10;
                  onChanged(pos);
                },
                child: CustomPaint(
                  painter: _CustomPainter(
                    value: value,
                  ),
                ),
              )),
    );
  }
}

class _CustomPainter extends CustomPainter {
  _CustomPainter({required this.value});

  final double value;

  @override
  void paint(Canvas canvas, Size size) {
    final activeLinePaint = Paint()
      ..color = Colors.yellow
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round;

    final inactiveLinePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    // неактивная полоска
    canvas
      ..drawLine(
        Offset(0, size.height / 2),
        Offset(size.width, size.height / 2),
        inactiveLinePaint,
      )
      // активная полоска
      ..drawLine(
        Offset(0, size.height / 2),
        Offset(size.width * (value - 0.5) / 1.5, size.height / 2),
        activeLinePaint,
      )
      ..drawCircle(Offset(size.width * (value - 0.5) / 1.5, size.height * 0.5),
          12, activeLinePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
