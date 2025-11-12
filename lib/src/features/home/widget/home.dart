import 'package:ui_kit/ui.dart';

import 'carousel.dart';
import 'home_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final colorPalette = Theme.of(context).colorPalette;
    return Scaffold(
      body: WindowSizeScope.of(context).maybeMap(
        orElse: () => Padding(
          padding: AppPadding.symmetricIncrement(horizontal: 3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppBar(
                title: UiText.headlineLarge('Пользователь'),
                centerTitle: false,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SpecializationsCarousel(),
                    const SizedBox(height: 8),
                    HomeCard(
                      icon: Image.asset(
                        ImagesHelper.request,
                        height: 32,
                        width: 32,
                      ),
                      title: UiText.titleMedium('Создать заявку'),
                      subtitle: UiText.bodyLarge(
                        'Данный поиск осуществляется по тексту, вводимый пользователем ',
                        style: TextStyle(color: colorPalette.mutedForeground),
                      ),
                    ),
                    const SizedBox(height: 8),
                    HomeCard(
                      icon: Image.asset(
                        ImagesHelper.history,
                        height: 32,
                        width: 32,
                      ),
                      title: UiText.titleMedium('История завок'),
                      subtitle: UiText.bodyLarge(
                        'Данный поиск осуществляется по тексту, вводимый пользователем ',
                        style: TextStyle(color: colorPalette.mutedForeground),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// const EdgeInsets.only(bottom: 128, left: 16, right: 16)
