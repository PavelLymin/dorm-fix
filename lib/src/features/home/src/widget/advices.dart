import 'package:ui_kit/ui.dart';

class Advices extends StatefulWidget {
  const Advices({super.key});

  @override
  State<Advices> createState() => _AdvicesState();
}

class _AdvicesState extends State<Advices> {
  late final List<(String, String, String)> list;

  @override
  void initState() {
    super.initState();
    list = [
      ('Замена лампочки', '2 мин.', 'Средне'),
      ('Замена лампочки', '2 мин.', 'Средне'),
      ('Замена лампочки', '2 мин.', 'Средне'),
      ('Замена лампочки', '2 мин.', 'Средне'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.contentPadding,
      child: Column(
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        spacing: 16.0,
        children: [
          Row(
            mainAxisAlignment: .spaceBetween,
            crossAxisAlignment: .center,
            children: [
              UiText.titleMedium('Советы по ремонту'),
              UiButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.chevron_right_outlined),
              ),
            ],
          ),
          SizedBox(
            height: 124.0,
            child: ListView.builder(
              itemExtent: 124.0,
              scrollDirection: .horizontal,
              itemCount: list.length,
              padding: .zero,
              itemBuilder: (context, index) {
                final item = list[index];
                return Padding(
                  padding: AppPadding.horizontal,
                  child: UiCard.clickable(
                    onTap: () {},
                    padding: AppPadding.allMedium,
                    child: Column(
                      mainAxisAlignment: .start,
                      crossAxisAlignment: .start,
                      mainAxisSize: .min,
                      children: [
                        UiText.bodyMedium(
                          item.$1,
                          style: TextStyle(fontWeight: .w500),
                        ),
                        const Spacer(),
                        UiText.bodyMedium(item.$2),
                        UiText.bodyMedium(item.$3),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
