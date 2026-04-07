import 'package:ui_kit/ui.dart';

class Advices extends StatefulWidget {
  const Advices({super.key});

  @override
  State<Advices> createState() => _AdvicesState();
}

class _AdvicesState extends State<Advices> {
  late final List<(String, String, String)> list;
  late final ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    list = [
      ('Замена лампочки', '2 мин.', 'Средне'),
      ('Замена лампочки', '2 мин.', 'Средне'),
      ('Замена лампочки', '2 мин.', 'Средне'),
      ('Замена лампочки', '2 мин.', 'Средне'),
    ];
  }

  void _jumpToEnd() {
    if (list.isEmpty) return;

    if (_controller.hasClients) {
      _controller.animateTo(
        _controller.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette2;
    return Column(
      mainAxisAlignment: .center,
      crossAxisAlignment: .center,
      mainAxisSize: .min,
      spacing: 10.0,
      children: [
        Row(
          mainAxisAlignment: .spaceBetween,
          crossAxisAlignment: .center,
          children: [
            UiText2.lBold('Советы по ремонту'),
            UiButton.icon(
              onPressed: _jumpToEnd,
              icon: const Icon(Icons.chevron_right_outlined),
              style: ButtonStyle(backgroundColor: .all(palette.background)),
            ),
          ],
        ),
        SizedBox(
          height: 140.0,
          child: ListView.separated(
            controller: _controller,
            itemCount: list.length + 1,
            scrollDirection: .horizontal,
            padding: .zero,
            separatorBuilder: (context, index) => const SizedBox(width: 12.0),
            itemBuilder: (context, index) {
              if (index == list.length) {
                return _AdviceContent();
              }
              return _AdviceContent(item: list[index]);
            },
          ),
        ),
      ],
    );
  }
}

class _AdviceContent extends StatelessWidget {
  const _AdviceContent({this.item});

  final (String, String, String)? item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette2;
    return SizedBox.square(
      dimension: 140.0,
      child: UiCard.clickable(
        onTap: () {},
        padding: const .only(left: 20.0, top: 12.0, right: 20.0, bottom: 16.0),
        child: Column(
          mainAxisAlignment: .start,
          crossAxisAlignment: .start,
          mainAxisSize: .min,
          children: [
            if (item != null) UiText2.m(item!.$1),
            if (item == null) UiText2.m('Все советы'),
            const Spacer(),
            if (item != null)
              UiText2.m(item!.$2, color: palette.foregroundSecondary),
            if (item == null)
              UiText2.m('Далее', color: palette.foregroundSecondary),
            if (item != null) const SizedBox(height: 4.0),
            if (item != null)
              UiText2.m(item!.$3, color: palette.foregroundSecondary),
          ],
        ),
      ),
    );
  }
}
