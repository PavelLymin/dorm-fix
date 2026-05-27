import 'package:ui_kit/ui.dart';
import '../../../request.dart';

class RepairRequestDetails extends StatelessWidget {
  const RepairRequestDetails({
    super.key,
    required this.request,
    required this.images,
  });

  final FullRepairRequest request;
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Заявка')),
      body: SafeArea(
        child: Padding(
          padding: AppInsets.screen,
          child: CustomScrollView(
            slivers: [
              if (request.problems.isNotEmpty) RequestImages(images: images),
              SliverPadding(
                padding: .only(top: 24.0, bottom: 10.0),
                sliver: SliverToBoxAdapter(child: UiText2.lBold('Детали')),
              ),
              RequestDetails(request: request),
              SliverPadding(
                padding: const .only(top: 24.0, bottom: 10.0),
                sliver: SliverToBoxAdapter(child: UiText2.lBold('Описание')),
              ),
              SliverToBoxAdapter(
                child: UiCard.standart(child: UiText2.m(request.description)),
              ),
              SliverPadding(
                padding: const .only(top: 24.0, bottom: 10.0),
                sliver: SliverToBoxAdapter(
                  child: UiText2.lBold('Дата и время ремонта'),
                ),
              ),
              RequestDateTime(request: request),
              SliverPadding(
                padding: const .only(top: 24.0, bottom: 10.0),
                sliver: SliverToBoxAdapter(
                  child: UiText2.lBold('Статус заявки'),
                ),
              ),
              RequestStatus(
                currentStatus: request.currentStatus,
                status: request.status,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
