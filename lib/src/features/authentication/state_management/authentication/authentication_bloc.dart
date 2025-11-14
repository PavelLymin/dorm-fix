import 'dart:async';
import 'package:dorm_fix/src/core/firebase/firebase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import '../../../../core/rest_client/rest_client.dart';
import '../../data/repository/auth_repository.dart';
import '../../data/repository/user_repository.dart';
import '../../model/user.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> with SetStateMixin {
  AuthBloc({
    required IAuthRepository authRepository,
    required IUserRepository userRepository,
    required Logger logger,
  }) : _authRepository = authRepository,
       _userRepository = userRepository,
       _logger = logger,
       super(const _NotAuthenticated(user: NotAuthenticatedUser())) {
    _streamSubscription = _authRepository.userChanges.listen(
      (user) {
        user.map(
          notAuthenticatedUser: (notAuthenticatedUser) =>
              setState(_NotAuthenticated(user: notAuthenticatedUser)),
          authenticatedUser: (authenticatedUser) =>
              setState(_Authenticated(user: authenticatedUser)),
        );
      },
      onError: (e) =>
          setState(_Error(message: e.toString(), user: state.currentUser)),
    );

    on<AuthEvent>((event, emit) async {
      await event.map(
        logIn: (s) => _logIn(s, emit),
        verifyPhoneNumber: (s) => _verifyPhoneNumber(s, emit),
        signInWithPhoneNumber: (s) => _signInWithPhoneNumber(s, emit),
        signInWithGoogle: (_) => _signInWithGoogle(emit),
        signOut: (_) => _signOut(emit),
      );
    });
  }

  final IAuthRepository _authRepository;
  final IUserRepository _userRepository;
  final Logger _logger;
  StreamSubscription? _streamSubscription;

  Future<void> _logIn(_LogIn s, Emitter<AuthState> emit) async {
    try {
      emit(AuthState.loading(user: state.currentUser));
      final ecxistUser = await _userRepository.checkUserByEmail(email: s.email);

      if (!ecxistUser) {
        await Future.wait([
          _authRepository.signUpWithEmailAndPassword(
            email: s.email,
            password: s.password,
          ),
        ]);
      } else {
        await _authRepository.signInWithEmailAndPassword(
          email: s.email,
          password: s.password,
        );
      }
    } on RestClientException catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      emit(AuthState.error(user: state.currentUser, message: e.message));
    } on AuthException catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      emit(AuthState.error(user: state.currentUser, message: e.message));
    } on Object catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      emit(AuthState.error(user: state.currentUser, message: e.toString()));
    }
  }

  Future<void> _signInWithPhoneNumber(
    _SignInWithPhoneNumber s,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthState.loading(user: state.currentUser));
      await _authRepository.signInWithPhoneNumber(
        verificationId: s.verificationId,
        smsCode: s.smsCode,
      );
    } on AuthException catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      emit(AuthState.error(user: state.currentUser, message: e.message));
    } on Object catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      emit(AuthState.error(user: state.currentUser, message: e.toString()));
    }
  }

  Future<void> _verifyPhoneNumber(
    _VerifyPhoneNumber s,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthState.loading(user: state.currentUser));
      final result = await _authRepository.verifyPhoneNumber(
        phoneNumber: s.phoneNumber,
      );

      result.maybeMap(
        orElse: () => null,
        smsCodeSent: (verificationId) =>
            emit(AuthState.smsCodeSent(verificationId: verificationId)),
      );
    } on AuthException catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      emit(AuthState.error(user: state.currentUser, message: e.message));
    } on Object catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      emit(AuthState.error(user: state.currentUser, message: e.toString()));
    }
  }

  Future<void> _signInWithGoogle(Emitter<AuthState> emit) async {
    try {
      emit(AuthState.loading(user: state.currentUser));
      await _authRepository.signInWithGoogle();
    } on Object catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      emit(AuthState.error(user: state.currentUser, message: e.toString()));
    }
  }

  Future<void> _signOut(Emitter<AuthState> emit) async {
    try {
      emit(AuthState.loading(user: state.currentUser));
      await _authRepository.signOut();
    } on Object catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      emit(AuthState.error(user: state.currentUser, message: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}

mixin SetStateMixin<State extends AuthState> implements Emittable<State> {
  void setState(State state) => emit(state);
}
