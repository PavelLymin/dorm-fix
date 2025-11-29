import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../../app/model/application_config.dart';
import '../../../../app/widget/dependencies_scope.dart';
import '../../profile.dart';

class EmailAddressEdit extends StatefulWidget {
  const EmailAddressEdit({super.key, required this.initialText});

  final String initialText;

  @override
  State<EmailAddressEdit> createState() => _EmailAddressEditState();
}

class _EmailAddressEditState extends State<EmailAddressEdit>
    with _EmailAddressEditStateMixin {
  @override
  Widget build(BuildContext context) => Column(
    spacing: 64,
    crossAxisAlignment: .center,
    mainAxisAlignment: .center,
    children: [
      UiTextField.standard(
        controller: _controller,
        autofocus: false,
        keyboardType: .emailAddress,
        textInputAction: .done,
        style: UiTextFieldStyle(
          contentPadding: AppPadding.allMedium,
          hintText: 'name@mail.ru',
          prefixIcon: const Icon(Icons.email_outlined),
          suffixIcon: ValueListenableBuilder<TextEditingValue>(
            valueListenable: _controller,
            builder: (_, value, _) {
              if (value.text.isEmpty) return const SizedBox.shrink();
              return IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () => _controller.clear(),
              );
            },
          ),
        ),
      ),
      ValueListenableBuilder(
        valueListenable: _isEnabled,
        builder: (_, value, _) => SizedBox(
          height: 48,
          width: .infinity,
          child: UiButton.filledPrimary(
            onPressed: () {},
            enabled: value,
            label: UiText.titleMedium('Изменить'),
          ),
        ),
      ),
    ],
  );
}

mixin _EmailAddressEditStateMixin on State<EmailAddressEdit> {
  final ValueNotifier<bool> _isEnabled = ValueNotifier<bool>(false);
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialText);
    _controller.addListener(_isValidEmailAddress);
  }

  @override
  void dispose() {
    _controller.removeListener(_isValidEmailAddress);
    _isEnabled.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _isValidEmailAddress() {
    if (!_isEnabled.value &&
        Config.email.matchAsPrefix(_controller.text) != null) {
      _isEnabled.value = true;
    } else if (_isEnabled.value &&
        Config.email.matchAsPrefix(_controller.text) == null) {
      _isEnabled.value = false;
    }
  }
}

class PhoneNumberEdit extends StatefulWidget {
  const PhoneNumberEdit({super.key, required this.initialText});

  final String initialText;

  @override
  State<PhoneNumberEdit> createState() => _PhoneNumberEditState();
}

class _PhoneNumberEditState extends State<PhoneNumberEdit>
    with _PhoneNumberEditStateMixin {
  @override
  Widget build(BuildContext context) => BlocProvider.value(
    value: _phoneNumberBloc,
    child: Column(
      spacing: 64,
      crossAxisAlignment: .center,
      mainAxisAlignment: .center,
      children: [
        UiTextField.standard(
          controller: _controller,
          autofocus: false,
          keyboardType: .phone,
          textInputAction: .done,
          style: UiTextFieldStyle(
            hintText: '+71234567890',
            prefixIcon: Icon(Icons.phone_enabled_outlined),
            suffixIcon: ValueListenableBuilder<TextEditingValue>(
              valueListenable: _controller,
              builder: (_, value, _) {
                if (value.text.isEmpty) return const SizedBox.shrink();
                return IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () => _controller.clear(),
                );
              },
            ),
          ),
        ),
        ValueListenableBuilder(
          valueListenable: _isEnabled,
          builder: (_, value, _) => SizedBox(
            height: 48,
            width: .infinity,
            child: UiButton.filledPrimary(
              onPressed: () => _phoneNumberBloc.add(
                PhoneNumberEvent.verifyPhone(phoneNumber: _controller.text),
              ),
              enabled: value,
              label: BlocConsumer<PhoneNumberBloc, PhoneNumberState>(
                listener: (context, state) => state.mapOrNull(
                  smsCodeSent: (_) => context.router.replace(
                    const NamedRoute('UpdatePhonScreen'),
                  ),
                ),
                builder: (context, state) => state.maybeMap(
                  orElse: () => UiText.titleMedium('Изменить'),
                  loading: (_) => const SizedBox.square(
                    dimension: 20,
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

mixin _PhoneNumberEditStateMixin on State<PhoneNumberEdit> {
  final ValueNotifier<bool> _isEnabled = ValueNotifier<bool>(false);
  late PhoneNumberBloc _phoneNumberBloc;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final firebaseUserRepository = DependeciesScope.of(
      context,
    ).firebaseUserRepository;
    final userRepository = DependeciesScope.of(context).userRepository;
    final logger = DependeciesScope.of(context).logger;
    _phoneNumberBloc = PhoneNumberBloc(
      firebaseUserRepository: firebaseUserRepository,
      userRepository: userRepository,
      logger: logger,
    );
    _controller = TextEditingController(text: widget.initialText);
    _controller.addListener(_isValidPhoneNumber);
  }

  @override
  void dispose() {
    _phoneNumberBloc.close();
    _controller.removeListener(_isValidPhoneNumber);
    _isEnabled.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _isValidPhoneNumber() {
    if (!_isEnabled.value &&
        Config.phoneNumber.matchAsPrefix(_controller.text) != null) {
      _isEnabled.value = true;
    } else if (_isEnabled.value &&
        Config.phoneNumber.matchAsPrefix(_controller.text) == null) {
      _isEnabled.value = false;
    }
  }
}
