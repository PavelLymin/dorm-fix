import 'package:ui_kit/ui.dart';

class PersonalData extends StatefulWidget {
  const PersonalData({super.key});

  @override
  State<PersonalData> createState() => _PersonalDataState();
}

class _PersonalDataState extends State<PersonalData> {
  @override
  Widget build(BuildContext context) => Ink(
    decoration: BoxDecoration(
      color: Theme.of(context).colorPalette.secondary,
      borderRadius: .circular(16),
    ),
    child: Column(),
  );
}
