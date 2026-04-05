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
      mainAxisAlignment: .start,
      crossAxisAlignment: .start,
      mainAxisSize: .min,
      children: [
        UiText2.lBold('Ваши заявки'),
        SizedBox(
          height: 100,
          child: RepairRequestList(
            requests: requests,
            itemCount: 2,
            style: RepairRequestsStyle(
              titleStyle: typography.lBold.copyWith(color: palette.foreground),
              dataStyle: typography.m.copyWith(color: palette.secondary),
            ),
          ),
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
        print(_height);
        final requests = snapshot.data!;
        return ListView.builder(
          itemExtent: _height,
          itemCount: widget.itemCount,
          itemBuilder: (_, index) => Padding(
            padding: widget.style.listPadding,
            child: UiCard.clickable(
              padding: widget.style.itemPadding,
              onTap: () {},
              child: Row(
                mainAxisAlignment: .spaceBetween,
                crossAxisAlignment: .center,
                children: [
                  Column(
                    mainAxisAlignment: .start,
                    crossAxisAlignment: .start,
                    mainAxisSize: .min,
                    children: [
                      Text(
                        requests[index].specialization.title,
                        style: widget.style.titleStyle,
                      ),
                      SizedBox(height: widget.style.spacing),
                      Text(
                        '${requests[index].startTime}:00-${requests[index].endTime}:00',
                        style: widget.style.dataStyle,
                      ),
                      SizedBox(height: widget.style.dataSpacing),
                      Text(
                        requests[index].date.toLocal().toIso8601String(),
                        style: widget.style.dataStyle,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
