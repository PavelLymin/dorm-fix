import 'package:dorm_fix/src/app/model/application_config.dart';
import 'package:ui_kit/ui.dart';
import '../../../request.dart';
import '../../model/problem.dart';

class RequestDetailsScreen extends StatelessWidget {
  const RequestDetailsScreen({super.key, required this.request});

  final FullRepairRequest request;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: AppInsets.screen,
            sliver: SliverSafeArea(
              sliver: SliverMainAxisGroup(
                slivers: [
                  const SliverAppBar(
                    title: Text('Заявка'),
                    toolbarHeight: 42.0,
                  ),
                  if (request.problems.isNotEmpty)
                    Carousel(problems: request.problems),
                  SliverPadding(
                    padding: .only(top: 24.0, bottom: 10.0),
                    sliver: SliverToBoxAdapter(child: UiText2.lBold('Детали')),
                  ),
                  Details(request: request),
                  SliverPadding(
                    padding: const .only(top: 24.0, bottom: 10.0),
                    sliver: SliverToBoxAdapter(
                      child: UiText2.lBold('Описание'),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: UiCard.standart(
                      child: UiText2.m(request.description),
                    ),
                  ),
                  SliverPadding(
                    padding: const .only(top: 24.0, bottom: 10.0),
                    sliver: SliverToBoxAdapter(
                      child: UiText2.lBold('Дата и время ремонта'),
                    ),
                  ),
                  DateTimeRequest(request: request),
                  SliverPadding(
                    padding: const .only(top: 24.0, bottom: 10.0),
                    sliver: SliverToBoxAdapter(
                      child: UiText2.lBold('Статус заявки'),
                    ),
                  ),
                  const StatusRequest(),
                  SliverPadding(
                    padding: .only(top: 32.0),
                    sliver: SliverToBoxAdapter(
                      child: UiButton.filledPrimary(
                        onPressed: () {},
                        icon: const Icon(Icons.cancel_outlined),
                        label: Text('Отменить заявку'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Carousel extends StatelessWidget {
  const Carousel({super.key, required this.problems});

  final List<FullProblem> problems;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const .only(top: 32.0),
      sliver: SliverToBoxAdapter(
        child: UiCarousel(
          itemCount: problems.length,
          itemBuilder: (context, index) {
            final problem = problems[index];
            return DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: Theme.of(context).appStyle.borderRadius,
                image: DecorationImage(
                  image: NetworkImage(
                    '${Config.storageBaseUrl}${Config.problemsBucket}${problem.photoPath}',
                  ),
                  fit: .cover,
                ),
              ),
            );
          },
          constraints: const BoxConstraints(maxHeight: 220.0),
        ),
      ),
    );
  }
}

class Details extends StatelessWidget {
  const Details({super.key, required this.request});

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

class DateTimeRequest extends StatelessWidget {
  const DateTimeRequest({super.key, required this.request});

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

class StatusRequest extends StatelessWidget {
  const StatusRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: UiCard.standart(
        padding: .all(20.0),
        child: UiStepper(
          steps: [
            StepItem(title: 'Создано', subtitle: '4 апреля в 16:37'),
            StepItem(title: 'Передано мастеру'),
            StepItem(title: 'Завершена'),
          ],
        ),
      ),
    );
  }
}
