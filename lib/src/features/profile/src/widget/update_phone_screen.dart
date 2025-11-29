import 'package:ui_kit/ui.dart';

class UpdatePhoneScreen extends StatefulWidget {
  const UpdatePhoneScreen({super.key});

  @override
  State<UpdatePhoneScreen> createState() => _UpdatePhoneScreenState();
}

class _UpdatePhoneScreenState extends State<UpdatePhoneScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
    resizeToAvoidBottomInset: true,
    body: SafeArea(
      child: Padding(
        padding: AppPadding.horizontalIncrement(increment: 3),
        child: Center(
          child: SizedBox(
            width: 400,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                PinCode(controller: _controller),
                UiButton.filledPrimary(
                  onPressed: () {},
                  label: UiText.titleMedium('Далее'),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
