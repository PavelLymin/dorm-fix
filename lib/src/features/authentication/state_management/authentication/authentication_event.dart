part of 'authentication_bloc.dart';

typedef AuthEventMatch<R, S extends AuthEvent> = FutureOr<R> Function(S event);

sealed class AuthEvent {
  const AuthEvent();

  const factory AuthEvent.logIn({
    required String email,
    required String password,
  }) = _LogIn;

  const factory AuthEvent.verifyPhoneNumber({required String phoneNumber}) =
      _VerifyPhoneNumber;

  const factory AuthEvent.signInWithPhoneNumber({
    required String verificationId,
    required String smsCode,
  }) = _SignInWithPhoneNumber;

  const factory AuthEvent.signInWithGoogle() = _SignInWithGoogle;

  const factory AuthEvent.signOut() = _SignOut;

  FutureOr<R> map<R>({
    // ignore: library_private_types_in_public_api
    required AuthEventMatch<R, _LogIn> logIn,
    // ignore: library_private_types_in_public_api
    required AuthEventMatch<R, _VerifyPhoneNumber> verifyPhoneNumber,
    // ignore: library_private_types_in_public_api
    required AuthEventMatch<R, _SignInWithPhoneNumber> signInWithPhoneNumber,
    // ignore: library_private_types_in_public_api
    required AuthEventMatch<R, _SignInWithGoogle> signInWithGoogle,
    // ignore: library_private_types_in_public_api
    required AuthEventMatch<R, _SignOut> signOut,
  }) => switch (this) {
    _LogIn s => logIn(s),
    _VerifyPhoneNumber s => verifyPhoneNumber(s),
    _SignInWithPhoneNumber s => signInWithPhoneNumber(s),
    _SignInWithGoogle s => signInWithGoogle(s),
    _SignOut s => signOut(s),
  };
}

final class _LogIn extends AuthEvent {
  const _LogIn({required this.email, required this.password});

  final String email;
  final String password;
}

final class _VerifyPhoneNumber extends AuthEvent {
  const _VerifyPhoneNumber({required this.phoneNumber});

  final String phoneNumber;
}

final class _SignInWithPhoneNumber extends AuthEvent {
  const _SignInWithPhoneNumber({
    required this.verificationId,
    required this.smsCode,
  });

  final String verificationId;
  final String smsCode;
}

final class _SignInWithGoogle extends AuthEvent {
  const _SignInWithGoogle();
}

final class _SignOut extends AuthEvent {
  const _SignOut();
}
