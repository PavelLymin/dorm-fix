import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ui_kit/ui.dart';
import '../../../../../app/widget/dependencies_scope.dart';
import '../../../../../core/utils/src/error_util.dart';
import '../../../../students/home/home.dart';
import '../../../request.dart';
import 'choosing_service.dart';
import 'line_calendar_picker.dart';
import 'description_text.dart';
import 'photo_picker.dart';
import 'time_picker.dart';

class FormRequestScreen extends StatefulWidget {
  const FormRequestScreen({super.key});

  @override
  State<FormRequestScreen> createState() => _FormRequestScreenState();
}

class _FormRequestScreenState extends State<FormRequestScreen>
    with _RequestScreenStateMixin {
  @override
  Widget build(BuildContext context) => Scaffold(
    body: MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _requestFormBloc),
        BlocProvider.value(value: _specializationBloc),
      ],
      child: BlocListener<RepairRequestBloc, RepairRequestState>(
        listener: (context, state) => state.mapOrNull(
          error: (state) => ErrorUtil.showSnackBar(context, state.message),
        ),
        child: Padding(
          padding: AppInsets.screen,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                title: const Text('Создание заявки'),
                pinned: true,
                flexibleSpace: ClipRect(
                  child: BackdropFilter(
                    filter: .blur(sigmaX: .9, sigmaY: 4.0),
                    child: SizedBox.expand(),
                  ),
                ),
              ),
              SliverList.list(
                children: [
                  const SizedBox(height: 16.0),
                  UiText2.lBold('Выберите мастера или услугу'),
                  const SizedBox(height: 10.0),
                  const ChoosingService(),
                  const SizedBox(height: 24.0),
                  UiText2.lBold('Укажите дату'),
                  const SizedBox(height: 10.0),
                  const LineCalendarPicker(),
                  const SizedBox(height: 24.0),
                  UiText2.lBold('Укажите  время'),
                  const SizedBox(height: 10.0),
                  const TimePicker(),
                  const SizedBox(height: 24.0),
                  UiText2.lBold('Опишите проблему'),
                  const SizedBox(height: 10.0),
                  DescriptionText(controller: _descriptionController),
                  const SizedBox(height: 24.0),
                  UiText2.lBold('Загрузите фотографии'),
                  const SizedBox(height: 10.0),
                  const PhotoPicker(),
                  const SizedBox(height: 32.0),
                  UiButton.filledPrimary(
                    onPressed: _submitForm,
                    label: Text('Отправить заявку'),
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

mixin _RequestScreenStateMixin on State<FormRequestScreen> {
  final _descriptionController = TextEditingController();
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

  void _submitForm() {
    final request = _requestFormBloc.state.currentFormModel;
    context.read<RepairRequestBloc>().add(.create(request: request));
    _descriptionController.clear();
    _requestFormBloc.add(.clearForm());
  }
}
