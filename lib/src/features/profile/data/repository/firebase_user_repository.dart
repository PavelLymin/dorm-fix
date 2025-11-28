import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/firebase/firebase.dart';
import '../../../authentication/data/dto/user.dart';
import '../../helpers/phone_number_helper.dart';

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
        message: 'No user is currently signed in.',
      );
    }
    await user.reload();
  }

  @override
  Future<PhoneNumberHelper> verifyPhoneNumber({
    required String phoneNumber,
  }) async {
    Completer<PhoneNumberHelper> completer = Completer<PhoneNumberHelper>();
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (credential) => _verificationCompleted,
      verificationFailed: _verificationFailed,
      codeSent: (String verificationId, _) async => codeSent,
      codeAutoRetrievalTimeout: (String verificationId) =>
          _codeAutoRetrievalTimeout,
    );
    final result = await completer.future;
    return result;
  }

  void _verificationCompleted(
    PhoneAuthCredential credential,
    Completer completer,
  ) async {
    final userCredential = await _firebaseAuth.signInWithCredential(credential);
    final currentUser = userCredential.user;
    if (currentUser == null) throw AuthException(code: 'no-current-user');

    final user = UserDto.fromFirebase(currentUser).toEntity();
    completer.complete(PhoneNumberHelper.verificationCompleted(user: user));
  }

  void _verificationFailed(FirebaseAuthException error) =>
      AuthException(code: error.code);

  void codeSent(String verificationId, Completer completer) => completer
      .complete(PhoneNumberHelper.smsCodeSent(verificationId: verificationId));

  void _codeAutoRetrievalTimeout(String verificationId, Completer completer) =>
      completer.complete(PhoneNumberHelper.codeAutoRetrievalTimeout());

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
    if (user == null) throw AuthException(code: 'no-current-user');

    await user.updatePhoneNumber(phoneCredential);
    await user.reload();
  }
}
