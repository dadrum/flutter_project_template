// types of timers/timeouts in the application

enum InAppTimers {
  /// Timeout for sending SMS during registration
  registrationPinCodeRequestTimeout,

  /// Timeout for sending SMS when password is restored
  restorePinCodeRequestTimeout,
}
