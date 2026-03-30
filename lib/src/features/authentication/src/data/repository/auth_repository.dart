import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../../core/ws/ws.dart';
import '../../../authentication.dart';

abstract interface class IAuthRepository {
  Future<void> connect();

  Future<FirebaseUser> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<FirebaseUser> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<({FirebaseUser user, bool isNewUser})> signInWithPhoneNumber({
    required String verificationId,
    required String smsCode,
  });

  Future<({FirebaseUser user, bool isNewUser})> signInWithGoogle();

  Future<void> signOut();
}

class AuthRepository implements IAuthRepository {
  AuthRepository({
    required this._firebaseAuth,
    required this._googleSignIn,
    required this._webSocket,
  });

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final IWebSocket _webSocket;

  @override
  Future<void> connect() async {
    try {
      final token = await _firebaseAuth.currentUser?.getIdToken();
      await _webSocket.connect({'Authorization': 'Bearer $token'});
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<FirebaseUser> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = userCredential.user;
    if (user == null) {
      throw FirebaseAuthException(
        code: 'no-current-user',
        message: 'Пользователь не найден',
      );
    }
    final authenticatedUser = FirebaseUserDto.fromFirebase(user).toEntity();
    return authenticatedUser;
  }

  @override
  Future<FirebaseUser> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = userCredential.user;
    if (user == null) {
      throw FirebaseAuthException(
        code: 'no-current-user',
        message: 'Пользователь не найден',
      );
    }

    final authenticatedUser = FirebaseUserDto.fromFirebase(user).toEntity();
    return authenticatedUser;
  }

  @override
  Future<({FirebaseUser user, bool isNewUser})> signInWithPhoneNumber({
    required String verificationId,
    required String smsCode,
  }) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    final userCredential = await _firebaseAuth.signInWithCredential(credential);

    final user = userCredential.user;
    final isNewUser = userCredential.additionalUserInfo?.isNewUser ?? false;
    if (user == null) {
      throw FirebaseAuthException(
        code: 'no-current-user',
        message: 'Пользователь не найден',
      );
    }

    final authenticatedUser = FirebaseUserDto.fromFirebase(user).toEntity();

    return (user: authenticatedUser, isNewUser: isNewUser);
  }

  @override
  Future<({FirebaseUser user, bool isNewUser})> signInWithGoogle() async {
    final googleUser = await _googleSignIn.authenticate();
    final googleAuth = googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );
    final userCredential = await _firebaseAuth.signInWithCredential(credential);

    final user = userCredential.user;
    final isNewUser = userCredential.additionalUserInfo?.isNewUser ?? false;
    if (user == null) {
      throw FirebaseAuthException(
        code: 'no-current-user',
        message: 'Пользователь не найден',
      );
    }

    final authenticatedUser = FirebaseUserDto.fromFirebase(user).toEntity();

    return (user: authenticatedUser, isNewUser: isNewUser);
  }

  @override
  Future<void> signOut() async => await _firebaseAuth.signOut();
}
