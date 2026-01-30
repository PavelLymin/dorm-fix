import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import '../../../../authentication/authentication.dart';
import '../../../profile.dart';

abstract interface class IFirebaseUserRepository {
  Future<void> updateEmail({required String email});

  Future<PhoneNumberHelper> verifyPhoneNumber({required String phoneNumber});

  Future<void> updatePhoneNumber({
    required String verificationId,
    required String smsCode,
  });
}

class FirebaseUserRepositoryImpl implements IFirebaseUserRepository {
  FirebaseUserRepositoryImpl({required FirebaseAuth firebaseAuth})
    : _firebaseAuth = firebaseAuth;

  final FirebaseAuth _firebaseAuth;

  @override
  Future<void> updateEmail({required String email}) async {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      throw FirebaseAuthException(
        code: 'no-current-user',
        message: 'Пользователь не найден',
      );
    }

    await user.reload();
  }

  @override
  Future<PhoneNumberHelper> verifyPhoneNumber({
    required String phoneNumber,
  }) async {
    final Completer<PhoneNumberHelper> completer = Completer();
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (credential) =>
          _verificationCompleted(credential, completer),
      verificationFailed: (e) => _verificationFailed(e),
      codeSent: (String verificationId, _) async =>
          codeSent(verificationId, completer),
      codeAutoRetrievalTimeout: (String verificationId) =>
          _codeAutoRetrievalTimeout(verificationId, completer),
    );
    final result = await completer.future;
    return result;
  }

  Future<void> _verificationCompleted(
    PhoneAuthCredential credential,
    Completer<PhoneNumberHelper> completer,
  ) async {
    final userCredential = await _firebaseAuth.signInWithCredential(credential);
    final currentUser = userCredential.user;
    if (currentUser == null) {
      throw FirebaseAuthException(
        code: 'no-current-user',
        message: 'Пользователь не найден',
      );
    }

    final user = UserDto.fromFirebase(currentUser).toEntity();
    completer.complete(.verificationCompleted(user: user));
  }

  void _verificationFailed(FirebaseAuthException error) =>
      Error.throwWithStackTrace(error, .current);

  void codeSent(
    String verificationId,
    Completer<PhoneNumberHelper> completer,
  ) => completer.complete(.smsCodeSent(verificationId: verificationId));

  void _codeAutoRetrievalTimeout(
    String verificationId,
    Completer<PhoneNumberHelper> completer,
  ) => completer.complete(.codeAutoRetrievalTimeout());

  @override
  Future<void> updatePhoneNumber({
    required String verificationId,
    required String smsCode,
  }) async {
    final phoneCredential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    final user = _firebaseAuth.currentUser;
    if (user == null) {
      throw FirebaseAuthException(
        code: 'no-current-user',
        message: 'Пользователь не найден',
      );
    }

    await user.updatePhoneNumber(phoneCredential);
    await user.reload();
  }
}
