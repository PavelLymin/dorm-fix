import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
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

class _PersonalDataScreenState extends State<PersonalDataScreen>
    with _PersonalDataScreenStateMixin {
  @override
  Widget build(BuildContext context) {
    final appPading = context.appStyle.appPadding;
    return Scaffold(
      appBar: AppBar(title: const Text('Личные данные')),
      body: SafeArea(
        child: Padding(
          padding: appPading.pagePadding,
          child: Column(
            mainAxisAlignment: .center,
            crossAxisAlignment: .stretch,
            mainAxisSize: .min,
            spacing: 16.0,
            children: [
              const SizedBox(height: 128.0),
              UiTextField.standard(
                controller: _nameController,
                keyboardType: .name,
                textInputAction: .next,
                enabled: _isNameEditable,
                style: UiTextFieldStyle(
                  contentPadding: appPading.allMedium,
                  hintText: 'Иван Иванов',
                  prefixIcon: const Icon(Icons.person),
                ),
              ),
              UiTextField.standard(
                controller: _emailController,
                keyboardType: .emailAddress,
                textInputAction: .next,
                enabled: _isEmailEditable,
                style: UiTextFieldStyle(
                  contentPadding: appPading.allMedium,
                  hintText: 'name@mail.ru',
                  prefixIcon: const Icon(Icons.email_outlined),
                ),
              ),
              UiTextField.standard(
                controller: _phoneController,
                keyboardType: .phone,
                textInputAction: .done,
                enabled: _isPhoneEditable,
                style: UiTextFieldStyle(
                  hintText: '+71234567890',
                  prefixIcon: Icon(Icons.phone_enabled_outlined),
                ),
              ),
              const SizedBox(height: 16.0),
              ValueListenableBuilder(
                valueListenable: _isEnabled,
                builder: (_, value, _) {
                  return UiButton.filledPrimary(
                    label: UiText.titleMedium('Продолжить'),
                    enabled: value,
                    onPressed: () {},
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

mixin _PersonalDataScreenStateMixin on State<PersonalDataScreen> {
  final ValueNotifier<bool> _isEnabled = ValueNotifier(false);

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
    _nameController.addListener(_checkValidation);
    _emailController.addListener(_checkValidation);
    _phoneController.addListener(_checkValidation);
    _initTextControllers();
    _checkValidation();
  }

  void _initTextControllers() {
    final user = context.read<AuthBloc>().state.currentUser;
    setState(() {
      user.mapOrNull(
        authenticated: (user) {
          _nameController.text = user.displayName ?? '';
          _emailController.text = user.email ?? '';
          _phoneController.text = user.phoneNumber ?? '';
        },
      );
    });
  }

  @override
  void dispose() {
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
}
