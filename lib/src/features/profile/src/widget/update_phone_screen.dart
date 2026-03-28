import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../../../l10n/gen/app_localizations.dart';
import '../../../authentication/authentication.dart';
import '../../profile.dart';

class UpdatePhoneScreen extends StatefulWidget {
  const UpdatePhoneScreen({super.key});

  @override
  State<UpdatePhoneScreen> createState() => _UpdatePhoneScreenState();
}

class _UpdatePhoneScreenState extends State<UpdatePhoneScreen> {
  final _pinCodeValidator = PinCodeValidator();
  final ValueNotifier<bool> _isEnabled = ValueNotifier<bool>(false);
  final TextEditingController _controller = TextEditingController();
  late PhoneNumberBloc _phoneNumberBloc;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_isValidPinCode);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _phoneNumberBloc = context.read<PhoneNumberBloc>();
  }

  @override
  void dispose() {
    _phoneNumberBloc.close();
    _isEnabled.dispose();
    _controller.removeListener(_isValidPinCode);
    _controller.dispose();
    super.dispose();
  }

  void _updatePhoneNumber() {
    _phoneNumberBloc.state.mapOrNull(
      smsCodeSent: (state) => _phoneNumberBloc.add(
        PhoneNumberEvent.submitSmsCode(
          smsCode: _controller.text,
          verificationId: state.verificationId,
          phoneNumber: state.phoneNumber,
        ),
      ),
    );
  }

  void _isValidPinCode() => _pinCodeValidator.onPinCodeChanged(
    _controller.text,
    onValid: (_) => _isEnabled.value = true,
    onInvalid: (_) => _isEnabled.value = false,
  );

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: context.appStyle.appPadding.horizontalIncrement(increment: 3),
        child: Center(
          child: Column(
            crossAxisAlignment: .center,
            mainAxisAlignment: .center,
            mainAxisSize: .min,
            children: [
              PinCode(controller: _controller, isEnable: true, isFocus: true),
              ValueListenableBuilder(
                valueListenable: _isEnabled,
                builder: (_, value, _) => UiButton.filledPrimary(
                  enabled: value,
                  onPressed: _updatePhoneNumber,
                  label: UiText.titleMedium(localizations.next),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
