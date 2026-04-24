import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../profile/profile.dart';
import '../../master.dart';

class MasterList extends StatefulWidget {
  const MasterList({super.key});

  @override
  State<MasterList> createState() => _MasterListState();
}

class _MasterListState extends State<MasterList> {
  static const double _photoSize = 64.0;
  static const double _titleSpacing = 4.0;
  static const double _itemSpacing = 10.0;
  late double _height;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final theme = Theme.of(context);
    _height = _Item.getExtent(theme.appTypography2, _photoSize, _itemSpacing);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MasterBloc, MasterState>(
      builder: (context, state) {
        return state.maybeMap(
          orElse: () => SliverToBoxAdapter(child: const SizedBox.shrink()),
          loaded: (state) {
            return SliverFixedExtentList.builder(
              itemBuilder: (context, index) {
                final master = state.masters[index];
                bool isFirst = index == 0;
                bool isLast = index == state.masters.length - 1;
                return _Item(
                  master: master,
                  photoSize: _photoSize,
                  itemSpacing: _itemSpacing,
                  titleSpacing: _titleSpacing,
                  isFirst: isFirst,
                  isLast: isLast,
                );
              },
              itemCount: state.masters.length,
              itemExtent: _height,
            );
          },
        );
      },
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    required this.master,
    required this.photoSize,
    required this.titleSpacing,
    required this.itemSpacing,
    required this.isFirst,
    required this.isLast,
  });

  final MasterUser master;
  final double photoSize;
  final double titleSpacing;
  final double itemSpacing;
  final bool isFirst;
  final bool isLast;

  static double getExtent(
    AppTypography2 typography,
    double photoSize,
    double spacing,
  ) {
    final painter = TextPainter(textDirection: TextDirection.ltr, maxLines: 1)
      ..text = TextSpan(style: typography.m)
      ..layout();

    final textHeight = painter.height;
    final contentHeight = textHeight * 2 + 4.0;
    return (contentHeight > photoSize ? contentHeight : photoSize) +
        (spacing * 2);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette2;
    final style = theme.appStyle;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: palette.card,
        borderRadius: style.borderRadius.copyWith(
          topLeft: isFirst ? style.borderRadius.topLeft : .zero,
          topRight: isFirst ? style.borderRadius.topRight : .zero,
          bottomLeft: isLast ? style.borderRadius.bottomLeft : .zero,
          bottomRight: isLast ? style.borderRadius.bottomRight : .zero,
        ),
      ),
      child: Padding(
        padding: .symmetric(vertical: itemSpacing, horizontal: 20.0),
        child: Row(
          mainAxisAlignment: .start,
          crossAxisAlignment: .start,
          mainAxisSize: .min,
          spacing: 12.0,
          children: [
            CircleAvatar(
              radius: photoSize / 2,
              backgroundColor: palette.secondary,
              backgroundImage: master.photoURL != null
                  ? NetworkImage(master.photoURL!)
                  : null,
            ),
            Column(
              mainAxisAlignment: .start,
              crossAxisAlignment: .start,
              mainAxisSize: .min,
              spacing: titleSpacing,
              children: [
                UiText2.m(master.displayName ?? 'User'),
                UiText2.m(
                  master.specialization.title,
                  color: palette.foregroundSecondary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
