import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../core/firebase/firebase.dart';
import '../../model/user.dart';
import '../dto/user.dart';

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

abstract interface class IAuthRepository {
  Stream<UserEntity> get userChanges;

  Future<AuthenticatedUser> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<AuthenticatedUser> signUpWithEmailAndPassword({
    required String email,
    required String displayName,
    required String photoURL,
    required String password,
  });

  Future<PhoneNumberHelper> verifyPhoneNumber({required String phoneNumber});

  Future<AuthenticatedUser> signInWithPhoneNumber({
    required String verificationId,
    required String smsCode,
  });

  Future<AuthenticatedUser> signInWithGoogle();

  Future<void> updatePhoneNumber({
    required String verificationId,
    required String smsCode,
  });

  Future<void> updateEmail({required String email});

  Future<void> signOut();
}

class AuthRepository implements IAuthRepository {
  AuthRepository({required FirebaseAuth firebaseAuth})
    : _firebaseAuth = firebaseAuth;

  final FirebaseAuth _firebaseAuth;

  @override
  Stream<UserEntity> get userChanges => _firebaseAuth.userChanges().map((data) {
    if (data != null) {
      return UserDto.fromFirebase(data).toEntity();
    } else {
      return const NotAuthenticatedUser();
    }
  });

  @override
  Future<AuthenticatedUser> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final data = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = data.user;
      if (user == null) throw AuthException(code: 'user-null');

      await user.sendEmailVerification();

      final authenticatedUser = UserDto.fromFirebase(user).toEntity();

      return authenticatedUser;
    } on AuthException catch (e, stackTrace) {
      Error.throwWithStackTrace(e.message, stackTrace);
    } on FirebaseAuthException catch (e, stackTrace) {
      Error.throwWithStackTrace(
        AuthException(code: e.code).message,
        stackTrace,
      );
    }
  }

  @override
  Future<AuthenticatedUser> signUpWithEmailAndPassword({
    required String email,
    required String displayName,
    required String photoURL,
    required String password,
  }) async {
    try {
      final data = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((result) {
            result.user?.updateDisplayName(displayName);
            result.user?.updatePhotoURL(photoURL);
          })
          .catchError((error) {});

      final user = data.user;
      if (user == null) throw AuthException(code: 'user-null');

      final authenticatedUser = UserDto.fromFirebase(user).toEntity();

      return authenticatedUser;
    } on AuthException catch (e, stackTrace) {
      Error.throwWithStackTrace(e.message, stackTrace);
    } on FirebaseAuthException catch (e, stackTrace) {
      Error.throwWithStackTrace(
        AuthException(code: e.code).message,
        stackTrace,
      );
    }
  }

  @override
  Future<PhoneNumberHelper> verifyPhoneNumber({
    required String phoneNumber,
  }) async {
    Completer<PhoneNumberHelper> completer = Completer<PhoneNumberHelper>();

    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        final userCredential = await _firebaseAuth.signInWithCredential(
          credential,
        );
        final authenticatedUser = UserDto.fromFirebase(
          userCredential.user!,
        ).toEntity();
        completer.complete(
          PhoneNumberHelper.verificationCompleted(user: authenticatedUser),
        );
      },
      verificationFailed: (error) =>
          completer.complete(throw AuthException(code: error.code)),

      codeSent: (String verificationId, int? resendToken) async =>
          completer.complete(
            PhoneNumberHelper.smsCodeSent(verificationId: verificationId),
          ),
      codeAutoRetrievalTimeout: (String verificationId) {
        completer.complete(PhoneNumberHelper.codeAutoRetrievalTimeout());
      },
    );

    final result = await completer.future;

    return result;
  }

  @override
  Future<AuthenticatedUser> signInWithPhoneNumber({
    required String verificationId,
    required String smsCode,
  }) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    final userCredential = await _firebaseAuth.signInWithCredential(credential);

    final authenticatedUser = UserDto.fromFirebase(
      userCredential.user!,
    ).toEntity();

    return authenticatedUser;
  }

  @override
  Future<AuthenticatedUser> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn.instance
          .authenticate();
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );
      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      if (userCredential.user == null) throw AuthException(code: 'user-null');

      final authenticatedUser = UserDto.fromFirebase(
        userCredential.user!,
      ).toEntity();

      return authenticatedUser;
    } on AuthException catch (e, stackTrace) {
      Error.throwWithStackTrace(e.message, stackTrace);
    } on FirebaseAuthException catch (e, stackTrace) {
      Error.throwWithStackTrace(
        AuthException(code: e.code).message,
        stackTrace,
      );
    }
  }

  @override
  Future<void> updatePhoneNumber({
    required String verificationId,
    required String smsCode,
  }) async {
    final phoneCredential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    await _firebaseAuth.currentUser?.updatePhoneNumber(phoneCredential);
  }

  @override
  Future<void> updateEmail({required email}) async {
    await _firebaseAuth.currentUser?.verifyBeforeUpdateEmail(email);
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
