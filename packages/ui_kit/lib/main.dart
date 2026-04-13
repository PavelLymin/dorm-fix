import 'dart:math' as math;

import 'package:ui_kit/carousel_preview.dart';
import 'package:ui_kit/detail_card_preview.dart';
import 'package:ui_kit/ui.dart';
import 'button_previews.dart';
import 'check_box_preview.dart';
import 'choice_options_preview.dart';
import 'color_palette_preview.dart';
import 'drop_down_button_preview.dart';
import 'tile_group_preview.dart';
import 'line_calendar_preview.dart';
import 'pin_preview.dart';
import 'snack_bar_preview.dart';
import 'stepper_preview.dart';
import 'switch_preview.dart';
import 'text_fields_preview.dart';
import 'typography_preview.dart';
import 'bottom_sheet_preview.dart';

final themeModeSwitcher = ValueNotifier<ThemeMode>(.light);

void main() async => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) => WindowSizeScope(
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      // darkTheme: darkTheme,
      theme: lightTheme,
      home: const UiPreview(),
    ),
  );
}

class UiPreview extends StatefulWidget {
  const UiPreview({super.key});

  @override
  State<UiPreview> createState() => _UiPreviewState();
}

class _UiPreviewState extends State<UiPreview>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(
          duration: const Duration(milliseconds: 500),
          reverseDuration: const Duration(seconds: 9),
          vsync: this,
        )..addStatusListener((status) {
          if (status == .completed) {
            _controller.reverse();
          }
        });
  }

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
                icon: brightness == .light
                    ? const Icon(Icons.dark_mode_rounded)
                    : const Icon(Icons.light_mode_rounded),
                onPressed: () {
                  themeModeSwitcher.value = brightness == .light
                      ? .dark
                      : .light;
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
                  alignment: .center,
                  child: UiText2.h5Bold('Color palette'),
                ),
                const SizedBox(height: 8),
                const ColorPalettePreview(),
                const SizedBox(height: 24),
                Align(alignment: .center, child: UiText2.h5Bold('Buttons')),
                const SizedBox(height: 8),
                const ButtonsPreview(),
                const SizedBox(height: 24),
                Align(alignment: .center, child: UiText2.h5Bold('Typography')),
                const SizedBox(height: 8),
                const TypographyPreview(),
                const SizedBox(height: 24),
                Align(alignment: .center, child: UiText2.h5Bold('Text Fields')),
                const SizedBox(height: 8),
                const TextFieldsPreview(),
                const SizedBox(height: 24),
                Align(alignment: .center, child: UiText2.h5Bold('Pin')),
                const SizedBox(height: 8),
                const PinCodePreview(),
                const SizedBox(height: 24),
                Align(
                  alignment: .center,
                  child: UiText2.h5Bold('Grouped List'),
                ),
                const SizedBox(height: 8),
                const TileGroupPreview(),
                const SizedBox(height: 24),
                Align(alignment: .center, child: UiText2.h5Bold('Switch')),
                const SizedBox(height: 8),
                const SwitchPreview(),
                const SizedBox(height: 24),
                Align(
                  alignment: .center,
                  child: UiText2.h5Bold('Bottom sheet'),
                ),
                const SizedBox(height: 8),
                const BottomSheetPreview(),
                const SizedBox(height: 24),
                Align(alignment: .center, child: UiText2.h5Bold('CheckBox')),
                const SizedBox(height: 8),
                const CheckBoxPreview(),
                const SizedBox(height: 24),
                Align(alignment: .center, child: UiText2.h5Bold('Stepper')),
                const SizedBox(height: 8),
                const StepperPreview(),
                const SizedBox(height: 24),
                Align(
                  alignment: .center,
                  child: UiText2.h5Bold('Drop down button'),
                ),
                const SizedBox(height: 8),
                const DropDownButtonPreview(),
                const SizedBox(height: 24),
                Align(alignment: .center, child: UiText2.h5Bold('Detail card')),
                const SizedBox(height: 8),
                const DetailCardPreview(),
                const SizedBox(height: 24),
                Align(
                  alignment: .center,
                  child: UiText2.h5Bold('Line Calendar'),
                ),
                const SizedBox(height: 8),
                const LineCalendarPreview(),
                const SizedBox(height: 24),
                Align(alignment: .center, child: UiText2.h5Bold('Choice chip')),
                const SizedBox(height: 8),
                ChoiceChipPreview(),
                const SizedBox(height: 24),
                Align(alignment: .center, child: UiText2.h5Bold('Snack Bar')),
                const SizedBox(height: 8),
                const SnackBarPreview(),

                const CarouselPreview(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
