import 'dart:async';
import 'package:dorm_fix/src/core/firebase/firebase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repository/auth_repository.dart';
import '../../model/user.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> with SetStateMixin {
  AuthBloc({required IAuthRepository repository})
    : _repository = repository,
      super(const _NotAuthenticated(user: NotAuthenticatedUser())) {
    _streamSubscription = _repository.userChanges.listen(
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
        signInWithEmailAndPassword: (s) => _signIn(s, emit),
        signUpWithEmailAndPassword: (s) => _signUp(s, emit),
        verifyPhoneNumber: (s) => _verifyPhoneNumber(s, emit),
        signInWithPhoneNumber: (s) => _signInWithPhoneNumber(s, emit),
        signInWithGoogle: (_) => _signInWithGoogle(emit),
        signOut: (_) => _signOut(emit),
      );
    });
  }

  final IAuthRepository _repository;
  StreamSubscription? _streamSubscription;

  Future<void> _signIn(
    _SignInWithEmailAndPassword s,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthState.loading(user: state.currentUser));
      await _repository.signInWithEmailAndPassword(
        email: s.email,
        password: s.password,
      );
    } on AuthException catch (e) {
      emit(AuthState.error(user: state.currentUser, message: e.message));
    } catch (e, _) {
      emit(AuthState.error(user: state.currentUser, message: e.toString()));
    }
  }

  Future<void> _signUp(
    _SignUpWithEmailAndPassword s,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthState.loading(user: state.currentUser));
      await _repository.signUpWithEmailAndPassword(
        email: s.email,
        displayName: s.displayName,
        photoURL: s.photoURL,
        password: s.password,
      );
    } on AuthException catch (e) {
      emit(AuthState.error(user: state.currentUser, message: e.message));
    } catch (e) {
      emit(AuthState.error(user: state.currentUser, message: e.toString()));
    }
  }

  Future<void> _signInWithPhoneNumber(
    _SignInWithPhoneNumber s,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthState.loading(user: state.currentUser));
      await _repository.signInWithPhoneNumber(
        verificationId: s.verificationId,
        smsCode: s.smsCode,
      );
    } on AuthException catch (e) {
      emit(AuthState.error(user: state.currentUser, message: e.message));
    } catch (e) {
      emit(AuthState.error(user: state.currentUser, message: e.toString()));
    }
  }

  Future<void> _verifyPhoneNumber(
    _VerifyPhoneNumber s,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthState.loading(user: state.currentUser));
      final result = await _repository.verifyPhoneNumber(
        phoneNumber: s.phoneNumber,
      );

      result.maybeMap(
        orElse: () => null,
        smsCodeSent: (verificationId) =>
            emit(AuthState.smsCodeSent(verificationId: verificationId)),
      );
    } on AuthException catch (e) {
      emit(AuthState.error(user: state.currentUser, message: e.message));
    } catch (e) {
      emit(AuthState.error(user: state.currentUser, message: e.toString()));
    }
  }

  Future<void> _signInWithGoogle(Emitter<AuthState> emit) async {
    try {
      emit(AuthState.loading(user: state.currentUser));
      await _repository.signInWithGoogle();
    } catch (e) {
      emit(AuthState.error(user: state.currentUser, message: e.toString()));
    }
  }

  Future<void> _signOut(Emitter<AuthState> emit) async {
    try {
      emit(AuthState.loading(user: state.currentUser));
      await _repository.signOut();
    } catch (e) {
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
