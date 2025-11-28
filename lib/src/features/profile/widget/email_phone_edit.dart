import 'package:dorm_fix/src/app/model/application_config.dart';
import 'package:ui_kit/ui.dart';

class EmailAddressEdit extends StatefulWidget {
  const EmailAddressEdit({super.key, required this.initialText});

  final String initialText;

  @override
  State<EmailAddressEdit> createState() => _EmailAddressEditState();
}

class _EmailAddressEditState extends State<EmailAddressEdit>
    with _TextFieldStateMixin {
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialText);
    _controller.addListener(_isValidEmailAddress);
  }

  @override
  void dispose() {
    _controller.removeListener(_isValidEmailAddress);
    _controller.dispose();
    super.dispose();
  }

  void _isValidEmailAddress() {
    _onClearText(_controller.text);
    if (!_isEnabled.value &&
        Config.email.matchAsPrefix(_controller.text) != null) {
      _isEnabled.value = true;
    } else if (_isEnabled.value &&
        Config.email.matchAsPrefix(_controller.text) == null) {
      _isEnabled.value = false;
    }
  }

  @override
  Widget build(BuildContext context) => Column(
    spacing: 64,
    crossAxisAlignment: .center,
    mainAxisAlignment: .center,
    children: [
      UiTextField.standard(
        controller: _controller,
        autofocus: true,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.done,
        style: UiTextFieldStyle(
          contentPadding: AppPadding.allMedium,
          hintText: 'name@mail.ru',
          prefixIcon: const Icon(Icons.email_outlined),
          suffixIcon: _controller.text.isEmpty
              ? null
              : IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () => setState(() => _controller.clear()),
                ),
        ),
      ),
      ValueListenableBuilder(
        valueListenable: _isEnabled,
        builder: (_, value, _) {
          return SizedBox(
            height: 48,
            width: double.infinity,
            child: UiButton.filledPrimary(
              onPressed: () {},
              enabled: value,
              label: UiText.titleMedium('Изменить'),
            ),
          );
        },
      ),
    ],
  );
}

class PhoneNumberEdit extends StatefulWidget {
  const PhoneNumberEdit({super.key, required this.initialText});

  final String initialText;

  @override
  State<PhoneNumberEdit> createState() => _PhoneNumberEditState();
}

class _PhoneNumberEditState extends State<PhoneNumberEdit>
    with _TextFieldStateMixin {
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialText);
    _controller.addListener(_isValidPhoneNumber);
  }

  @override
  void dispose() {
    _controller.removeListener(_isValidPhoneNumber);
    _controller.dispose();
    super.dispose();
  }

  void _isValidPhoneNumber() {
    _onClearText(_controller.text);
    if (!_isEnabled.value &&
        Config.phoneNumber.matchAsPrefix(_controller.text) != null) {
      _isEnabled.value = true;
    } else if (_isEnabled.value &&
        Config.phoneNumber.matchAsPrefix(_controller.text) == null) {
      _isEnabled.value = false;
    }
  }

  @override
  Widget build(BuildContext context) => Column(
    spacing: 64,
    crossAxisAlignment: .center,
    mainAxisAlignment: .center,
    children: [
      UiTextField.standard(
        controller: _controller,
        autofocus: true,
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.done,
        style: UiTextFieldStyle(
          hintText: '+71234567890',
          prefixIcon: Icon(Icons.phone_enabled_outlined),
          suffixIcon: _controller.text.isEmpty
              ? null
              : IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () => setState(() => _controller.clear()),
                ),
        ),
      ),
      ValueListenableBuilder(
        valueListenable: _isEnabled,
        builder: (_, value, _) {
          return SizedBox(
            height: 48,
            width: double.infinity,
            child: UiButton.filledPrimary(
              onPressed: () {},
              enabled: value,
              label: UiText.titleMedium('Изменить'),
            ),
          );
        },
      ),
    ],
  );
}

mixin _TextFieldStateMixin<T extends StatefulWidget> on State<T> {
  bool _clearText = false;
  final ValueNotifier<bool> _isEnabled = ValueNotifier<bool>(false);
  late TextEditingController _controller;

  @override
  void dispose() {
    _controller.dispose();
    _isEnabled.dispose();
    super.dispose();
  }

  void _onClearText(String text) {
    if (text.isNotEmpty && !_clearText) {
      setState(() {
        _clearText = true;
      });
    } else if (text.isEmpty && _clearText) {
      setState(() {
        _clearText = false;
      });
    }
  }
}
