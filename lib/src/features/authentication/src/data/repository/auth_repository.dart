import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../../core/ws/ws.dart';
import '../../../authentication.dart';

abstract interface class IAuthRepository {
  Stream<UserEntity> get userChanges;

  Future<void> connect();

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
  AuthRepository({
    required FirebaseAuth firebaseAuth,
    required GoogleSignIn googleSignIn,
    required IWebSocket webSocket,
  }) : _firebaseAuth = firebaseAuth,
       _googleSignIn = googleSignIn,
       _webSocket = webSocket;

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final IWebSocket _webSocket;

  @override
  Stream<UserEntity> get userChanges => _firebaseAuth.userChanges().map((data) {
    if (data != null) {
      return UserDto.fromFirebase(data).toEntity();
    } else {
      return const NotAuthenticatedUser();
    }
  });

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
  Future<AuthenticatedUser> signInWithEmailAndPassword({
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
    final authenticatedUser = UserDto.fromFirebase(user).toEntity();
    return authenticatedUser;
  }

  @override
  Future<AuthenticatedUser> signUpWithEmailAndPassword({
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

    final authenticatedUser = UserDto.fromFirebase(user).toEntity();
    return authenticatedUser;
  }

  @override
  Future<({AuthenticatedUser user, bool isNewUser})> signInWithPhoneNumber({
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

    final authenticatedUser = UserDto.fromFirebase(user).toEntity();

    return (user: authenticatedUser, isNewUser: isNewUser);
  }

  @override
  Future<({AuthenticatedUser user, bool isNewUser})> signInWithGoogle() async {
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

    final authenticatedUser = UserDto.fromFirebase(user).toEntity();

    return (user: authenticatedUser, isNewUser: isNewUser);
  }

  @override
  Future<void> signOut() async => await _firebaseAuth.signOut();
}
