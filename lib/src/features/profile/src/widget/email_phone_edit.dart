import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../../../l10n/gen/app_localizations.dart';
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
  Widget build(BuildContext context) => Padding(
    padding: .only(bottom: MediaQuery.viewInsetsOf(context).bottom),
    child: Column(
      mainAxisAlignment: .center,
      crossAxisAlignment: .stretch,
      mainAxisSize: .min,
      children: [
        UiText2.lBold('Укажите почту'),
        const SizedBox(height: 10.0),
        UiTextField.standard(
          controller: _controller,
          autofocus: false,
          keyboardType: .emailAddress,
          textInputAction: .done,
          style: UiTextFieldStyle(
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
        const SizedBox(height: 20.0),
        ValueListenableBuilder(
          valueListenable: _isEnabled,
          builder: (_, value, _) => UiButton.filledPrimary(
            onPressed: () {},
            enabled: value,
            label: Text(AppLocalizations.of(context).update),
          ),
        ),
      ],
    ),
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
  const PhoneNumberEdit({super.key, required this.user});

  final FirebaseUser user;

  @override
  State<PhoneNumberEdit> createState() => _PhoneNumberEditState();
}

class _PhoneNumberEditState extends State<PhoneNumberEdit> {
  late TextEditingController _controller;
  late PhoneNumberBloc _phoneNumberBloc;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.user.phoneNumber);
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
  void dispose() {
    _phoneNumberBloc.close();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => _phoneNumberBloc,
    child: Padding(
      padding: .only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Column(
        mainAxisAlignment: .center,
        crossAxisAlignment: .stretch,
        mainAxisSize: .min,
        children: [
          UiText2.lBold('Укажите номер телефона'),
          const SizedBox(height: 10.0),
          UiTextField.standard(
            controller: _controller,
            autofocus: false,
            keyboardType: .phone,
            textInputAction: .done,
            style: UiTextFieldStyle(
              hintText: '+71234567890',
              prefixIcon: Icon(UiIcons.phone),
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
          const SizedBox(height: 20.0),
          _ButtonPhoneUpdate(controller: _controller, user: widget.user),
        ],
      ),
    ),
  );
}

class _ButtonPhoneUpdate extends StatefulWidget {
  const _ButtonPhoneUpdate({required this.controller, required this.user});

  final TextEditingController controller;
  final AuthenticatedUser user;

  @override
  State<_ButtonPhoneUpdate> createState() => _ButtonPhoneUpdateState();
}

class _ButtonPhoneUpdateState extends State<_ButtonPhoneUpdate>
    with _PhoneNumberEditStateMixin {
  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
    valueListenable: _isEnabled,
    builder: (_, value, _) => UiButton.filledPrimary(
      enabled: value,
      onPressed: _verifyPhone,
      label: BlocConsumer<PhoneNumberBloc, PhoneNumberState>(
        listener: (context, state) => state.mapOrNull(
          smsCodeSent: (_) => context.router.push(
            NamedRoute('UpdatePhoneScreen', params: {'user': widget.user}),
          ),
        ),
        builder: (context, state) => state.maybeMap(
          orElse: () => Text(AppLocalizations.of(context).update),
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
  );
}

mixin _PhoneNumberEditStateMixin on State<_ButtonPhoneUpdate> {
  final _phoneValidator = PhoneValidator();
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

  void _isValidPhoneNumber() => _phoneValidator.onPhoneChanged(
    widget.controller.text,
    onValid: (_) => _isEnabled.value = true,
    onInvalid: (_) => _isEnabled.value = false,
  );

  void _verifyPhone() => context.read<PhoneNumberBloc>().add(
    PhoneNumberEvent.verifyPhone(phoneNumber: widget.controller.text),
  );
}
