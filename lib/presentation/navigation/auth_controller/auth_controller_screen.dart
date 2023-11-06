import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/environment/builders.dep_gen.dart';
import '../../../domain/interfaces/i_authenticate_controller.dart';
import '../../../l10n/locale_provider.dart';
import '../../screens/auth/auth_screen.dart';
import '../../screens/workspace/workspace_screen.dart';
import 'bloc/auth_controller_bloc.dart';

class AuthControllerScreen extends StatelessWidget {
  const AuthControllerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Localizations.override(
        context: context,
        locale: LocaleProvider.of(context)!.locale,
        child: BlocProvider<AuthControllerBloc>(
            create: (_) => context.depGen().buildAuthControllerBloc(),
            child: BlocBuilder<AuthControllerBloc, AuthControllerStates>(
                builder: (context, state) => state.map(newStatus: (state) {
                      switch (state.status) {
                        case AuthenticateStatus.authorized:
                          return const WorkSpaceScreen();
                        case AuthenticateStatus.notAuthorized:
                          return const AuthScreen();
                      }
                    }))));
  }
}
