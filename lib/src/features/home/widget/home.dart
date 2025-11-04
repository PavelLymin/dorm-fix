import 'package:ui_kit/ui.dart';

import 'carousel_specializations.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: WindowSizeScope.of(context).maybeMap(
        compact: (size) => Padding(
          padding: const EdgeInsets.only(bottom: 128, left: 16, right: 16),
          child: Column(children: [const SpecializationsCarousel()]),
        ),
        medium: (size) => Padding(
          padding: const EdgeInsets.only(bottom: 128, left: 16, right: 16),
          child: Column(children: [const SpecializationsCarousel()]),
        ),
        orElse: () => Container(),
      ),
    ),
  );
}
