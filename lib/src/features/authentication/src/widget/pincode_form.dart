import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../../core/utils/utils.dart';
import '../../authentication.dart';
import 'auth_button.dart';

class PincodeForm extends StatefulWidget {
  const PincodeForm({
    super.key,
    required this.phoneNumber,
    required this.verificationId,
  });

  final String phoneNumber;
  final String verificationId;

  @override
  State<PincodeForm> createState() => _PincodeFormState();
}

class _PincodeFormState extends State<PincodeForm> with _PincodeFormStateMixiN {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette2;
    return BlocProvider.value(
      value: _buttonBloc,
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) => state.mapOrNull(
          loading: (_) => _buttonBloc.add(.addLoading()),
          authenticated: (user) {
            _buttonBloc.add(.addEnabled());
            user.authUser.mapAuthUser(
              firebase: (_) =>
                  context.router.replace(const NamedRoute('MapScreen')),
              profile: (p) => p.mapRoleUser(
                student: (_) => context.router.replace(
                  const NamedRoute('StudentRootSreen'),
                ),
                master: (m) => context.router.replace(
                  NamedRoute(
                    'MasterRootSreen',
                    params: {
                      'spec_id': m.specialization.id,
                      'dorm_id': m.dormitory.id,
                    },
                  ),
                ),
              ),
            );
          },
          error: (state) {
            _buttonBloc.add(.addEnabled());
            ErrorUtil.showSnackBar(context, state.message);
          },
        ),
        child: Column(
          mainAxisAlignment: .start,
          crossAxisAlignment: .stretch,
          mainAxisSize: .min,
          children: [
            UiText2.lBold('Введите код из SMS'),
            const SizedBox(height: 4.0),
            UiText2.m(
              'Отправили на номер ${widget.phoneNumber}',
              color: palette.foregroundSecondary,
            ),
            const SizedBox(height: 10.0),
            PinCode(
              length: 6,
              isEnable: true,
              isFocus: true,
              controller: _pinCodeController,
            ),
            Padding(
              padding: .symmetric(vertical: 20.0),
              child: AuthButton(
                onPressed: () => context.read<AuthBloc>().add(
                  .signInWithPhoneNumber(
                    verificationId: widget.verificationId,
                    smsCode: _pinCodeController.text,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

mixin _PincodeFormStateMixiN on State<PincodeForm> {
  late final ButtonBloc _buttonBloc;
  late final TextEditingController _pinCodeController;
  late final PinCodeValidator _pinCodeValidator;

  @override
  void initState() {
    super.initState();
    _buttonBloc = ButtonBloc();
    _pinCodeController = TextEditingController();
    _pinCodeController.addListener(_onPincodeChanged);
    _pinCodeValidator = PinCodeValidator();
  }

  @override
  void dispose() {
    _buttonBloc.close();
    _pinCodeController.dispose();
    _pinCodeController.removeListener(_onPincodeChanged);
    super.dispose();
  }

  void _onPincodeChanged() => _pinCodeValidator.onPinCodeChanged(
    _pinCodeController.text,
    onValid: (_) => _buttonBloc.add(.addEnabled()),
    onInvalid: (_) => _buttonBloc.add(.addDisabled()),
  );
}
