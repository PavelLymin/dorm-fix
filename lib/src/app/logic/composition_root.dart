import 'package:dorm_fix/firebase_options.dart';
import 'package:dorm_fix/src/app/model/application_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../../core/rest_client/src/http/rest_client_http.dart';
import '../../features/authentication/data/repository/auth_repository.dart';
import '../../features/authentication/state_management/auth_button/auth_button_bloc.dart';
import '../../features/authentication/state_management/authentication/authentication_bloc.dart';
import '../../features/home/data/repository/specialization_repository.dart';
import '../../features/home/state_management/bloc/specialization_bloc.dart';
import '../../shared/student/data/repository/student_repository.dart';
import '../../shared/student/state_management/bloc/student_bloc.dart';
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

    // Http
    final RestClientHttp client = RestClientHttp(
      baseUrl: Config.apiBaseUrl,
      client: createDefaultHttpClient(),
    );

    // Firebase
    final firebaseAuth = await _CreateFirebaseAuth().create();

    // Authentication
    final repository = AuthRepository(firebaseAuth: firebaseAuth);
    final authenticationBloc = AuthBloc(repository: repository);
    final authButton = AuthButtonBloc();

    // Student
    final studentRepository = StudentRepositoryImpl(client: client);
    final studentBloc = StudentBloc(studentRepository: studentRepository);

    // Specialization
    final specializationRepository = SpecializationRepositoryImpl(
      client: client,
    );
    final specializationBloc = SpecializationBloc(
      specializationRepository: specializationRepository,
    );

    return _DependencyFactory(
      client: client,
      authenticationBloc: authenticationBloc,
      authButton: authButton,
      studentBloc: studentBloc,
      specializationBloc: specializationBloc,
    ).create();
  }
}

class _DependencyFactory extends Factory<DependencyContainer> {
  const _DependencyFactory({
    required this.client,
    required this.authenticationBloc,
    required this.authButton,
    required this.studentBloc,
    required this.specializationBloc,
  });

  final RestClientHttp client;

  final AuthBloc authenticationBloc;

  final AuthButtonBloc authButton;

  final StudentBloc studentBloc;

  final SpecializationBloc specializationBloc;

  @override
  DependencyContainer create() => DependencyContainer(
    client: client,
    authenticationBloc: authenticationBloc,
    authButton: authButton,
    studentBloc: studentBloc,
    specializationBloc: specializationBloc,
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
