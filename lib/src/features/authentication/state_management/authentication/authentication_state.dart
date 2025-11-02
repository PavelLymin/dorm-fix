part of 'authentication_bloc.dart';

typedef AuthStateMatch<R, S extends AuthState> = R Function(S state);

sealed class AuthState {
  const AuthState({required this.user});

  final UserEntity user;

  const factory AuthState.authenticated({required AuthenticatedUser user}) =
      _Authenticated;

  const factory AuthState.smsCodeSent({required String verificationId}) =
      _SmsCodeSent;

  const factory AuthState.notAuthenticated() = _NotAuthenticated;

  const factory AuthState.loading({required UserEntity user}) = _Loading;

  const factory AuthState.error({
    required UserEntity user,
    required String message,
  }) = _Error;

  bool get isAuthenticated => currentUser.isAuthenticated;

  UserEntity get currentUser => map(
    authenticated: (state) => state.user,
    notAuthenticated: (state) => state.user,
    smsCodeSent: (state) => state.user,
    loading: (state) => state.user,
    error: (state) => state.user,
  );

  AuthenticatedUser? get authenticatedOrNull => maybeMap(
    orElse: () => currentUser.authenticatedOrNull,
    notAuthenticated: (_) => null,
  );

  bool get isLoading => maybeMap(loading: (_) => true, orElse: () => false);

  R map<R>({
    // ignore: library_private_types_in_public_api
    required AuthStateMatch<R, _Authenticated> authenticated,
    // ignore: library_private_types_in_public_api
    required AuthStateMatch<R, _SmsCodeSent> smsCodeSent,
    // ignore: library_private_types_in_public_api
    required AuthStateMatch<R, _NotAuthenticated> notAuthenticated,
    // ignore: library_private_types_in_public_api
    required AuthStateMatch<R, _Loading> loading,
    // ignore: library_private_types_in_public_api
    required AuthStateMatch<R, _Error> error,
  }) => switch (this) {
    _Authenticated s => authenticated(s),
    _SmsCodeSent s => smsCodeSent(s),
    _NotAuthenticated s => notAuthenticated(s),
    _Loading s => loading(s),
    _Error s => error(s),
  };

  R maybeMap<R>({
    required R Function() orElse,
    // ignore: library_private_types_in_public_api
    AuthStateMatch<R, _Authenticated>? authenticated,
    // ignore: library_private_types_in_public_api
    AuthStateMatch<R, _SmsCodeSent>? smsCodeSent,
    // ignore: library_private_types_in_public_api
    AuthStateMatch<R, _NotAuthenticated>? notAuthenticated,
    // ignore: library_private_types_in_public_api
    AuthStateMatch<R, _Loading>? loading,
    // ignore: library_private_types_in_public_api
    AuthStateMatch<R, _Error>? error,
  }) => map<R>(
    authenticated: authenticated ?? (_) => orElse(),
    smsCodeSent: smsCodeSent ?? (_) => orElse(),
    notAuthenticated: notAuthenticated ?? (_) => orElse(),
    loading: loading ?? (_) => orElse(),
    error: error ?? (_) => orElse(),
  );

  R? mapOrNull<R>({
    // ignore: library_private_types_in_public_api
    AuthStateMatch<R, _Authenticated>? authenticated,
    // ignore: library_private_types_in_public_api
    AuthStateMatch<R, _SmsCodeSent>? smsCodeSent,
    // ignore: library_private_types_in_public_api
    AuthStateMatch<R, _NotAuthenticated>? notAuthenticated,
    // ignore: library_private_types_in_public_api
    AuthStateMatch<R, _Loading>? loading,
    // ignore: library_private_types_in_public_api
    AuthStateMatch<R, _Error>? error,
  }) => map<R?>(
    authenticated: authenticated ?? (_) => null,
    smsCodeSent: smsCodeSent ?? (_) => null,
    notAuthenticated: notAuthenticated ?? (_) => null,
    loading: loading ?? (_) => null,
    error: error ?? (_) => null,
  );
}

final class _Authenticated extends AuthState {
  const _Authenticated({required super.user});
}

final class _SmsCodeSent extends AuthState {
  const _SmsCodeSent({
    super.user = const NotAuthenticatedUser(),
    required this.verificationId,
  });

  final String verificationId;
}

final class _NotAuthenticated extends AuthState {
  const _NotAuthenticated({super.user = const NotAuthenticatedUser()});
}

final class _Loading extends AuthState {
  const _Loading({required super.user});
}

final class _Error extends AuthState {
  const _Error({required super.user, required this.message});

  final String message;
}
