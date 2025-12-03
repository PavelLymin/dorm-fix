import 'package:dorm_fix/src/features/request/src/widget/photo_picker.dart';
import 'package:ui_kit/ui.dart';
import 'choosing_service.dart';
import 'date_time_picker.dart';
import 'description_text.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  final _descriptionController = TextEditingController();
  // int _choosenMasterId = -1;

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: AppPadding.symmetricIncrement(horizontal: 3, vertical: 2),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                UiText.headlineLarge(
                  'Создание заявки',
                  style: TextStyle(
                    color: Theme.of(context).colorPalette.primary,
                  ),
                ),
                const SizedBox(height: 80),
                UiText.titleMedium('Выберите мастера'),
                const SizedBox(height: 8),
                ChoosingService(onTap: (id) => {}),
                const SizedBox(height: 16),
                UiText.titleMedium('Укажите дату и время'),
                const SizedBox(height: 8),
                const DateTimePicker(),
                const SizedBox(height: 16),
                UiText.titleMedium('Опишите проблему'),
                const SizedBox(height: 8),
                DescriptionText(controller: _descriptionController),
                const SizedBox(height: 16),
                UiText.titleMedium('Добавьте фото'),
                const SizedBox(height: 8),
                const PhotoPicker(),
                const SizedBox(height: 24),
                SizedBox(
                  height: 48,
                  width: .infinity,
                  child: UiButton.filledPrimary(
                    onPressed: () {},
                    label: UiText.titleMedium('Создать заявку'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
