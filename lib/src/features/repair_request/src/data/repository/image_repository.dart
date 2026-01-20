import 'package:image_picker/image_picker.dart';

abstract interface class IImageRepository {
  Future<void> addImages({int limit});

  Future<List<String>> loadImages();

  Future<void> deleteImage(int index);
}

class ImageRepositoryImpl implements IImageRepository {
  ImageRepositoryImpl({required ImagePicker picker}) : _picker = picker;
  final ImagePicker _picker;

  final List<String> _imageList = <String>[];

  @override
  Future<void> addImages({int limit = 5}) async {
    if (_imageList.length >= limit) return;
    final lim = limit - _imageList.length;
    if (lim > 1) {
      final images = await _picker.pickMultiImage(limit: lim);
      images.map((image) => _imageList.add(image.path)).toList();
    } else {
      final image = await _picker.pickImage(source: .gallery);
      if (image == null) return;
      _imageList.add(image.path);
    }
  }

  @override
  Future<List<String>> loadImages() => Future<List<String>>.value(_imageList);

  @override
  Future<void> deleteImage(int index) async => _imageList.removeAt(index);
}
