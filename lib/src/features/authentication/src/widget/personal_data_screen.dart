import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../../app/widget/dependencies_scope.dart';
import '../../../profile/profile.dart';
import '../../authentication.dart';

class PersonalDataScreen extends StatefulWidget {
  const PersonalDataScreen({
    super.key,
    required this.dormitoryId,
    required this.roomId,
  });

  final int dormitoryId;
  final int roomId;

  @override
  State<PersonalDataScreen> createState() => _PersonalDataScreenState();
}

class _PersonalDataScreenState extends State<PersonalDataScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  late final StudentBloc _studentBloc;

  @override
  void initState() {
    super.initState();
    _initTextControllers();
    _initStudentBloc();
  }

  void _initTextControllers() {
    final user = context.read<AuthBloc>().state.currentUser;
    user.map(
      notAuthenticatedUser: (_) {},
      authenticatedUser: (user) {
        _nameController.text = user.displayName ?? '';
        _emailController.text = user.email ?? '';
        _phoneNumberController.text = user.phoneNumber ?? '';
      },
    );
  }

  void _initStudentBloc() {
    final dependency = DependeciesScope.of(context);
    _studentBloc = StudentBloc(
      logger: dependency.logger,
      studentRepository: dependency.studentRepository,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  AuthenticatedUser _addPersonalData() {
    final user = context.read<AuthBloc>().state.authenticatedOrNull!;
    return user.copyWith(
      displayName: _nameController.text,
      email: _emailController.text,
      phoneNumber: _phoneNumberController.text,
    );
  }

  void _submitForm() {
    final user = _addPersonalData();
    _studentBloc.add(
      .create(
        student: CreatedStudentEntity(
          user: user,
          dormitoryId: widget.dormitoryId,
          roomId: widget.roomId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _studentBloc,
      child: BlocListener<StudentBloc, StudentState>(
        listener: (context, state) {
          state.mapOrNull(
            created: (_) => context.router.replace(NamedRoute('Home')),
          );
        },
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: AppPadding.symmetricIncrement(
                horizontal: 3,
                vertical: 2,
              ),
              child: Column(
                crossAxisAlignment: .stretch,
                children: [
                  UiText.headlineLarge(
                    'Личные данные',
                    style: TextStyle(
                      color: Theme.of(context).colorPalette.primary,
                    ),
                  ),
                  const SizedBox(height: 80),
                  UiTextField.standard(
                    controller: _nameController,
                    keyboardType: .name,
                    textInputAction: .next,
                    style: UiTextFieldStyle(
                      contentPadding: AppPadding.allMedium,
                      hintText: 'Иван Иванов',
                      prefixIcon: const Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(height: 16),
                  UiTextField.standard(
                    controller: _emailController,
                    keyboardType: .emailAddress,
                    textInputAction: .next,
                    style: UiTextFieldStyle(
                      contentPadding: AppPadding.allMedium,
                      hintText: 'name@mail.ru',
                      prefixIcon: const Icon(Icons.email_outlined),
                    ),
                  ),
                  const SizedBox(height: 16),
                  UiTextField.standard(
                    controller: _phoneNumberController,
                    keyboardType: .phone,
                    textInputAction: .done,
                    style: UiTextFieldStyle(
                      hintText: '+71234567890',
                      prefixIcon: Icon(Icons.phone_enabled_outlined),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 48,
                    child: UiButton.filledPrimary(
                      label: UiText.titleMedium('Продолжить'),
                      onPressed: _submitForm,
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
