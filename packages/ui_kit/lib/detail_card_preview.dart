import 'package:ui_kit/ui.dart';

enum DetailCardStatus { success, error, warning }

class DetailCardPreview extends StatelessWidget {
  const DetailCardPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return UiDetailCard<DetailCardStatus>(
      onTap: () {},
      statusText: DetailCardStatus.success.name,
      status: .success,
      colors: const {
        .success: Colors.green,
        .error: Colors.red,
        .warning: Colors.yellow,
      },
      title: 'Title',
      subTitle1: 'Sub title 1',
      subTitle2: 'Sub title 2',
      images: const [
        'https://static.vecteezy.com/system/resources/thumbnails/060/843/811/small/close-up-of-raindrops-on-leaves-hd-background-luxury-hd-wallpaper-image-trendy-background-illustration-free-photo.jpg',
        'https://static.vecteezy.com/system/resources/thumbnails/060/843/811/small/close-up-of-raindrops-on-leaves-hd-background-luxury-hd-wallpaper-image-trendy-background-illustration-free-photo.jpg',
        'https://static.vecteezy.com/system/resources/thumbnails/060/843/811/small/close-up-of-raindrops-on-leaves-hd-background-luxury-hd-wallpaper-image-trendy-background-illustration-free-photo.jpg',
      ],
    );
  }
}
