import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../request.dart';

class PhotoPicker extends StatelessWidget {
  const PhotoPicker({super.key, this.style = const PhotoPickerStyle()});

  final PhotoPickerStyle style;

  @override
  Widget build(BuildContext context) {
    return UiCard.standart(
      padding: AppPadding.allMedium,
      child: BlocBuilder<RequestFormBloc, RequestFormState>(
        buildWhen: (previous, current) =>
            previous.currentFormModel.imagePaths.length !=
            current.currentFormModel.imagePaths.length,
        builder: (context, state) {
          final images = state.currentFormModel.imagePaths;
          return _Content(
            pickerStyle: style,
            imagePaths: images,
            isDisabled: images.length == 5,
          );
        },
      ),
    );
  }
}

class _TitlePicker extends StatelessWidget {
  const _TitlePicker({required this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .spaceBetween,
      crossAxisAlignment: .center,
      mainAxisSize: .max,
      children: [
        UiText.titleMedium('Фотографии'),
        UiButton.icon(
          onPressed: onPressed,
          icon: const Icon(Icons.chevron_right_rounded),
        ),
      ],
    );
  }
}

class _ButtonAdd extends StatelessWidget {
  const _ButtonAdd({
    required this.pickerStyle,
    required this.controller,
    required this.onPressed,
  });

  final PhotoPickerStyle pickerStyle;
  final WidgetStatesController controller;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette;
    final style = theme.appStyleData.style;
    return UiButton.icon(
      statesController: controller,
      onPressed: onPressed,
      icon: Icon(
        Icons.add_outlined,
        size: pickerStyle.iconAddSize,
        color: AppWidgetStateMap({
          WidgetState.disabled: palette.borderStrong,
          WidgetState.any: palette.foreground,
        }).resolve(controller.value),
      ),
      style: ButtonStyle(
        padding: .all(pickerStyle.buttonAddPadding),
        backgroundColor: AppWidgetStateMap({
          WidgetState.disabled: palette.muted,
          WidgetState.any: palette.secondary,
        }),
        side: .all(
          BorderSide(color: palette.borderStrong, width: style.borderWidth),
        ),
      ),
    );
  }
}

class _Content extends StatefulWidget {
  const _Content({
    required this.pickerStyle,
    required this.imagePaths,
    this.isDisabled = false,
  });

  final PhotoPickerStyle pickerStyle;
  final List<String> imagePaths;
  final bool isDisabled;

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  final _scrollController = ScrollController();
  late final WidgetStatesController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WidgetStatesController({if (widget.isDisabled) .disabled});
  }

  @override
  void didUpdateWidget(covariant _Content oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.update(.disabled, widget.isDisabled);
  }

  void _jumpToEnd() {
    if (widget.imagePaths.isEmpty) return;

    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
  }

  void _onPressed(BuildContext context) =>
      context.read<RequestFormBloc>().add(.addImages());

  @override
  Widget build(BuildContext context) {
    bool isEmpty = widget.imagePaths.isEmpty;

    return Column(
      mainAxisAlignment: .center,
      crossAxisAlignment: isEmpty ? .center : .start,
      spacing: widget.pickerStyle.spacing,
      children: [
        _TitlePicker(onPressed: _jumpToEnd),
        Row(
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          mainAxisSize: .min,
          spacing: widget.pickerStyle.spacing,
          children: [
            _ButtonAdd(
              pickerStyle: widget.pickerStyle,
              controller: _controller,
              onPressed: () => _onPressed(context),
            ),
            if (!isEmpty)
              Expanded(
                child: _Photos(
                  scrollController: _scrollController,
                  style: widget.pickerStyle,
                  imagePaths: widget.imagePaths,
                ),
              ),
          ],
        ),
        Align(
          alignment: .centerStart,
          child: UiText.titleMedium(
            '${widget.imagePaths.length}/5 фото добавлены',
          ),
        ),
      ],
    );
  }
}

class _Photos extends StatelessWidget {
  const _Photos({
    required this.scrollController,
    required this.style,
    required this.imagePaths,
  });

  final ScrollController scrollController;
  final PhotoPickerStyle style;
  final List<String> imagePaths;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: style.photoSquare,
      child: ListView.builder(
        controller: scrollController,
        scrollDirection: .horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: imagePaths.length,
        itemExtent: style.photoSquare,
        itemBuilder: (_, index) {
          final path = imagePaths[index];
          return _Item(pickerStyle: style, path: path, index: index);
        },
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    required this.pickerStyle,
    required this.path,
    required this.index,
  });

  final PhotoPickerStyle pickerStyle;
  final String path;
  final int index;

  void _onPressed(BuildContext context) =>
      context.read<RequestFormBloc>().add(.deleteImage(index: index));
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette;
    final style = theme.appStyleData.style;
    return Padding(
      padding: pickerStyle.photoPadding,
      child: Stack(
        alignment: .topRight,
        children: [
          ClipRRect(
            borderRadius: const .all(.circular(8)),
            child: Image.file(
              height: pickerStyle.photoSquare,
              width: pickerStyle.photoSquare,
              fit: .cover,
              File(path),
            ),
          ),
          Padding(
            padding: AppPadding.allSmall,
            child: UiButton.icon(
              onPressed: () => _onPressed(context),
              icon: Icon(
                fontWeight: .w700,
                Icons.clear,
                size: pickerStyle.iconClearSize,
                color: palette.foreground,
              ),
              style: ButtonStyle(
                minimumSize: .all(.square(8.0)),
                padding: .all(AppPadding.allIncrement(increment: .5)),
                backgroundColor: .all(Theme.of(context).colorPalette.secondary),
                side: .all(
                  BorderSide(
                    color: palette.borderStrong,
                    width: style.borderWidth * 2,
                  ),
                ),
                shape: .all(const CircleBorder()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PhotoPickerStyle {
  const PhotoPickerStyle({
    this.spacing = 8.0,
    this.iconAddSize = 32.0,
    this.iconClearSize = 8.0,
    this.buttonAddPadding = const .symmetric(horizontal: 32, vertical: 32),
    this.photoPadding = AppPadding.horizontal,
  });

  final double spacing;
  final double iconAddSize;
  final double iconClearSize;
  final EdgeInsetsGeometry buttonAddPadding;
  final EdgeInsetsGeometry photoPadding;

  double get photoSquare => buttonAddPadding.vertical + iconAddSize;
}
