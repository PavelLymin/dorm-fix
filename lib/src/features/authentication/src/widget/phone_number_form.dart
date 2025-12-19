import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';

import '../../../../app/widget/dependencies_scope.dart';
import '../../authentication.dart';

class PhoneNumberForm extends StatefulWidget {
  const PhoneNumberForm({
    required this.phoneController,
    required this.pinCodeController,
    required this.phoneFocusNode,
    required this.isEnabledTextField,
    required this.isEnabledPinCode,
    this.onTap,
    super.key,
  });

  final TextEditingController phoneController;
  final TextEditingController pinCodeController;
  final FocusNode phoneFocusNode;
  final bool isEnabledTextField;
  final bool isEnabledPinCode;
  final Function()? onTap;

  @override
  State<PhoneNumberForm> createState() => _PhoneNumberFormState();
}

class _PhoneNumberFormState extends State<PhoneNumberForm>
    with _PhoneNumberFormStateMixin {
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorPalette;
    return Column(
      children: [
        UiTextField.standard(
          enabled: widget.isEnabledTextField,
          focusNode: widget.phoneFocusNode,
          controller: widget.phoneController,
          keyboardType: TextInputType.phone,
          style: UiTextFieldStyle(
            prefixIcon: Icon(Icons.phone_enabled_outlined),
            suffixIcon: widget.phoneController.text.isEmpty
                ? null
                : IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () =>
                        setState(() => widget.phoneController.clear()),
                  ),
          ),
        ),
        const SizedBox(height: 16),
        PinCode(
          height: 60,
          length: 6,
          isEnable: widget.isEnabledPinCode,
          isFocus: widget.isEnabledPinCode,
          controller: widget.pinCodeController,
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: widget.onTap,
            child: Padding(
              padding: EdgeInsets.all(1.5),
              child: UiText.bodyLarge(
                'Изменить номер?',
                style: TextStyle(
                  color: widget.isEnabledPinCode
                      ? color.foreground
                      : color.mutedForeground,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

mixin _PhoneNumberFormStateMixin on State<PhoneNumberForm> {
  bool _isValidatePhone = false;
  bool _isPinValidate = false;
  late final AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();
    _authBloc = DependeciesScope.of(context).authenticationBloc;
    widget.phoneController.addListener(_onPhoneChanged);
    widget.pinCodeController.addListener(_onPinChanged);
  }

  @override
  void dispose() {
    widget.phoneController.removeListener(_onPhoneChanged);
    widget.pinCodeController.removeListener(_onPinChanged);
    super.dispose();
  }

  void _onPhoneChanged() {
    if (PhoneNumberValidator.validatePhoneNumber(widget.phoneController.text) &&
        !_isValidatePhone) {
      _isValidatePhone = true;
      context.read<AuthButtonBloc>().add(
        AuthButtonEvent.changeState(isPhoneNumber: true),
      );
    } else if (!PhoneNumberValidator.validatePhoneNumber(
          widget.phoneController.text,
        ) &&
        _isValidatePhone) {
      _isValidatePhone = false;
      context.read<AuthButtonBloc>().add(
        AuthButtonEvent.changeState(isPhoneNumber: false),
      );
    }
  }

  void _onPinChanged() {
    if (PhoneNumberValidator.validatePinCode(widget.pinCodeController.text) &&
        !_isPinValidate) {
      _isPinValidate = true;
      _authBloc.state.mapOrNull(
        smsCodeSent: (state) => _authBloc.add(
          AuthEvent.signInWithPhoneNumber(
            verificationId: state.verificationId,
            smsCode: widget.pinCodeController.text,
          ),
        ),
      );
      context.read<AuthButtonBloc>().add(
        AuthButtonEvent.changeState(isPin: true),
      );
    } else if (!PhoneNumberValidator.validatePinCode(
          widget.pinCodeController.text,
        ) &&
        _isPinValidate) {
      _isPinValidate = false;
      context.read<AuthButtonBloc>().add(
        AuthButtonEvent.changeState(isPin: false),
      );
    }
  }
}
