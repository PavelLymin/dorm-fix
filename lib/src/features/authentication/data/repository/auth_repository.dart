import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../core/firebase/firebase.dart';
import '../../model/user.dart';
import '../dto/user.dart';

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
