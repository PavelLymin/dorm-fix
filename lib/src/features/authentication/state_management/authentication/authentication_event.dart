part of 'authentication_bloc.dart';

typedef AuthEventMatch<R, S extends AuthEvent> = FutureOr<R> Function(S event);

sealed class AuthEvent {
  const AuthEvent();

  const factory AuthEvent.signInWithEmailAndPassword({
    required String email,
    required String password,
  }) = _SignInWithEmailAndPassword;

  const factory AuthEvent.signUp({
    required String email,
    required String displayName,
    required String photoURL,
    required String password,
    required String phoneNumber,
  }) = _SignUp;

  const factory AuthEvent.signInWithGoogle() = _SignInWithGoogle;

  const factory AuthEvent.signOut() = _SignOut;

  FutureOr<R> map<R>({
    // ignore: library_private_types_in_public_api
    required AuthEventMatch<R, _SignInWithEmailAndPassword>
    signInWithEmailAndPassword,
    // ignore: library_private_types_in_public_api
    required AuthEventMatch<R, _SignUp> signUp,
    // ignore: library_private_types_in_public_api
    required AuthEventMatch<R, _SignInWithGoogle> signInWithGoogle,
    // ignore: library_private_types_in_public_api
    required AuthEventMatch<R, _SignOut> signOut,
  }) => switch (this) {
    _SignInWithEmailAndPassword s => signInWithEmailAndPassword(s),
    _SignUp s => signUp(s),
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

final class _SignUp extends AuthEvent {
  const _SignUp({
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

final class _SignInWithGoogle extends AuthEvent {
  const _SignInWithGoogle();
}

final class _SignOut extends AuthEvent {
  const _SignOut();
}
