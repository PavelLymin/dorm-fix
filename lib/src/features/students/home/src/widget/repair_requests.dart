import 'dart:developer';

import 'package:ui_kit/ui.dart';
import '../../../../../app/widget/dependencies_scope.dart';
import '../../../../repair_request/request.dart';

class RepairRequests extends StatefulWidget {
  const RepairRequests({super.key});

  @override
  State<RepairRequests> createState() => _RepairRequestsState();
}

class _RepairRequestsState extends State<RepairRequests> {
  late final Stream<List<FullRepairRequest>> requests;

  @override
  void initState() {
    super.initState();
    final requestRepository = DependeciesScope.of(context).requestRepository;
    requests = requestRepository.getRequests(uid: true);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette2;
    final typography = theme.appTypography2;
    return Column(
      mainAxisAlignment: .center,
      crossAxisAlignment: .stretch,
      mainAxisSize: .min,
      children: [
        Row(
          mainAxisAlignment: .spaceBetween,
          crossAxisAlignment: .center,
          children: [
            UiText2.lBold('Ваши заявки'),
            UiButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.timelapse_outlined),
            ),
          ],
        ),
        RepairRequestList(
          requests: requests,
          itemCount: 1,
          style: RepairRequestsStyle(
            titleStyle: typography.lBold.copyWith(color: palette.foreground),
            dataStyle: typography.m.copyWith(color: palette.secondary),
          ),
        ),
        const SizedBox(height: 12.0),
        UiButton.filledPrimary(
          onPressed: () {},
          label: Text('Создать заявку'),
          icon: Icon(Icons.add_outlined),
        ),
      ],
    );
  }
}

class RepairRequestList extends StatefulWidget {
  const RepairRequestList({
    super.key,
    required this.itemCount,
    required this.requests,
    required this.style,
  });

  final int itemCount;
  final Stream<List<FullRepairRequest>> requests;
  final RepairRequestsStyle style;

  @override
  State<RepairRequestList> createState() => _RepairRequestListState();
}

class _RepairRequestListState extends State<RepairRequestList> {
  late double _height;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _height = EstimatedSizes.estimateHeight(widget.style);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.requests,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Ошибка: ${snapshot.error}');
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final requests = snapshot.data!;
        return SizedBox(
          height: _height * widget.itemCount,
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            padding: .zero,
            itemExtent: _height,
            itemCount: widget.itemCount,
            itemBuilder: (context, index) => _Item(
              request: requests[requests.length - 1],
              style: widget.style,
            ),
          ),
        );
      },
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({required this.request, required this.style});

  final FullRepairRequest request;
  final RepairRequestsStyle style;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: style.listPadding,
      child: UiCard.clickable(
        padding: style.itemPadding,
        onTap: () {
          log(request.problems.first.photoPath);
        },
        child: Row(
          mainAxisAlignment: .spaceBetween,
          crossAxisAlignment: .center,
          children: [
            Column(
              mainAxisAlignment: .start,
              crossAxisAlignment: .start,
              mainAxisSize: .min,
              children: [
                Text(request.specialization.title, style: style.titleStyle),
                SizedBox(height: style.spacing),
                Text(
                  '${request.startTime}:00-${request.endTime}:00',
                  style: style.dataStyle,
                ),
                SizedBox(height: style.dataSpacing),
                Text(
                  request.date.toLocal().toIso8601String(),
                  style: style.dataStyle,
                ),
              ],
            ),
            // Image.network(
            //   'https://[project_id].supabase.co/storage/v1/object/public/problems/problem/${request.problems.first.photoPath}.png',
            // ),
          ],
        ),
      ),
    );
  }
}

class RepairRequestsStyle {
  const RepairRequestsStyle({
    required this.titleStyle,
    required this.dataStyle,
    this.listPadding = const .symmetric(vertical: 8.0),
    this.itemPadding = const .only(
      top: 12.0,
      bottom: 16.0,
      left: 20.0,
      right: 20.0,
    ),
    this.spacing = 6.0,
    this.dataSpacing = 4.0,
  });

  final TextStyle titleStyle;
  final TextStyle dataStyle;
  final EdgeInsets listPadding;
  final EdgeInsets itemPadding;
  final double spacing;
  final double dataSpacing;
}

abstract class EstimatedSizes {
  const EstimatedSizes();

  static double _estimateHeightText(RepairRequestsStyle style) {
    final title = TextPainter(
      text: TextSpan(style: style.titleStyle),
      maxLines: 1,
      textDirection: .ltr,
    )..layout();

    final data = TextPainter(
      text: TextSpan(style: style.dataStyle),
      maxLines: 1,
      textDirection: .ltr,
    )..layout();

    return title.height + data.height * 2;
  }

  static double estimateHeight(RepairRequestsStyle style) =>
      _estimateHeightText(style) +
      style.listPadding.vertical +
      style.itemPadding.vertical +
      style.spacing +
      style.dataSpacing;
}
