part of 'authentication_bloc.dart';

typedef AuthStateMatch<R, S extends AuthState> = R Function(S state);

sealed class AuthState {
  const AuthState({required this.user});

  final UserEntity user;

  const factory AuthState.loggedIn({required AuthenticatedUser user}) =
      _LoggedIn;

  const factory AuthState.signedUp({required AuthenticatedUser user}) =
      _SignedUp;

  const factory AuthState.smsCodeSent({required String verificationId}) =
      _SmsCodeSent;

  const factory AuthState.notAuthenticated() = _NotAuthenticated;

  const factory AuthState.loading({required UserEntity user}) = _Loading;

  const factory AuthState.error({
    required UserEntity user,
    required Object message,
  }) = _Error;

  bool get isAuthenticated => currentUser.isAuthenticated;

  UserEntity get currentUser => map(
    loggedIn: (state) => state.user,
    signedUp: (state) => state.user,
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

  bool get isSmsCodeSent =>
      maybeMap(smsCodeSent: (_) => true, orElse: () => false);

  R map<R>({
    required AuthStateMatch<R, _LoggedIn> loggedIn,
    required AuthStateMatch<R, _SignedUp> signedUp,
    required AuthStateMatch<R, _SmsCodeSent> smsCodeSent,
    required AuthStateMatch<R, _NotAuthenticated> notAuthenticated,
    required AuthStateMatch<R, _Loading> loading,
    required AuthStateMatch<R, _Error> error,
  }) => switch (this) {
    _LoggedIn s => loggedIn(s),
    _SignedUp s => signedUp(s),
    _SmsCodeSent s => smsCodeSent(s),
    _NotAuthenticated s => notAuthenticated(s),
    _Loading s => loading(s),
    _Error s => error(s),
  };

  R maybeMap<R>({
    required R Function() orElse,
    AuthStateMatch<R, _LoggedIn>? loggedIn,
    AuthStateMatch<R, _SignedUp>? signedUp,
    AuthStateMatch<R, _SmsCodeSent>? smsCodeSent,
    AuthStateMatch<R, _NotAuthenticated>? notAuthenticated,
    AuthStateMatch<R, _Loading>? loading,
    AuthStateMatch<R, _Error>? error,
  }) => map<R>(
    loggedIn: loggedIn ?? (_) => orElse(),
    signedUp: signedUp ?? (_) => orElse(),
    smsCodeSent: smsCodeSent ?? (_) => orElse(),
    notAuthenticated: notAuthenticated ?? (_) => orElse(),
    loading: loading ?? (_) => orElse(),
    error: error ?? (_) => orElse(),
  );

  R? mapOrNull<R>({
    AuthStateMatch<R, _LoggedIn>? loggedIn,
    AuthStateMatch<R, _SignedUp>? signedUp,
    AuthStateMatch<R, _SmsCodeSent>? smsCodeSent,
    AuthStateMatch<R, _NotAuthenticated>? notAuthenticated,
    AuthStateMatch<R, _Loading>? loading,
    AuthStateMatch<R, _Error>? error,
  }) => map<R?>(
    loggedIn: loggedIn ?? (_) => null,
    signedUp: signedUp ?? (_) => null,
    smsCodeSent: smsCodeSent ?? (_) => null,
    notAuthenticated: notAuthenticated ?? (_) => null,
    loading: loading ?? (_) => null,
    error: error ?? (_) => null,
  );
}

final class _LoggedIn extends AuthState {
  const _LoggedIn({required super.user});
}

final class _SignedUp extends AuthState {
  const _SignedUp({required super.user});
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

  final Object message;
}
