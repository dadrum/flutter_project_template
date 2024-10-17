import 'package:flutter/foundation.dart';

import '../../http_client/http_client.dart';
import '../../http_client/i_api_request.dart';

@immutable
class RequestAuth extends IApiRequest {
  const RequestAuth({
    required this.login,
    required this.password,
  }) : super(
          methodType: AvailableApiMethods.post,
          url: '/users/auth',
        );

  // Request data
  final String login;
  final String password;

  // Request body
  @override
  Map<String, Object?>? get body => {
        'email': login,
        'password': password,
      };

  // @override
  // String get endPoint => '$initialUrl/$some_args?param=$p1';
}
