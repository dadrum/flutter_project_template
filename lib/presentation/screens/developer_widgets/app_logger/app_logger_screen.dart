import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/environment/builders.dep_gen.dart';
import '../common_developer_button.dart';
import 'bloc/app_logger_bloc.dart';

class AppLoggerScreen extends StatelessWidget {
  const AppLoggerScreen({Key? key, required this.bottom}) : super(key: key);

  final double bottom;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppLoggerBloc>(
      create: (context) => context.depGen().buildAppLoggerBloc(),
      child: BlocBuilder<AppLoggerBloc, AppLoggerState>(
          builder: (context, state) => state.map(
                screenState: (state) => _ScreenState(
                  logs: state.logsStack,
                  bottom: bottom,
                ),
              )),
    );
  }
}

// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
class _ScreenState extends StatefulWidget {
  const _ScreenState({
    Key? key,
    required this.logs,
    required this.bottom,
  }) : super(key: key);

  final Iterable<String> logs;
  final double bottom;

  @override
  State<_ScreenState> createState() => _ScreenStateState();
}

class _ScreenStateState extends State<_ScreenState> {
  bool _logIsVisible = false;

  @override
  Widget build(BuildContext context) {
    return Stack(fit: StackFit.expand, children: [
      if (_logIsVisible)
        Positioned.fill(
          child: Material(
            color: Colors.white60,
            child: ListView.separated(
                itemCount: widget.logs.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) => Text(
                      widget.logs.elementAt(index),
                    )),
          ),
        ),
      Positioned(
          right: 4,
          bottom: widget.bottom,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_logIsVisible) ...[
                CommonDeveloperButton(
                  icon: Icons.refresh,
                  onTap: () => refreshTapped(context),
                ),
                const SizedBox(width: 4),
                CommonDeveloperButton(
                  icon: Icons.copy,
                  onTap: () => copyTapped(context),
                ),
                const SizedBox(width: 4),
                CommonDeveloperButton(
                  icon: Icons.restore_from_trash_outlined,
                  onTap: () => clearCartTapped(context),
                ),
                const SizedBox(width: 4),
              ],
              CommonDeveloperButton(
                icon: Icons.video_camera_back_outlined,
                onTap: switchLogVisibility,
              ),
            ],
          ))
    ]);
  }

  // ---------------------------------------------------------------------------
  void switchLogVisibility() {
    setState(() {
      _logIsVisible = !_logIsVisible;
    });
  }

  // ---------------------------------------------------------------------------
  void refreshTapped(BuildContext context) => context
      .read<AppLoggerBloc>()
      .add(const AppLoggerEvent.onUpdateRequested());

  // ---------------------------------------------------------------------------
  void clearCartTapped(BuildContext context) => context
      .read<AppLoggerBloc>()
      .add(const AppLoggerEvent.onClearRequested());

  // ---------------------------------------------------------------------------
  void copyTapped(BuildContext context) =>
      Clipboard.setData(ClipboardData(text: widget.logs.join('\n')));
}
