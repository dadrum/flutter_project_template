import 'dart:async';

class Debouncer<T> {
  Debouncer({
    required Function(T?) callBack,
    int period = defaultPeriod,
  })  : _callBack = callBack,
        _period = period;
  static const int defaultPeriod = 1000;

  Timer? _debounceTimer;

  final int _period;
  final Function(T?) _callBack;
  T? _cachedObject;

  T? get cachedObject => _cachedObject;

  void onEvent(T? newObject, {int? period}) {
    final isCleared = T is! String
        ? newObject == null && _cachedObject != null
        : ((_cachedObject as String?)?.isNotEmpty ?? false) &&
            (newObject as String).isEmpty;

    _cachedObject = newObject;
    if (_debounceTimer != null) {
      _debounceTimer!.cancel();
    }
    if (isCleared) {
      _callBack(_cachedObject);
    } else {
      _debounceTimer = Timer(Duration(milliseconds: period ?? _period), () {
        _debounceTimer?.cancel();
        _debounceTimer = null;
        _callBack(_cachedObject);
      });
    }
  }

  void dispose() {
    _debounceTimer?.cancel();
  }
}
