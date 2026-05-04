import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../request.dart';

class PhotoPicker extends StatelessWidget {
  const PhotoPicker({super.key, this.style = const PhotoPickerStyle()});

  final PhotoPickerStyle style;

  @override
  Widget build(BuildContext context) {
    return UiCard.standart(
      child: BlocBuilder<RequestFormBloc, RequestFormState>(
        buildWhen: (previous, current) =>
            previous.currentFormModel.problems.length !=
            current.currentFormModel.problems.length,
        builder: (context, state) {
          final images = state.currentFormModel.problems;
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
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: .spaceBetween,
      crossAxisAlignment: .center,
      mainAxisSize: .max,
      children: [
        UiText2.m('Фотографии'),
        UiButton.icon(
          onPressed: onPressed,
          icon: Icon(
            Icons.chevron_right_rounded,
            color: theme.colorPalette2.secondary,
          ),
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
    final palette = theme.colorPalette2;
    return UiButton.icon(
      statesController: controller,
      onPressed: onPressed,
      icon: Icon(
        Icons.add_outlined,
        size: pickerStyle.iconAddSize,
        color: AppWidgetStateMap({
          WidgetState.disabled: palette.disabledIcon,
          WidgetState.any: palette.foreground,
        }).resolve(controller.value),
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
    final theme = Theme.of(context);
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
          child: UiText2.m(
            '${widget.imagePaths.length}/5 фото добавлены',
            color: theme.colorPalette2.secondary,
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
      child: ListView.separated(
        controller: scrollController,
        scrollDirection: .horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: imagePaths.length,
        itemBuilder: (_, index) {
          final path = imagePaths[index];
          return _Item(pickerStyle: style, path: path, index: index);
        },
        separatorBuilder: (context, index) => const SizedBox(width: 8.0),
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
    final palette = theme.colorPalette2;
    return Stack(
      alignment: .topRight,
      children: [
        ClipRRect(
          borderRadius: const .all(.circular(12.0)),
          child: Image.file(
            File(path),
            height: pickerStyle.photoSquare,
            width: pickerStyle.photoSquare,
            fit: .cover,
          ),
        ),
        Padding(
          padding: const .all(AppSpacing.xxxs),
          child: UiButton.icon(
            onPressed: () => _onPressed(context),
            icon: Icon(
              Icons.clear,
              fontWeight: .w700,
              size: pickerStyle.iconClearSize,
              color: palette.foregroundAccent,
            ),
            style: ButtonStyle(
              backgroundColor: .all(palette.primary),
              minimumSize: .all(const .square(24.0)),
              shape: .all(const CircleBorder()),
            ),
          ),
        ),
      ],
    );
  }
}

class PhotoPickerStyle {
  const PhotoPickerStyle({
    this.spacing = 8.0,
    this.iconAddSize = 32.0,
    this.iconClearSize = 16.0,
    this.buttonAddPadding = const .symmetric(horizontal: 32.0, vertical: 32.0),
    this.photoPadding = const .symmetric(horizontal: 8.0),
  });

  final double spacing;
  final double iconAddSize;
  final double iconClearSize;
  final EdgeInsetsGeometry buttonAddPadding;
  final EdgeInsetsGeometry photoPadding;

  double get photoSquare => buttonAddPadding.vertical + iconAddSize;
}
