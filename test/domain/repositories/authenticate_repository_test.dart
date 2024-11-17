import 'package:app_template/data/local_cache/local_cache.dart';
import 'package:app_template/data/repositories/authenticate_repository.dart';
import 'package:app_template/domain/entities/jwt_tokens.dart';
import 'package:app_template/domain/repositories/i_authenticate_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<LocalCache>()])
import 'authenticate_repository_test.mocks.dart';

void main() {
  group('AuthenticateController', () {
    late IAuthenticateController authenticateController;
    late MockLocalCache mockLocalCache;
    late JwtTokens someJwtTokens;
    // listener
    late int notificationsCounter;

    final notificationCallback = () => notificationsCounter++;

    // -------------------------------------------------------------------------
    setUp(() {
      someJwtTokens = const JwtTokens(
        access: 'any_access_token',
        refresh: 'any_refresh_token',
      );
      mockLocalCache = MockLocalCache();
      authenticateController =
          AuthenticateController(localCache: mockLocalCache);

      notificationsCounter = 0;
      authenticateController.addListener(notificationCallback);
    });

    // tearDown(() async {
    // });

    // -------------------------------------------------------------------------
    test('authenticateController should initialize with notAuthorized', () {
      expect(authenticateController.status, AuthenticateStatus.notAuthorized);
    });

    // -------------------------------------------------------------------------
    test('onAuthenticated save tokens in cache and set up authorized status',
        () async {
      // When
      await authenticateController.onAuthenticated(
        someJwtTokens.access,
        someJwtTokens.refresh,
      );

      // Then
      // 1) the authorization status is changing
      expect(authenticateController.status, AuthenticateStatus.authorized);
      // 2) Subscribers are notified once
      expect(notificationsCounter, 1);
      // 3) tokens are stored in the cache
      verify(mockLocalCache.setAuthTokens(tokens: someJwtTokens)).called(1);
    });

    // -------------------------------------------------------------------------
    test(
        'onAuthenticateCanceled clear cached tokens and set up not authorized status',
        () async {
      // When
      await authenticateController.onAuthenticateCanceled();

      // Then
      // 1) the authorization status is changing
      expect(authenticateController.status, AuthenticateStatus.notAuthorized);
      // 2) Subscribers are notified once
      expect(notificationsCounter, 1);
      // 3) tokens are cleared in the cache
      verify(mockLocalCache.deleteAuthTokens()).called(1);
    });
  });

  // ---------------------------------------------------------------------------
  // ---------------------------------------------------------------------------
  // ---------------------------------------------------------------------------
  group('AuthenticateRepository', () {
    late IAuthenticateRepository authenticateRepository;
    late MockLocalCache mockLocalCache;
    late AuthenticateSubscription authenticateSubscription;
    late List<AuthenticateStatus> receivedStatuses;
    late JwtTokens someJwtTokens;

    setUp(() {
      someJwtTokens = const JwtTokens(
        access: 'any_access_token',
        refresh: 'any_refresh_token',
      );
      receivedStatuses = [];
      mockLocalCache = MockLocalCache();
      authenticateRepository =
          AuthenticateRepository(localCache: mockLocalCache);
      authenticateSubscription = authenticateRepository
          .subscribe((newStatus) => receivedStatuses.add(newStatus));
    });

    tearDown(() async {
      await authenticateRepository.close();
      await authenticateSubscription.cancel();
    });

    // -------------------------------------------------------------------------
    test('getCachedTokens() - reading cached tokens', () async {
      // Given
      when(mockLocalCache.getAuthTokens())
          .thenAnswer((_) async => someJwtTokens);
      // When
      await authenticateRepository.controller.onAuthenticated(
        someJwtTokens.access,
        someJwtTokens.refresh,
      );
      // Then
      // check cached tokens
      expect(await authenticateRepository.getCachedTokens(), someJwtTokens);
    });

    // -------------------------------------------------------------------------
    test('getCachedTokens() - empty tokens after logout', () async {
      // Given
      when(mockLocalCache.getAuthTokens()).thenAnswer((_) async => null);
      // When
      await authenticateRepository.controller.onAuthenticateCanceled();
      // Then
      expect(await authenticateRepository.getCachedTokens(), isNull);
    });

    // -------------------------------------------------------------------------
    test('logout() - logging out with token clearing', () async {
      // When
      await authenticateRepository.logout();
      await Future.delayed(const Duration(milliseconds: 50));
      // Then
      // 1) the authorization status is changing
      expect(authenticateRepository.controller.status,
          AuthenticateStatus.notAuthorized);
      // 2) Subscribers are notified once
      expect(receivedStatuses.length, 1);
      // 3) subscribers are notified
      expect(receivedStatuses.last, AuthenticateStatus.notAuthorized);
    });
  });
}
