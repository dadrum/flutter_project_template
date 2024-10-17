import 'package:flutter/material.dart';

class CommonPaginationListener extends StatelessWidget {
  const CommonPaginationListener({
    required this.listenableChild,
    required this.onListEnded,
    this.actuationRange = 500,
    Key? key,
  }) : super(key: key);

  /// listenableChild: Listenable child (scrollable ListView,
  /// CustomScrollView, SingleChildScrollView, etc.)
  final Widget listenableChild;

  /// onListEnded: Callback called when the end of the list is reached
  final void Function() onListEnded;

  /// actuationRangeLength: The length of the trigger area ("allowance at the bottom of the list")
  final double actuationRange;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollMetricsNotification>(
      onNotification: _onScrollNotification,
      child: listenableChild,
    );
  }

  // ---------------------------------------------------------------------------
  /// Analyzes the result of scrolling the list [listenableChild] and calls the callback [onListEnded]
  /// when the [actuationRange] trigger point is reached at the end of the list
  bool _onScrollNotification(ScrollMetricsNotification notification) {
    final scrolledToBottom = notification.metrics.extentAfter < actuationRange;
    if (scrolledToBottom) onListEnded.call();
    return false;
  }
}
