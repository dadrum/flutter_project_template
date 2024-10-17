import 'package:flutter/material.dart';

class DynamicMediaQuery extends StatefulWidget {
  const DynamicMediaQuery({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  _DynamicMediaQueryState createState() => _DynamicMediaQueryState();

  // ---------------------------------------------------------------------------
  static _DynamicMediaQueryState? of(BuildContext context) {
    return context.findAncestorStateOfType<_DynamicMediaQueryState>();
  }
}

// ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------
class _DynamicMediaQueryState extends State<DynamicMediaQuery> {
  late MediaQueryData _mediaQueryData;

  late bool isThemeInitialized;

  double? _customTextScaleFactor;

  MediaQueryData get mediaQueryData => _mediaQueryData;

  // ---------------------------------------------------------------------------
  @override
  void initState() {
    isThemeInitialized = false;
    super.initState();
  }

  // ---------------------------------------------------------------------------
  @override
  void didChangeDependencies() {
    // if (!isThemeInitialized) {

    _mediaQueryData = MediaQuery.of(context);

    if (_customTextScaleFactor != null) {
      _mediaQueryData = _mediaQueryData.copyWith(
          textScaler: TextScaler.linear(_customTextScaleFactor!));
    }
    isThemeInitialized = true;
    // }
    super.didChangeDependencies();
  }

  // ---------------------------------------------------------------------------
  void setTextScale(double textScaleFactor) {
    setState(() {
      _customTextScaleFactor = textScaleFactor;
      _mediaQueryData = _mediaQueryData.copyWith(
          textScaler: TextScaler.linear(_customTextScaleFactor!));
    });
  }

  // ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: _mediaQueryData,
      child: widget.child,
    );
  }
}
