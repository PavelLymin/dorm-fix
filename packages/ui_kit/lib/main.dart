import 'dart:math' as math;

import 'package:ui_kit/ui.dart';
import 'button_previews.dart';
import 'choice_options_preview.dart';
import 'color_palette_preview.dart';
import 'grouped_list_preview.dart';
import 'pin_preview.dart';
import 'switch_preview.dart';
import 'text_fields_preview.dart';
import 'typography_preview.dart';
import 'bottom_sheet_preview.dart';

final themeModeSwitcher = ValueNotifier(ThemeMode.system);

void main() async {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) => WindowSizeScope(
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: darkTheme,
      theme: darkTheme,
      home: const UiPreview(),
    ),
  );
}

class UiPreview extends StatelessWidget {
  const UiPreview({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    final brightness = Theme.of(context).brightness;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            pinned: true,
            actions: [
              UiButton.icon(
                icon: brightness == Brightness.light
                    ? const Icon(Icons.dark_mode_rounded)
                    : const Icon(Icons.light_mode_rounded),
                onPressed: () {
                  themeModeSwitcher.value = brightness == Brightness.light
                      ? ThemeMode.dark
                      : ThemeMode.light;
                },
              ),
            ],
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: math.max((size.width - 900) / 2, 16),
              vertical: 24,
            ),
            sliver: SliverList.list(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: UiText.titleLarge('Color palette'),
                ),
                const SizedBox(height: 8),
                ColorPalettePreview(),
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.center,
                  child: UiText.titleLarge('Buttons'),
                ),
                const SizedBox(height: 8),
                const ButtonsPreview(),
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.center,
                  child: UiText.titleLarge('Typography'),
                ),
                const SizedBox(height: 8),
                const TypographyPreview(),
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.center,
                  child: UiText.titleLarge('Text Fields'),
                ),
                const SizedBox(height: 8),
                const TextFieldsPreview(),
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.center,
                  child: UiText.titleLarge('Pin'),
                ),
                const SizedBox(height: 8),
                const PinCodePreview(),
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.center,
                  child: UiText.titleLarge('Grouped List'),
                ),
                const SizedBox(height: 8),
                const GroupedListPreview(),
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.center,
                  child: UiText.titleLarge('Switch'),
                ),
                const SizedBox(height: 8),
                const SwitchPreview(),
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.center,
                  child: UiText.titleLarge('Bottom sheet'),
                ),
                const SizedBox(height: 8),
                const BottomSheetPreview(),
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.center,
                  child: UiText.titleLarge('Choice options'),
                ),
                const SizedBox(height: 8),
                const ChoiceOptionsPreview(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
