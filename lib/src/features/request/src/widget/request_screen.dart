import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../request.dart';
import 'choosing_service.dart';
import 'date_time_picker.dart';
import 'description_text.dart';
import 'photo_picker.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  final _descriptionController = TextEditingController();
  late RequestFormBloc _requestFormBloc;

  @override
  void initState() {
    super.initState();
    _requestFormBloc = RequestFormBloc();
  }

  @override
  void dispose() {
    _requestFormBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => _requestFormBloc,
    child: SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: AppPadding.symmetricIncrement(horizontal: 3, vertical: 2),
            child: Column(
              crossAxisAlignment: .stretch,
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
                const ChoosingService(),
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
