import 'package:intl/intl.dart';
import 'package:ui_kit/ui.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    this.onPrevious,
    this.onNext,
    required this.currentDate,
  });

  final VoidCallback? onPrevious;
  final VoidCallback? onNext;
  final ValueNotifier<DateTime> currentDate;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette2;
    final locale = Localizations.localeOf(context).languageCode;
    return UiCard.standart(
      padding: .symmetric(horizontal: 20.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: .center,
        crossAxisAlignment: .center,
        mainAxisSize: .min,
        children: [
          UiButton.icon(
            onPressed: onPrevious,
            icon: const Icon(Icons.chevron_left_outlined),
            style: ButtonStyle(
              iconColor: .all(palette.secondary),
              padding: const WidgetStatePropertyAll(.zero),
              minimumSize: const WidgetStatePropertyAll(.zero),
            ),
          ),
          const Spacer(),
          ValueListenableBuilder(
            valueListenable: currentDate,
            builder: (context, value, child) =>
                UiText2.m(DateFormat.yMMMM(locale).format(value).toUpperCase()),
          ),
          const Spacer(),
          UiButton.icon(
            onPressed: onNext,
            icon: const Icon(Icons.chevron_right_outlined),
            style: ButtonStyle(
              iconColor: .all(palette.secondary),
              padding: const WidgetStatePropertyAll(.zero),
              minimumSize: const WidgetStatePropertyAll(.zero),
            ),
          ),
        ],
      ),
    );
  }
}
