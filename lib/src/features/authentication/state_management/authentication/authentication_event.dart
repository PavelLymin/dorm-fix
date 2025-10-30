part of 'authentication_bloc.dart';

typedef AuthEventMatch<R, S extends AuthEvent> = FutureOr<R> Function(S event);

sealed class AuthEvent {
  const AuthEvent();

  const factory AuthEvent.signInWithEmailAndPassword({
    required String email,
    required String password,
  }) = _SignInWithEmailAndPassword;

  const factory AuthEvent.signUpWithEmailAndPassword({
    required String email,
    required String displayName,
    required String photoURL,
    required String password,
    required String phoneNumber,
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
    // ignore: library_private_types_in_public_api
    required AuthEventMatch<R, _SignInWithEmailAndPassword>
    signInWithEmailAndPassword,
    // ignore: library_private_types_in_public_api
    required AuthEventMatch<R, _SignUpWithEmailAndPassword>
    signUpWithEmailAndPassword,
    // ignore: library_private_types_in_public_api
    required AuthEventMatch<R, _VerifyPhoneNumber> verifyPhoneNumber,
    // ignore: library_private_types_in_public_api
    required AuthEventMatch<R, _SignInWithPhoneNumber> signInWithPhoneNumber,
    // ignore: library_private_types_in_public_api
    required AuthEventMatch<R, _SignInWithGoogle> signInWithGoogle,
    // ignore: library_private_types_in_public_api
    required AuthEventMatch<R, _SignOut> signOut,
  }) => switch (this) {
    _SignInWithEmailAndPassword s => signInWithEmailAndPassword(s),
    _SignUpWithEmailAndPassword s => signUpWithEmailAndPassword(s),
    _VerifyPhoneNumber s => verifyPhoneNumber(s),
    _SignInWithPhoneNumber s => signInWithPhoneNumber(s),
    _SignInWithGoogle s => signInWithGoogle(s),
    _SignOut s => signOut(s),
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
    required this.displayName,
    required this.photoURL,
    required this.password,
    required this.phoneNumber,
  });

  final String email;
  final String displayName;
  final String photoURL;
  final String password;
  final String phoneNumber;
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
