import 'package:image_picker/image_picker.dart';

abstract interface class IImageRepository<T> {
  Future<List<T>> loadImages({int limit});
}

class ImageRepositoryImpl implements IImageRepository<XFile> {
  const ImageRepositoryImpl({required ImagePicker picker}) : _picker = picker;
  final ImagePicker _picker;

  @override
  Future<List<XFile>> loadImages({int limit = 5}) async {
    final images = await _picker.pickMultiImage(limit: limit);

    return images;
  }
}
