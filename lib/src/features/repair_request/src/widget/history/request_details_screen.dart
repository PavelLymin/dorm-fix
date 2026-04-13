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
      body: Padding(
        padding: AppInsets.screen,
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(title: Text('Заявка'), toolbarHeight: 42.0),
            if (request.problems.isNotEmpty)
              Carousel(problems: request.problems),
            SliverPadding(
              padding: .only(top: 24.0),
              sliver: SliverToBoxAdapter(child: UiText2.lBold('Детали')),
            ),
            Details(request: request),
            SliverPadding(
              padding: const .only(top: 24.0),
              sliver: SliverToBoxAdapter(child: UiText2.lBold('Описание')),
            ),
            SliverPadding(
              padding: const .only(top: 10.0),
              sliver: SliverToBoxAdapter(
                child: UiCard.standart(child: UiText2.m(request.description)),
              ),
            ),
            SliverPadding(
              padding: const .only(top: 24.0),
              sliver: SliverToBoxAdapter(
                child: UiText2.lBold('Дата и время ремонта'),
              ),
            ),
            DateTimeRequest(request: request),
          ],
        ),
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
    return SliverPadding(
      padding: const .only(top: 10.0),
      sliver: SliverToBoxAdapter(
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
                  UiText2.m(request.specialization.title),
                ],
              ),
              const SizedBox(height: 12.0),
              Row(
                mainAxisAlignment: .spaceBetween,
                crossAxisAlignment: .center,
                children: [
                  UiText2.m('Общежитие'),
                  UiText2.m(request.specialization.title),
                ],
              ),
            ],
          ),
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
    return SliverPadding(
      padding: const .only(top: 10.0),
      sliver: SliverToBoxAdapter(
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
      ),
    );
  }
}
