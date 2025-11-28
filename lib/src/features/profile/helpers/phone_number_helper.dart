import '../../authentication/model/user.dart';

sealed class PhoneNumberHelper {
  const PhoneNumberHelper({required this.user});

  const factory PhoneNumberHelper.smsCodeSent({
    required String verificationId,
  }) = CodeSent;

  const factory PhoneNumberHelper.codeAutoRetrievalTimeout() =
      CodeAutoRetrievalTimeout;

  const factory PhoneNumberHelper.verificationCompleted({
    required AuthenticatedUser user,
  }) = VerificationCompleted;

  final UserEntity user;

  T map<T>({
    required T Function(VerificationCompleted user) verificationCompleted,
    required T Function(String verificationId) smsCodeSent,
    required T Function(CodeAutoRetrievalTimeout user) codeAutoRetrievalTimeout,
  }) => switch (this) {
    final VerificationCompleted v => verificationCompleted(v),
    final CodeSent c => smsCodeSent(c.verificationId),
    final CodeAutoRetrievalTimeout c => codeAutoRetrievalTimeout(c),
  };

  T maybeMap<T>({
    required T Function() orElse,
    T Function(VerificationCompleted user)? verificationCompleted,
    T Function(String verificationId)? smsCodeSent,
    T Function(CodeAutoRetrievalTimeout user)? codeAutoRetrievalTimeout,
  }) => map(
    verificationCompleted: verificationCompleted ?? (_) => orElse(),
    smsCodeSent: smsCodeSent ?? (_) => orElse(),
    codeAutoRetrievalTimeout: codeAutoRetrievalTimeout ?? (_) => orElse(),
  );

  T? mapOrNull<T>({
    T Function(VerificationCompleted user)? verificationCompleted,
    T Function(String error)? verificationFailed,
    T Function(String verificationId)? smsCodeSent,
    T Function(CodeAutoRetrievalTimeout user)? codeAutoRetrievalTimeout,
  }) => map<T?>(
    verificationCompleted: verificationCompleted ?? (_) => null,
    smsCodeSent: smsCodeSent ?? (_) => null,
    codeAutoRetrievalTimeout: codeAutoRetrievalTimeout ?? (_) => null,
  );
}

final class VerificationCompleted extends PhoneNumberHelper {
  const VerificationCompleted({required super.user});
}

final class CodeSent extends PhoneNumberHelper {
  const CodeSent({
    super.user = const NotAuthenticatedUser(),
    required this.verificationId,
  });

  final String verificationId;
}

final class CodeAutoRetrievalTimeout extends PhoneNumberHelper {
  const CodeAutoRetrievalTimeout({super.user = const NotAuthenticatedUser()});
}
