import 'package:ui_kit/ui.dart';
import '../../../request.dart';

class RequestDateTime extends StatelessWidget {
  const RequestDateTime({super.key, required this.request});

  final FullRepairRequest request;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette2;
    return SliverToBoxAdapter(
      child: UiCard.standart(
        child: Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .start,
          mainAxisSize: .min,
          spacing: 6.0,
          children: [
            UiText2.m(request.date.toLocal().toIso8601String()),
            UiText2.m(
              '${request.startTime}:00-${request.endTime}:00',
              color: palette.foregroundSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
