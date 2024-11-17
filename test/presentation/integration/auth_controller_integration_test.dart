import 'package:app_template/core/environment/builders.dep_gen.dart';
import 'package:app_template/core/environment/environment.dart';
import 'package:app_template/data/local_cache/local_cache.dart';
import 'package:app_template/data/repositories/authenticate_repository.dart';
import 'package:app_template/domain/entities/jwt_tokens.dart';
import 'package:app_template/domain/repositories/i_authenticate_repository.dart';
import 'package:app_template/l10n/locale_provider.dart';
import 'package:app_template/presentation/auth_controller/auth_controller_screen.dart';
import 'package:app_template/presentation/auth_controller/bloc/auth_controller_bloc.dart';
import 'package:app_template/presentation/screens/auth/auth_screen.dart';
import 'package:app_template/presentation/screens/workspace/workspace_screen.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<LocalCache>()])
import 'auth_controller_integration_test.mocks.dart';

void main() {
  late MockLocalCache mockLocalCache;
  late Environment depGenEnvironment;
  late JwtTokens someJwtTokens;

  // ---------------------------------------------------------------------------
  setUp(() {
    someJwtTokens = const JwtTokens(
      access: 'any_access_token',
      refresh: 'any_refresh_token',
    );

    // DepGen environment
    mockLocalCache = MockLocalCache();
    when(mockLocalCache.setAuthTokens(tokens: someJwtTokens))
        .thenAnswer((_) async => {});
    when(mockLocalCache.deleteAuthTokens()).thenAnswer((_) async => {});
    depGenEnvironment = Environment()
      ..registry<IAuthenticateRepository>(
          AuthenticateRepository(localCache: mockLocalCache));
  });

  // ---------------------------------------------------------------------------
  group('CounterBloc', () {
    late DepProvider depProvider;

    setUp(() {
      depProvider = DepProvider(
        environment: depGenEnvironment,
        child: const SizedBox.shrink(),
      );
    });

    // ---------------------------------------------------------------------------
    blocTest('the status changes when authorization occurs in the repository',
        setUp: () => depGenEnvironment.g<IAuthenticateRepository>().logout(),
        build: () => depProvider.buildAuthControllerBloc(),
        act: (_) => depGenEnvironment
            .g<IAuthenticateRepository>()
            .controller
            .onAuthenticated(someJwtTokens.access, someJwtTokens.refresh),
        wait: const Duration(milliseconds: 100),
        expect: () => [
              const AuthControllerStates.newStatus(
                  status: AuthenticateStatus.authorized),
            ]);
    // ---------------------------------------------------------------------------
    blocTest('the state changes when there is an logout in the repository',
        setUp: () => depGenEnvironment
            .g<IAuthenticateRepository>()
            .controller
            .onAuthenticated(someJwtTokens.access, someJwtTokens.refresh),
        build: () => depProvider.buildAuthControllerBloc(),
        act: (_) => depGenEnvironment.g<IAuthenticateRepository>().logout(),
        wait: const Duration(milliseconds: 100),
        expect: () => [
              const AuthControllerStates.newStatus(
                  status: AuthenticateStatus.notAuthorized),
            ]);
  });

  // ---------------------------------------------------------------------------
  testWidgets('Displaying the authorization screen for an unregistered user',
      (tester) async {
    // Given
    await depGenEnvironment.g<IAuthenticateRepository>().logout();
    // When
    await tester.pumpWidget(DepProvider(
      environment: depGenEnvironment,
      child: const LocaleProvider(
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          home: AuthControllerScreen(),
        ),
      ),
    ));

    // Then
    expect(find.byType(AuthScreen), findsOneWidget);
    expect(find.byType(WorkSpaceScreen), findsNothing);
  });

  // ---------------------------------------------------------------------------
  testWidgets('Displaying the main screen when the user is registered',
      (tester) async {
    // Given
    await depGenEnvironment
        .g<IAuthenticateRepository>()
        .controller
        .onAuthenticated(someJwtTokens.access, someJwtTokens.refresh);
    // When
    await tester.pumpWidget(DepProvider(
      environment: depGenEnvironment,
      child: const LocaleProvider(
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          home: AuthControllerScreen(),
        ),
      ),
    ));

    // Then
    expect(find.byType(AuthScreen), findsNothing);
    expect(find.byType(WorkSpaceScreen), findsOneWidget);
  });
}
