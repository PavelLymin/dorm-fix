import 'dart:math' as math;

import 'package:ui_kit/button_previews.dart';
import 'package:ui_kit/map_previews.dart';
import 'package:ui_kit/src/ui_kit_config/ui_kit_config.dart';
import 'package:ui_kit/ui.dart';
import 'package:yandex_maps_mapkit/init.dart' as init;

final themeModeSwitcher = ValueNotifier(ThemeMode.system);

void main() async {
  final mapkitApiKey = UiKitConfig.mapKitApiKey;
  await init.initMapkit(apiKey: mapkitApiKey);

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
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    darkTheme: darkTheme,
    theme: lightTheme,
    home: const MapPreviews(),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
