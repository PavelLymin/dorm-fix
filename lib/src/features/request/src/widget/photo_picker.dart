import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ui_kit/ui.dart';

import '../../request.dart';

class PhotoPicker extends StatefulWidget {
  const PhotoPicker({super.key});

  @override
  State<PhotoPicker> createState() => _PhotoPickerState();
}

class _PhotoPickerState extends State<PhotoPicker>
    with _CameraPickerStateMixin {
  @override
  Widget build(BuildContext context) {
    final colorPalette = Theme.of(context).colorPalette;
    return SizedBox(
      height: 150,
      width: .infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colorPalette.secondary,
          borderRadius: .circular(16),
        ),
        child: BlocBuilder<RequestFormBloc, RequestFormState>(
          buildWhen: (previous, current) =>
              previous.imageFileList.length != current.imageFileList.length,
          builder: (context, state) {
            final images = state.imageFileList;
            if (images.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  UiButton.icon(
                    onPressed: _loadMedia,
                    icon: const Icon(Icons.photo, size: 32),
                    style: ButtonStyle(
                      backgroundColor: .all(colorPalette.secondary),
                    ),
                  ),
                  UiText.labelMedium('Фото'),
                ],
              );
            } else {
              return Padding(
                padding: AppPadding.verticalIncrement(increment: 2),
                child: ListView.builder(
                  scrollDirection: .horizontal,
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: AppPadding.horizontal,
                      child: Image.file(File(images[index].path)),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

mixin _CameraPickerStateMixin on State<PhotoPicker> {
  late final RequestFormBloc _requestFormBloc;
  late final ImagePicker _picker;
  late final IImageRepository<XFile> _imageRepository;

  @override
  void initState() {
    super.initState();
    _requestFormBloc = context.read<RequestFormBloc>();
    _picker = ImagePicker();
    _imageRepository = ImageRepositoryImpl(picker: _picker);
  }

  Future<void> _loadMedia() async {
    if (context.mounted) {
      try {
        final images = await _imageRepository.loadImages();
        _requestFormBloc.add(
          RequestFormEvent.setRequestFormValue(imageFileList: images),
        );
      } catch (_) {}
    }
  }
}
