import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../request.dart';

class PhotoPicker extends StatelessWidget {
  const PhotoPicker({super.key});

  @override
  Widget build(BuildContext context) {
    final colorPalette = Theme.of(context).colorPalette;
    return SizedBox(
      height: 150,
      width: .infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colorPalette.secondary,
          borderRadius: const .all(.circular(16)),
        ),
        child: BlocBuilder<RequestFormBloc, RequestFormState>(
          buildWhen: (previous, current) =>
              previous.currentFormModel.imagePaths.length !=
              current.currentFormModel.imagePaths.length,
          builder: (context, state) {
            final images = state.currentFormModel.imagePaths;
            if (images.isEmpty) {
              return const _EmptyListImages();
            } else {
              return _ListImages(imagePaths: images);
            }
          },
        ),
      ),
    );
  }
}

class _EmptyListImages extends StatelessWidget {
  const _EmptyListImages();

  @override
  Widget build(BuildContext context) {
    final colorPalette = Theme.of(context).colorPalette;
    return Column(
      mainAxisAlignment: .center,
      children: [
        UiButton.icon(
          onPressed: () => context.read<RequestFormBloc>().add(.addImages()),
          icon: const Icon(Icons.photo, size: 32),
          style: ButtonStyle(backgroundColor: .all(colorPalette.secondary)),
        ),
        UiText.labelMedium('Фото'),
      ],
    );
  }
}

class _ListImages extends StatelessWidget {
  const _ListImages({required this.imagePaths});

  final List<String> imagePaths;

  @override
  Widget build(BuildContext context) => Padding(
    padding: AppPadding.verticalIncrement(increment: 2),
    child: ListView.builder(
      scrollDirection: .horizontal,
      itemCount: imagePaths.length,
      itemBuilder: (context, index) {
        final path = imagePaths[index];
        return _ImageWrapper(path: path, index: index);
      },
    ),
  );
}

class _ImageWrapper extends StatelessWidget {
  const _ImageWrapper({required this.path, required this.index});

  final String path;
  final int index;

  @override
  Widget build(BuildContext context) => Padding(
    padding: AppPadding.horizontal,
    child: Stack(
      children: [
        ClipRRect(
          borderRadius: const .all(.circular(8)),
          child: Image.file(File(path)),
        ),
        Padding(
          padding: AppPadding.allSmall,
          child: UiButton.icon(
            onPressed: () =>
                context.read<RequestFormBloc>().add(.deleteImage(index: index)),
            icon: const Icon(Icons.clear, size: 16),
            style: ButtonStyle(
              padding: const WidgetStatePropertyAll<EdgeInsets>(.all(2.0)),
              minimumSize: const WidgetStatePropertyAll<Size>(.square(8.0)),
            ),
          ),
        ),
      ],
    ),
  );
}
