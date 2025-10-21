part of 'authentication_bloc.dart';

typedef AuthenticationEventMatch<R, S extends AuthenticationEvent> =
    FutureOr<R> Function(S event);

sealed class AuthenticationEvent {
  const AuthenticationEvent();

  const factory AuthenticationEvent.signInWithEmailAndPassword({
    required String email,
    required String password,
  }) = _SignInWithEmailAndPassword;

  const factory AuthenticationEvent.signUp({
    required String email,
    required String displayName,
    required String photoURL,
    required String password,
    required String phoneNumber,
  }) = _SignUp;

  const factory AuthenticationEvent.signInWithGoogle() = _SignInWithGoogle;

  const factory AuthenticationEvent.signOut() = _SignOut;

  FutureOr<R> map<R>({
    // ignore: library_private_types_in_public_api
    required AuthenticationEventMatch<R, _SignInWithEmailAndPassword>
    signInWithEmailAndPassword,
    // ignore: library_private_types_in_public_api
    required AuthenticationEventMatch<R, _SignUp> signUp,
    // ignore: library_private_types_in_public_api
    required AuthenticationEventMatch<R, _SignInWithGoogle> signInWithGoogle,
    // ignore: library_private_types_in_public_api
    required AuthenticationEventMatch<R, _SignOut> signOut,
  }) => switch (this) {
    _SignInWithEmailAndPassword s => signInWithEmailAndPassword(s),
    _SignUp s => signUp(s),
    _SignInWithGoogle s => signInWithGoogle(s),
    _SignOut s => signOut(s),
  };
}

final class _SignInWithEmailAndPassword extends AuthenticationEvent {
  const _SignInWithEmailAndPassword({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}

final class _SignUp extends AuthenticationEvent {
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

final class _SignInWithGoogle extends AuthenticationEvent {
  const _SignInWithGoogle();
}

final class _SignOut extends AuthenticationEvent {
  const _SignOut();
}
