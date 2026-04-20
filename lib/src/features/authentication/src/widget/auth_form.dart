import 'package:auto_route/auto_route.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../../core/utils/utils.dart';
import '../../authentication.dart';
import 'auth_button.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> with _AuthFormStateMixin {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette2;
    return BlocProvider.value(
      value: _buttonBloc,
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          state.mapOrNull(
            loading: (_) => _buttonBloc.add(.addLoading()),
            smsCodeSent: (state) {
              _buttonBloc.add(.addEnabled());
              final phoneNumber = _codeController.text + _phonneController.text;
              context.router.push(
                NamedRoute(
                  'PincodeScreen',
                  params: {
                    'phone_number': phoneNumber,
                    'verification_id': state.verificationId,
                  },
                ),
              );
            },
            error: (state) {
              _isValid()
                  ? _buttonBloc.add(.addEnabled())
                  : _buttonBloc.add(.addDisabled());
              ErrorUtil.showSnackBar(context, state.message);
            },
          );
        },
        child: Padding(
          padding: const .only(top: 20.0),
          child: Column(
            mainAxisAlignment: .start,
            crossAxisAlignment: .stretch,
            mainAxisSize: .min,
            children: [
              UiText2.lBold('Введите номер телефона'),
              const SizedBox(height: 4.0),
              UiText2.m(
                'Отправим на него SMS-код для подтверждения',
                color: palette.foregroundSecondary,
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: .start,
                crossAxisAlignment: .center,
                mainAxisSize: .min,
                spacing: 8.0,
                children: [
                  UiDropDownButton<String>(
                    width: 116.0,
                    controller: _codeController,
                    trailingIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                    selectedTrailingIcon: const Icon(
                      Icons.keyboard_arrow_up_rounded,
                    ),
                    selectOnly: true,
                    initialSelection: '+7',
                    dropdownMenuEntries: _dropdownMenuEntries,
                  ),
                  Expanded(
                    child: UiTextField.standard(
                      controller: _phonneController,
                      keyboardType: .number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      textInputAction: .done,
                      style: const UiTextFieldStyle(hintText: '900 000 00-00'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              AuthButton(
                onPressed: () {
                  final phoneNumber =
                      _codeController.text + _phonneController.text;
                  context.read<AuthBloc>().add(
                    .verifyPhoneNumber(phoneNumber: phoneNumber),
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

mixin _AuthFormStateMixin on State<AuthForm> {
  late final ButtonBloc _buttonBloc;
  late final TextEditingController _phonneController;
  late final TextEditingController _codeController;
  late final FocusNode _focusNode;
  late final PhoneValidator _phoneValidator;
  late final List<DropdownMenuEntry<String>> _dropdownMenuEntries;

  @override
  void initState() {
    super.initState();
    _buttonBloc = ButtonBloc();
    _phonneController = TextEditingController();
    _phonneController.addListener(_onPhoneChanged);
    _codeController = TextEditingController();
    _codeController.addListener(_onPhoneChanged);
    _focusNode = FocusNode();
    _phoneValidator = PhoneValidator();
    _dropdownMenuEntries = [
      DropdownMenuEntry<String>(value: '+7', label: '+7'),
      DropdownMenuEntry<String>(value: '+33', label: '+33'),
      DropdownMenuEntry<String>(value: '+54', label: '+54'),
      DropdownMenuEntry<String>(value: '+375', label: '+375'),
    ];
  }

  @override
  void dispose() {
    _buttonBloc.close();
    _phonneController.removeListener(_onPhoneChanged);
    _phonneController.dispose();
    _codeController.removeListener(_onPhoneChanged);
    _codeController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  bool _isValid() =>
      _phoneValidator.validate(_codeController.text + _phonneController.text);

  void _onPhoneChanged() => _phoneValidator.onPhoneChanged(
    _codeController.text + _phonneController.text,
    onValid: (_) => _buttonBloc.add(.addEnabled()),
    onInvalid: (_) => _buttonBloc.add(.addDisabled()),
  );
}
