import 'package:auto_route/auto_route.dart';
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
            smsCodeSent: (_) {
              _buttonBloc.add(.addEnabled());
              context.router.push(NamedRoute(''));
            },
            error: (state) {
              _buttonBloc.add(.addEnabled());
              ErrorUtil.showSnackBar(context, state.message);
            },
          );
        },
        child: Padding(
          padding: const .only(top: 20.0),
          child: Column(
            mainAxisAlignment: .start,
            crossAxisAlignment: .start,
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
                mainAxisAlignment: .center,
                crossAxisAlignment: .center,
                mainAxisSize: .min,
                spacing: 8.0,
                children: [
                  Flexible(
                    child: UiDropDownButton<String>(
                      dropdownMenuEntries: _dropdownMenuEntries,
                    ),
                  ),
                  UiTextField.standard(
                    controller: _controller,
                    style: const UiTextFieldStyle(hintText: '900 000 00-00'),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              AuthButton(controller: _controller),
            ],
          ),
        ),
      ),
    );
  }
}

mixin _AuthFormStateMixin on State<AuthForm> {
  late final ButtonBloc _buttonBloc;
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  late final PhoneValidator _phoneValidator;
  late final List<DropdownMenuEntry<String>> _dropdownMenuEntries;

  @override
  void initState() {
    super.initState();
    _buttonBloc = ButtonBloc();
    _controller = TextEditingController();
    _controller.addListener(_onPhoneChanged);
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
    _controller.removeListener(_onPhoneChanged);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onPhoneChanged() => _phoneValidator.onPhoneChanged(
    _controller.text,
    onValid: (_) => _buttonBloc.add(.addEnabled()),
    onInvalid: (_) => _buttonBloc.add(.addDisabled()),
  );
}
