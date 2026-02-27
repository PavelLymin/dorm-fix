import 'package:ui_kit/ui.dart';

class FloatingDateOverlay extends StatelessWidget {
  const FloatingDateOverlay({super.key, required this.floatingDate});
  final ValueNotifier<String?> floatingDate;

  @override
  Widget build(BuildContext context) => Positioned(
    top: 8,
    left: 0,
    right: 0,
    child: Center(
      child: ListenableBuilder(
        listenable: floatingDate,
        builder: (context, _) => switch (floatingDate.value) {
          String date => _ChatDate(date: date),
          null => const SizedBox.shrink(),
        },
      ),
    ),
  );
}

class _ChatDate extends StatelessWidget {
  const _ChatDate({required this.date});
  final String date;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: .min,
    mainAxisAlignment: .center,
    children: [
      Padding(
        padding: const .symmetric(vertical: 8, horizontal: 16),
        child: ColoredBox(
          color: Colors.black26.withAlpha(20),
          child: Padding(
            padding: const .symmetric(vertical: 4, horizontal: 8),
            child: Text(date),
          ),
        ),
      ),
    ],
  );
}
