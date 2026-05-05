import 'package:dorm_fix/l10n/gen/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../../app/widget/dependencies_scope.dart';
import '../../../profile/src/widget/name_photo_edit.dart';
import '../../../students/student.dart';
import '../../authentication.dart';

class ExtraDataScreen extends StatefulWidget {
  const ExtraDataScreen({
    super.key,
    required this.dormitoryId,
    required this.roomId,
  });

  final int dormitoryId;
  final int roomId;

  @override
  State<ExtraDataScreen> createState() => _ExtraDataScreenState();
}

class _ExtraDataScreenState extends State<ExtraDataScreen>
    with _PersonalDataScreenStateMixin {
  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    return BlocProvider<StudentBloc>.value(
      value: _studentBloc,
      child: Scaffold(
        appBar: AppBar(title: Text(local.your_data)),
        body: SafeArea(
          child: Padding(
            padding: AppInsets.screen,
            child: Column(
              mainAxisAlignment: .center,
              crossAxisAlignment: .start,
              mainAxisSize: .min,
              children: [
                Padding(
                  padding: const .only(top: 24.0, bottom: 10.0),
                  child: UiText2.lBold(local.add_photo),
                ),
                Align(
                  alignment: .center,
                  child: UserAvatar(user: _user, photoURL: _photoURL),
                ),
                Padding(
                  padding: const .only(top: 24.0, bottom: 10.0),
                  child: UiText2.lBold(local.specify_name),
                ),
                UiTextField.standard(
                  controller: _nameController,
                  keyboardType: .name,
                  textInputAction: .next,
                  enabled: _isNameEditable,
                  style: UiTextFieldStyle(hintText: 'Иван Иванов'),
                ),
                Padding(
                  padding: const .only(top: 24.0, bottom: 10.0),
                  child: UiText2.lBold(local.specify_mail),
                ),
                UiTextField.standard(
                  controller: _emailController,
                  keyboardType: .emailAddress,
                  textInputAction: .next,
                  enabled: _isEmailEditable,
                  style: UiTextFieldStyle(hintText: 'name@mail.ru'),
                ),
                Padding(
                  padding: const .only(top: 24.0, bottom: 10.0),
                  child: UiText2.lBold(local.specify_number),
                ),
                UiTextField.standard(
                  controller: _phoneController,
                  keyboardType: .phone,
                  textInputAction: .done,
                  enabled: _isPhoneEditable,
                  style: UiTextFieldStyle(hintText: '+900 000 00-00'),
                ),
                const SizedBox(height: 32.0),
                ValueListenableBuilder(
                  valueListenable: _isEnabled,
                  builder: (_, value, _) {
                    return SizedBox(
                      width: .infinity,
                      child: UiButton.filledPrimary(
                        label: BlocBuilder<StudentBloc, StudentState>(
                          builder: (context, state) {
                            return state.maybeMap(
                              orElse: () => Text(local.continue_btn),
                              loading: (_) => const CircularProgressIndicator(),
                            );
                          },
                        ),
                        enabled: value,
                        onPressed: _onCreateStudent,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

mixin _PersonalDataScreenStateMixin on State<ExtraDataScreen> {
  late final StudentBloc _studentBloc;
  late final FirebaseUser _user;
  final ValueNotifier<bool> _isEnabled = ValueNotifier(false);
  final ValueNotifier<String?> _photoURL = ValueNotifier(null);

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  final _nameValidator = NameValidator();
  final _emailValidator = EmailValidator();
  final _phoneValidator = PhoneValidator();

  bool get _isNameEditable => _nameController.text.isEmpty;
  bool get _isEmailEditable => _emailController.text.isEmpty;
  bool get _isPhoneEditable => _phoneController.text.isEmpty;

  @override
  void initState() {
    super.initState();
    _user = context.read<AuthBloc>().state.authenticatedOrNull!.mapAuthUser(
      firebase: (f) => f,
      profile: (p) => p.user,
    );
    final dependency = DependeciesScope.of(context);
    _studentBloc = StudentBloc(
      repository: dependency.studentRepository,
      logger: dependency.logger,
    );
    _initTextControllers();
    _nameController.addListener(_checkValidation);
    _emailController.addListener(_checkValidation);
    _phoneController.addListener(_checkValidation);
    _checkValidation();
  }

  void _initTextControllers() {
    _user.mapOrNull(
      authenticated: (user) {
        _nameController.text = user.displayName ?? '';
        _emailController.text = user.email ?? '';
        _phoneController.text = user.phoneNumber ?? '';
      },
    );
  }

  @override
  void dispose() {
    _studentBloc.close();
    _nameController.removeListener(_checkValidation);
    _emailController.removeListener(_checkValidation);
    _phoneController.removeListener(_checkValidation);
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _checkValidation() {
    _isEnabled.value =
        _nameValidator.validate(_nameController.text) &&
        _emailValidator.validate(_emailController.text) &&
        _phoneValidator.validate(_phoneController.text);
  }

  void _onCreateStudent() {
    final user = _user.copyWith(
      displayName: _nameController.text,
      email: _emailController.text,
      phoneNumber: _phoneController.text,
    );
    _studentBloc.add(
      .add(
        student: PartialStudent(
          user: user,
          dormitoryId: widget.dormitoryId,
          roomId: widget.roomId,
        ),
      ),
    );
  }
}
