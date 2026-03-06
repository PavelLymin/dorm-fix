part of 'authentication_bloc.dart';

typedef AuthEventMatch<R, E extends AuthEvent> = FutureOr<R> Function(E event);

sealed class AuthEvent {
  const AuthEvent();

  const factory AuthEvent.signInWithEmailAndPassword({
    required String email,
    required String password,
  }) = _SignInWithEmailAndPassword;

  const factory AuthEvent.signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) = _SignUpWithEmailAndPassword;

  const factory AuthEvent.verifyPhoneNumber({required String phoneNumber}) =
      _VerifyPhoneNumber;

  const factory AuthEvent.signInWithPhoneNumber({
    required String verificationId,
    required String smsCode,
  }) = _SignInWithPhoneNumber;

  const factory AuthEvent.signInWithGoogle() = _SignInWithGoogle;

  const factory AuthEvent.signOut() = _SignOut;

  FutureOr<R> map<R>({
    required AuthEventMatch<R, _SignInWithEmailAndPassword>
    signInWithEmailAndPassword,
    required AuthEventMatch<R, _SignUpWithEmailAndPassword>
    signUpWithEmailAndPassword,
    required AuthEventMatch<R, _VerifyPhoneNumber> verifyPhoneNumber,
    required AuthEventMatch<R, _SignInWithPhoneNumber> signInWithPhoneNumber,
    required AuthEventMatch<R, _SignInWithGoogle> signInWithGoogle,
    required AuthEventMatch<R, _SignOut> signOut,
  }) => switch (this) {
    _SignInWithEmailAndPassword e => signInWithEmailAndPassword(e),
    _SignUpWithEmailAndPassword e => signUpWithEmailAndPassword(e),
    _VerifyPhoneNumber e => verifyPhoneNumber(e),
    _SignInWithPhoneNumber e => signInWithPhoneNumber(e),
    _SignInWithGoogle e => signInWithGoogle(e),
    _SignOut e => signOut(e),
  };
}

final class _SignInWithEmailAndPassword extends AuthEvent {
  const _SignInWithEmailAndPassword({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}

final class _SignUpWithEmailAndPassword extends AuthEvent {
  const _SignUpWithEmailAndPassword({
    required this.email,
    required this.password,
  });

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
