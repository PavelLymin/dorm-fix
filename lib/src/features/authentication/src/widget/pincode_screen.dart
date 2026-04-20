import 'package:ui_kit/ui.dart';

import 'pincode_form.dart';

class PincodeScreen extends StatelessWidget {
  const PincodeScreen({
    super.key,
    required this.phoneNumber,
    required this.verificationId,
  });

  final String phoneNumber;
  final String verificationId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Вход в профиль'), toolbarHeight: 42.0),
      body: Padding(
        padding: AppInsets.screen,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: .center,
            mainAxisAlignment: .start,
            children: [
              PincodeForm(
                phoneNumber: phoneNumber,
                verificationId: verificationId,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
