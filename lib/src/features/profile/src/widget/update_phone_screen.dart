import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../authentication/authentication.dart';
import '../../profile.dart';

class UpdatePhoneScreen extends StatefulWidget {
  const UpdatePhoneScreen({super.key});

  @override
  State<UpdatePhoneScreen> createState() => _UpdatePhoneScreenState();
}

class _UpdatePhoneScreenState extends State<UpdatePhoneScreen> {
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

  void _isValidPinCode() {
    if (!_isEnabled.value &&
        PhoneNumberValidator.validatePinCode(_controller.text)) {
      _isEnabled.value = true;
    } else if (_isEnabled.value &&
        !PhoneNumberValidator.validatePinCode(_controller.text)) {
      _isEnabled.value = false;
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    resizeToAvoidBottomInset: true,
    body: Padding(
      padding: AppPadding.horizontalIncrement(increment: 3),
      child: Center(
        child: SizedBox(
          width: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              PinCode(controller: _controller, isEnable: true, isFocus: true),
              SizedBox(
                height: 48,
                width: .infinity,
                child: ValueListenableBuilder(
                  valueListenable: _isEnabled,
                  builder: (_, value, _) => UiButton.filledPrimary(
                    enabled: value,
                    onPressed: _updatePhoneNumber,
                    label: UiText.titleMedium('Далее'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
