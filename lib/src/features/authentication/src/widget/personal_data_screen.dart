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

class _PersonalDataScreenState extends State<PersonalDataScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initTextControllers();
  }

  void _initTextControllers() {
    final user = context.read<AuthBloc>().state.currentUser;
    user.map(
      notAuthenticated: (user) {},
      authenticated: (user) {
        _nameController.text = user.displayName ?? '';
        _emailController.text = user.email ?? '';
        _phoneNumberController.text = user.phoneNumber ?? '';
      },
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appPading = context.appStyle.appPadding;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: appPading.symmetricIncrement(horizontal: 3, vertical: 2),
          child: Column(
            crossAxisAlignment: .stretch,
            children: [
              UiText.headlineLarge(
                'Личные данные',
                style: TextStyle(color: Theme.of(context).colorPalette.primary),
              ),
              const SizedBox(height: 80),
              UiTextField.standard(
                controller: _nameController,
                keyboardType: .name,
                textInputAction: .next,
                style: UiTextFieldStyle(
                  contentPadding: appPading.allMedium,
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
                  contentPadding: appPading.allMedium,
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
              UiButton.filledPrimary(
                label: UiText.titleMedium('Продолжить'),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
