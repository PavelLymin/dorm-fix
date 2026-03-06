import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import '../../../../profile/profile.dart';
import '../../../authentication.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> with SetStateMixin {
  AuthBloc({
    required IAuthRepository authRepository,
    required IUserRepository userRepository,
    required IFirebaseUserRepository firebaseUserRepository,
    required Logger logger,
  }) : _authRepository = authRepository,
       _firebaseUserRepository = firebaseUserRepository,
       _logger = logger,
       super(const _NotAuthenticated(user: NotAuthenticatedUser())) {
    _streamSubscription = _authRepository.userChanges.listen(
      (data) => data.map(
        notAuthenticatedUser: (user) => setState(_NotAuthenticated(user: user)),
        authenticatedUser: (user) async {
          setState(_LoggedIn(user: user));
          await _authRepository.connect();
        },
      ),
      onError: (e) =>
          setState(_Error(message: e.toString(), user: state.currentUser)),
    );
    on<AuthEvent>(
      (event, emit) async => await event.map(
        signInWithEmailAndPassword: (e) => _signInWithEmailAndPassword(e, emit),
        signUpWithEmailAndPassword: (e) => _signUpWithEmailAndPassword(e, emit),
        verifyPhoneNumber: (e) => _verifyPhoneNumber(e, emit),
        signInWithPhoneNumber: (e) => _signInWithPhoneNumber(e, emit),
        signInWithGoogle: (_) => _signInWithGoogle(emit),
        signOut: (_) => _signOut(emit),
      ),
    );
  }

  final IAuthRepository _authRepository;
  final IFirebaseUserRepository _firebaseUserRepository;
  final Logger _logger;
  StreamSubscription? _streamSubscription;

  Future<void> _signInWithEmailAndPassword(
    _SignInWithEmailAndPassword e,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(.loading(user: state.currentUser));
      final user = await _authRepository.signInWithEmailAndPassword(
        email: e.email,
        password: e.password,
      );
      emit(.loggedIn(user: user));
    } on Object catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      emit(.error(user: state.currentUser, message: e));
    }
  }

  Future<void> _signUpWithEmailAndPassword(
    _SignUpWithEmailAndPassword e,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(.loading(user: state.currentUser));
      final user = await _authRepository.signUpWithEmailAndPassword(
        email: e.email,
        password: e.password,
      );
      emit(.signedUp(user: user));
    } on Object catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      emit(.error(user: state.currentUser, message: e));
    }
  }

  Future<void> _signInWithPhoneNumber(
    _SignInWithPhoneNumber e,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(.loading(user: state.currentUser));
      final result = await _authRepository.signInWithPhoneNumber(
        verificationId: e.verificationId,
        smsCode: e.smsCode,
      );
      result.isNewUser
          ? emit(.signedUp(user: result.user))
          : emit(.loggedIn(user: result.user));
    } on Object catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      emit(.error(user: state.currentUser, message: e));
    }
  }

  Future<void> _verifyPhoneNumber(
    _VerifyPhoneNumber e,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(.loading(user: state.currentUser));
      final result = await _firebaseUserRepository.verifyPhoneNumber(
        phoneNumber: e.phoneNumber,
      );
      result.maybeMap(
        orElse: () => null,
        smsCodeSent: (verificationId) =>
            emit(.smsCodeSent(verificationId: verificationId)),
      );
    } on Object catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      emit(.error(user: state.currentUser, message: e));
    }
  }

  Future<void> _signInWithGoogle(Emitter<AuthState> emit) async {
    try {
      emit(.loading(user: state.currentUser));
      final result = await _authRepository.signInWithGoogle();
      result.isNewUser
          ? emit(.signedUp(user: result.user))
          : emit(.loggedIn(user: result.user));
    } on Object catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      emit(.error(user: state.currentUser, message: e));
    }
  }

  Future<void> _signOut(Emitter<AuthState> emit) async {
    try {
      emit(.loading(user: state.currentUser));
      await _authRepository.signOut();
    } on Object catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      emit(.error(user: state.currentUser, message: e));
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    _streamSubscription = null;
    return super.close();
  }
}

mixin SetStateMixin<State extends AuthState> implements Emittable<State> {
  void setState(State state) => emit(state);
}
