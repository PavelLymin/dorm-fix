import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../../core/firebase/firebase.dart';
import '../../../authentication.dart';

abstract interface class IAuthRepository {
  Stream<UserEntity> get userChanges;

  Future<AuthenticatedUser> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<AuthenticatedUser> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<({AuthenticatedUser user, bool isNewUser})> signInWithPhoneNumber({
    required String verificationId,
    required String smsCode,
  });

  Future<({AuthenticatedUser user, bool isNewUser})> signInWithGoogle();

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
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user == null) throw AuthException(code: 'no-current-user');

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
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user == null) throw AuthException(code: 'no-current-user');

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
  Future<({AuthenticatedUser user, bool isNewUser})> signInWithPhoneNumber({
    required String verificationId,
    required String smsCode,
  }) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      final userCredential = await _firebaseAuth.signInWithCredential(
        credential,
      );

      final user = userCredential.user;
      final isNewUser = userCredential.additionalUserInfo?.isNewUser ?? false;
      if (user == null) throw AuthException(code: 'no-current-user');

      final authenticatedUser = UserDto.fromFirebase(user).toEntity();

      return (user: authenticatedUser, isNewUser: isNewUser);
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
  Future<({AuthenticatedUser user, bool isNewUser})> signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn.instance.authenticate();
      final googleAuth = googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );
      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      final user = userCredential.user;
      final isNewUser = userCredential.additionalUserInfo?.isNewUser ?? false;
      if (user == null) throw AuthException(code: 'no-current-user');

      final authenticatedUser = UserDto.fromFirebase(user).toEntity();

      return (user: authenticatedUser, isNewUser: isNewUser);
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
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
