import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ui_kit/ui.dart';
import '../../../../app/widget/dependencies_scope.dart';
import '../../../home/home.dart';
import '../../request.dart';
import 'choosing_service.dart';
import 'line_calendar_picker.dart';
import 'description_text.dart';
import 'photo_picker.dart';
import 'time_picker.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen>
    with _RequestScreenStateMixin {
  @override
  Widget build(BuildContext context) => Scaffold(
    body: MultiBlocProvider(
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
        child: Padding(
          padding: AppPadding.allMedium,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(title: const Text('Создание заявки'), pinned: true),
              SliverList.list(
                children: [
                  UiText.titleMedium('Выберите мастера'),
                  const SizedBox(height: 16.0),
                  ChoosingService(selectedIndex: _specializationIndex),
                  const SizedBox(height: 16.0),
                  UiText.titleMedium('Укажите дату'),
                  const SizedBox(height: 16.0),
                  const LineCalendarPicker(),
                  const SizedBox(height: 16.0),
                  UiText.titleMedium('Укажите  время'),
                  const SizedBox(height: 16.0),
                  const TimePicker(),
                  const SizedBox(height: 16.0),
                  UiText.titleMedium('Опишите проблему'),
                  const SizedBox(height: 16.0),
                  DescriptionText(controller: _descriptionController),
                  const SizedBox(height: 16.0),
                  UiText.titleMedium('Добавьте фото'),
                  const SizedBox(height: 16.0),
                  const PhotoPicker(),
                  const SizedBox(height: 32.0),
                  UiButton.filledPrimary(
                    onPressed: _submitForm,
                    label: UiText.titleMedium('Создать заявку'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

mixin _RequestScreenStateMixin on State<RequestScreen> {
  final _descriptionController = TextEditingController();
  final _specializationIndex = ValueNotifier<int>(0);
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
