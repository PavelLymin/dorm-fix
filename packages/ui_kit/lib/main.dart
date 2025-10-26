import 'dart:math' as math;

import 'package:ui_kit/button_previews.dart';
import 'package:ui_kit/text_fields_preview.dart';
import 'package:ui_kit/typography_preview.dart';
import 'pin_preview.dart';
import 'package:ui_kit/ui.dart';

final themeModeSwitcher = ValueNotifier(ThemeMode.system);

void main() {
  runApp(const MainApp());
}

final lightTheme = createThemeData(
  brightness: Brightness.light,
  palette: lightColorPalette,
  typography: defaultTypography,
);

final darkTheme = createThemeData(
  brightness: Brightness.dark,
  palette: darkColorPalette,
  typography: defaultTypography,
);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) => WindowSizeScope(
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: darkTheme,
      theme: lightTheme,
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
      backgroundColor: Theme.of(context).colorPalette.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).colorPalette.background,
            surfaceTintColor: Theme.of(context).colorPalette.background,
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
                PinScope(child: const PinPreview()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
