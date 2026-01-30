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
       _userRepository = userRepository,
       _firebaseUserRepository = firebaseUserRepository,
       _logger = logger,
       super(const _NotAuthenticated(user: NotAuthenticatedUser())) {
    _streamSubscription = _authRepository.userChanges.listen(
      (data) {
        data.map(
          notAuthenticatedUser: (user) =>
              setState(_NotAuthenticated(user: user)),
          authenticatedUser: (user) async {
            setState(_LoggedIn(user: user));
            await _authRepository.connect();
          },
        );
      },
      onError: (e) =>
          setState(_Error(message: e.toString(), user: state.currentUser)),
    );

    on<AuthEvent>((event, emit) async {
      await event.map(
        logIn: (s) => _logInWithEmailAndPassword(s, emit),
        verifyPhoneNumber: (s) => _verifyPhoneNumber(s, emit),
        signInWithPhoneNumber: (s) => _signInWithPhoneNumber(s, emit),
        signInWithGoogle: (_) => _signInWithGoogle(emit),
        signOut: (_) => _signOut(emit),
      );
    });
  }

  final IAuthRepository _authRepository;
  final IUserRepository _userRepository;
  final IFirebaseUserRepository _firebaseUserRepository;
  final Logger _logger;
  StreamSubscription? _streamSubscription;

  Future<void> _logInWithEmailAndPassword(
    _LogIn s,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(.loading(user: state.currentUser));
      final existUser = await _userRepository.checkUserByEmail(email: s.email);
      existUser
          ? await _signInWithEmailAndPassword(s, emit)
          : await _signUpWithEmailAndPassword(s, emit);
    } on Object catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      emit(.error(user: state.currentUser, message: e));
    }
  }

  Future<void> _signInWithEmailAndPassword(
    _LogIn s,
    Emitter<AuthState> emit,
  ) async {
    final user = await _authRepository.signInWithEmailAndPassword(
      email: s.email,
      password: s.password,
    );
    emit(.loggedIn(user: user));
  }

  Future<void> _signUpWithEmailAndPassword(
    _LogIn s,
    Emitter<AuthState> emit,
  ) async {
    final user = await _authRepository.signUpWithEmailAndPassword(
      email: s.email,
      password: s.password,
    );
    emit(.signedUp(user: user));
  }

  Future<void> _signInWithPhoneNumber(
    _SignInWithPhoneNumber s,
    Emitter<AuthState> emit,
  ) async {
    emit(.loading(user: state.currentUser));
    await _logIn(
      logIn: () => _authRepository.signInWithPhoneNumber(
        verificationId: s.verificationId,
        smsCode: s.smsCode,
      ),
      emit: emit,
    );
  }

  Future<void> _verifyPhoneNumber(
    _VerifyPhoneNumber s,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(.loading(user: state.currentUser));
      final result = await _firebaseUserRepository.verifyPhoneNumber(
        phoneNumber: s.phoneNumber,
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
    emit(.loading(user: state.currentUser));
    await _logIn(logIn: () => _authRepository.signInWithGoogle(), emit: emit);
  }

  Future<void> _logIn({
    required Future<({AuthenticatedUser user, bool isNewUser})> Function()
    logIn,
    required Emitter<AuthState> emit,
  }) async {
    try {
      final data = await logIn();
      data.isNewUser
          ? emit(.signedUp(user: data.user))
          : emit(.loggedIn(user: data.user));
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
