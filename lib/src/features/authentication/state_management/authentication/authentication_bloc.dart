import 'dart:async';
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
        signUp: (s) => _signUp(s, emit),
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
    } catch (e, _) {
      emit(AuthState.error(user: state.currentUser, message: e.toString()));
    }
  }

  Future<void> _signUp(_SignUp s, Emitter<AuthState> emit) async {
    try {
      emit(AuthState.loading(user: state.currentUser));
      await _repository.signUpWithEmailAndPassword(
        email: s.email,
        displayName: s.displayName,
        photoURL: s.photoURL,
        password: s.password,
      );
    } catch (_) {
      emit(
        AuthState.error(user: state.currentUser, message: 'Прозошла ошибка'),
      );
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
    } catch (_) {
      emit(
        AuthState.error(user: state.currentUser, message: 'Прозошла ошибка'),
      );
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
