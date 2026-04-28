import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ui_kit/ui.dart';
import '../../../../../app/widget/dependencies_scope.dart';
import '../../../../../core/utils/src/error_util.dart';
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
        BlocProvider(create: (context) => _repairActionBloc),
      ],
      child: Scaffold(
        appBar: AppBar(title: Text('Создание заявки')),
        body: SafeArea(
          child: Padding(
            padding: AppInsets.screen,
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const .only(top: 16.0, bottom: 10.0),
                  sliver: SliverToBoxAdapter(
                    child: UiText2.lBold('Выберите мастера или услугу'),
                  ),
                ),
                const SliverToBoxAdapter(child: ChoosingService()),
                SliverPadding(
                  padding: const .only(top: 24.0, bottom: 10.0),
                  sliver: SliverToBoxAdapter(
                    child: UiText2.lBold('Укажите дату'),
                  ),
                ),
                const SliverToBoxAdapter(child: LineCalendarPicker()),
                SliverPadding(
                  padding: const .only(top: 24.0, bottom: 10.0),
                  sliver: SliverToBoxAdapter(
                    child: UiText2.lBold('Укажите  время'),
                  ),
                ),
                const SliverToBoxAdapter(child: TimePicker()),
                SliverPadding(
                  padding: const .only(top: 24.0, bottom: 10.0),
                  sliver: SliverToBoxAdapter(
                    child: UiText2.lBold('Опишите проблему'),
                  ),
                ),
                SliverToBoxAdapter(
                  child: DescriptionText(controller: _descriptionController),
                ),
                SliverPadding(
                  padding: const .only(top: 24.0, bottom: 10.0),
                  sliver: SliverToBoxAdapter(
                    child: UiText2.lBold('Загрузите фотографии'),
                  ),
                ),
                const SliverToBoxAdapter(child: PhotoPicker()),
                SliverPadding(
                  padding: .symmetric(vertical: 32.0),
                  sliver: SliverToBoxAdapter(
                    child: ButtonForm(onPressed: _submitForm),
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

class ButtonForm extends StatelessWidget {
  const ButtonForm({super.key, required this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return BlocListener<RepairActionBloc, RepairActionState>(
          listener: (context, state) => state.mapOrNull(
            error: (state) => ErrorUtil.showSnackBar(context, state.message),
          ),
          child: UiButton.filledPrimary(
            onPressed: onPressed,
            label: Text('Отправить'),
          ),
        );
      },
    );
  }
}

mixin _RequestScreenStateMixin on State<FormRequestScreen> {
  final _descriptionController = TextEditingController();
  late final RequestFormBloc _requestFormBloc;
  late final RepairActionBloc _repairActionBloc;

  @override
  void initState() {
    super.initState();
    final imageRepository = ProblemImageRepositoryImpl(picker: ImagePicker());
    final dependency = DependeciesScope.of(context);
    _requestFormBloc = RequestFormBloc(
      imageRepository: imageRepository,
      requestRepository: dependency.requestRepository,
      logger: dependency.logger,
    );
    _repairActionBloc = RepairActionBloc(
      requestRepository: dependency.requestRepository,
      problemRepository: dependency.problemRepository,
      logger: dependency.logger,
    );
  }

  void _submitForm() {
    final request = _requestFormBloc.state.currentFormModel;
    context.read<RepairActionBloc>().add(.create(request: request));
    _descriptionController.clear();
    _requestFormBloc.add(.clearForm());
  }
}
