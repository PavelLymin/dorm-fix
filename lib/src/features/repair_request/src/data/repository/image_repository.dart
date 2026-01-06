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
    _imageList.clear();
    final images = await _picker.pickMultiImage(limit: limit);
    images.map((image) => _imageList.add(image.path)).toList();
  }

  @override
  Future<List<String>> loadImages() => Future<List<String>>.value(_imageList);

  @override
  Future<void> deleteImage(int index) async => _imageList.removeAt(index);
}
