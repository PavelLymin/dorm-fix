import 'package:ui_kit/ui.dart';
import '../../../request.dart';

class RequestDetails extends StatelessWidget {
  const RequestDetails({super.key, required this.request});

  final FullRepairRequest request;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: UiCard.standart(
        child: Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          mainAxisSize: .min,
          children: [
            Row(
              mainAxisAlignment: .spaceBetween,
              crossAxisAlignment: .center,
              children: [
                UiText2.m('Мастер или услуга'),
                UiText2.m(request.specialization.title),
              ],
            ),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: .spaceBetween,
              crossAxisAlignment: .center,
              children: [
                UiText2.m('Комната'),
                UiText2.m(request.student.room.number),
              ],
            ),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: .spaceBetween,
              crossAxisAlignment: .center,
              children: [
                UiText2.m('Общежитие'),
                UiText2.m(request.student.dormitory.name),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
