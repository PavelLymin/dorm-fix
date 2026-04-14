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
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: AppInsets.screen,
              sliver: SliverSafeArea(
                sliver: SliverMainAxisGroup(
                  slivers: [
                    const SliverAppBar(
                      title: Text('Создание заявки'),
                      toolbarHeight: 42.0,
                    ),
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
                      child: DescriptionText(
                        controller: _descriptionController,
                      ),
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
                        child: UiButton.filledPrimary(
                          onPressed: _submitForm,
                          label: Text('Отправить заявку'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
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
    final imageRepository = ProblemImageRepositoryImpl(picker: ImagePicker());
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
