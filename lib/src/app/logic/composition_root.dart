import 'package:dorm_fix/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../../features/authentication/data/repository/auth_repository.dart';
import '../../features/authentication/state_management/auth_button/auth_button_bloc.dart';
import '../../features/authentication/state_management/authentication/authentication_bloc.dart';
import '../model/dependencies.dart';

abstract class Factory<T> {
  const Factory();

  T create();
}

abstract class AsyncFactory<T> {
  const AsyncFactory();

  Future<T> create();
}

class CompositionRoot {
  const CompositionRoot();

  Future<DependencyContainer> compose() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Firebase
    final firebaseAuth = await _CreateFirebaseAuth().create();

    // Authentication
    final repository = AuthRepository(firebaseAuth: firebaseAuth);
    final authenticationBloc = AuthBloc(repository: repository);
    final authButton = AuthButtonBloc();

    return _DependencyFactory(
      authenticationBloc: authenticationBloc,
      authButton: authButton,
    ).create();
  }
}

class _DependencyFactory extends Factory<DependencyContainer> {
  const _DependencyFactory({
    required this.authenticationBloc,
    required this.authButton,
  });

  final AuthBloc authenticationBloc;

  final AuthButtonBloc authButton;

  @override
  DependencyContainer create() => DependencyContainer(
    authenticationBloc: authenticationBloc,
    authButton: authButton,
  );
}

class _CreateFirebaseAuth extends AsyncFactory<FirebaseAuth> {
  const _CreateFirebaseAuth();

  @override
  Future<FirebaseAuth> create() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    return FirebaseAuth.instance;
  }
}
