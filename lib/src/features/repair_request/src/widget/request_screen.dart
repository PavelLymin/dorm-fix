import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ui_kit/ui.dart';
import '../../../../app/widget/dependencies_scope.dart';
import '../../../home/home.dart';
import '../../request.dart';
import 'choosing_service.dart';
import 'date_time_picker.dart';
import 'description_text.dart';
import 'photo_picker.dart';
import 'presence_switch.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen>
    with _RequestScreenStateMixin {
  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => _requestFormBloc),
      BlocProvider.value(value: _specializationBloc),
    ],
    child: BlocListener<RepairRequestBloc, RepairRequestState>(
      listener: (context, state) {
        state.mapOrNull(
          error: (state) => ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message))),
        );
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: AppPadding.symmetricIncrement(
                horizontal: 3,
                vertical: 2,
              ),
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
                  ChoosingService(selectedIndex: _specializationIndex),
                  const SizedBox(height: 16),
                  UiText.titleMedium('Укажите дату и время'),
                  const SizedBox(height: 8),
                  const DateTimePicker(),
                  const SizedBox(height: 16),
                  UiText.titleMedium('Опишите проблему'),
                  const SizedBox(height: 8),
                  DescriptionText(controller: _descriptionController),
                  const SizedBox(height: 16),
                  const PresenceSwitch(),
                  const SizedBox(height: 16),
                  UiText.titleMedium('Добавьте фото'),
                  const SizedBox(height: 8),
                  const PhotoPicker(),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 48,
                    child: UiButton.filledPrimary(
                      onPressed: _submitForm,
                      label: UiText.titleMedium('Создать заявку'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

mixin _RequestScreenStateMixin on State<RequestScreen> {
  final _descriptionController = TextEditingController();
  final ValueNotifier<int> _specializationIndex = ValueNotifier<int>(0);
  late final RequestFormBloc _requestFormBloc;
  late final SpecializationBloc _specializationBloc;

  @override
  void initState() {
    super.initState();
    final imageRepository = ImageRepositoryImpl(picker: ImagePicker());
    final dependency = DependeciesScope.of(context);
    _requestFormBloc = RequestFormBloc(
      imageRepository: imageRepository,
      requestRepository: dependency.requestRepository,
      logger: dependency.logger,
    );
    _specializationBloc = dependency.specializationBloc;
  }

  @override
  void dispose() {
    _specializationIndex.dispose();
    super.dispose();
  }

  void _submitForm() {
    final request = _requestFormBloc.state.currentFormModel;
    context.read<RepairRequestBloc>().add(.create(request: request));
    _specializationIndex.value = 0;
    _descriptionController.clear();
    _requestFormBloc.add(.clearForm());
  }
}
