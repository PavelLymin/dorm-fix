import 'package:ui_kit/ui.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorPalette;
    return Positioned(
      bottom: 0.0,
      child: SafeArea(
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: Padding(
            padding: AppPadding.allMedium,
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                padding: AppPadding.allMedium,
                decoration: BoxDecoration(
                  color: theme.accent.withValues(alpha: 0.2),
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
