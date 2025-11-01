import 'package:ui_kit/ui.dart';

class UiModalBottomSheet extends StatelessWidget {
  const UiModalBottomSheet({
    super.key,
    required this.text,
    required this.child,
  });
  final String text;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   color: Color(0XFF212121),
      //   boxShadow: [
      //     BoxShadow(
      //       color: Colors.white,
      //       offset: const Offset(0.0, 0.0),
      //       blurRadius: 3.0,
      //       spreadRadius: 0.0,
      //     ),
      //   ],
      //   borderRadius: BorderRadius.circular(27),
      //   border: Border.all(color: Color(0XFF3B3B3B), width: 2),
      // ),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 22),
      child: Column(children: [Text(text), child]),
    );
  }
}
