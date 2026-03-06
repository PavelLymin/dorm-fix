import 'package:ui_kit/ui.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final palette = context.colorPalette;
    final appPadding = context.appStyle.appPadding;
    return Positioned(
      bottom: 0.0,
      child: SafeArea(
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: Padding(
            padding: appPadding.allMedium,
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                padding: appPadding.allMedium,
                decoration: BoxDecoration(
                  color: palette.secondary.withValues(alpha: 0.2),
                  borderRadius: const .all(.circular(16)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search_rounded),
                    const SizedBox(width: 16),
                    UiText.bodyMedium('Поиск общежитий...'),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
