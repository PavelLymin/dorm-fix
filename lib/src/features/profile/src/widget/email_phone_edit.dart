import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../../app/model/application_config.dart';
import '../../../../app/widget/dependencies_scope.dart';
import '../../../authentication/authentication.dart';
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
    mainAxisSize: .min,
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

class _PhoneNumberEditState extends State<PhoneNumberEdit> {
  late TextEditingController _controller;
  late PhoneNumberBloc _phoneNumberBloc;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialText);
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
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => _phoneNumberBloc,
    child: Column(
      spacing: 64,
      crossAxisAlignment: .center,
      mainAxisAlignment: .center,
      mainAxisSize: .min,
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
        _ButtonPhoneUpdate(controller: _controller),
      ],
    ),
  );
}

class _ButtonPhoneUpdate extends StatefulWidget {
  const _ButtonPhoneUpdate({required this.controller});

  final TextEditingController controller;

  @override
  State<_ButtonPhoneUpdate> createState() => _ButtonPhoneUpdateState();
}

class _ButtonPhoneUpdateState extends State<_ButtonPhoneUpdate>
    with _PhoneNumberEditStateMixin {
  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
    valueListenable: _isEnabled,
    builder: (_, value, _) => SizedBox(
      height: 48,
      width: .infinity,
      child: UiButton.filledPrimary(
        enabled: value,
        onPressed: _verifyPhone,
        label: BlocConsumer<PhoneNumberBloc, PhoneNumberState>(
          listener: (context, state) => state.mapOrNull(
            smsCodeSent: (_) =>
                context.router.push(const NamedRoute('UpdatePhoneScreen')),
          ),
          builder: (context, state) => state.maybeMap(
            orElse: () => UiText.titleMedium('Изменить'),
            loading: (_) => SizedBox.square(
              dimension: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Theme.of(context).colorPalette.mutedForeground,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

mixin _PhoneNumberEditStateMixin on State<_ButtonPhoneUpdate> {
  final ValueNotifier<bool> _isEnabled = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_isValidPhoneNumber);
  }

  @override
  void dispose() {
    _isEnabled.dispose();
    super.dispose();
  }

  void _isValidPhoneNumber() {
    if (!_isEnabled.value &&
        PhoneNumberValidator.validatePhoneNumber(widget.controller.text)) {
      _isEnabled.value = true;
    } else if (_isEnabled.value &&
        !PhoneNumberValidator.validatePhoneNumber(widget.controller.text)) {
      _isEnabled.value = false;
    }
  }

  void _verifyPhone() => context.read<PhoneNumberBloc>().add(
    PhoneNumberEvent.verifyPhone(phoneNumber: widget.controller.text),
  );
}
