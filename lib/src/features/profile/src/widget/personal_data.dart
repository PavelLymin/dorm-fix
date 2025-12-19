import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../profile.dart';
import 'email_phone_edit.dart';

class PersonalData extends StatefulWidget {
  const PersonalData({super.key});

  @override
  State<PersonalData> createState() => _PersonalDataState();
}

class _PersonalDataState extends State<PersonalData>
    with _PersonalDataStateMixin {
  @override
  Widget build(BuildContext context) {
    final colorPallete = Theme.of(context).colorPalette;
    final textStyle = TextStyle(color: colorPallete.primary);
    return Column(
      spacing: 8,
      crossAxisAlignment: .start,
      children: [
        UiText.titleMedium('Личные данные'),
        BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            return state.maybeMap(
              orElse: () => const SizedBox.shrink(),
              loadedStudent: (state) {
                final student = state.student;
                final items = _createPersonalDataList(
                  student,
                  colorPallete.primary,
                  textStyle,
                );
                return GroupedList(items: items, color: colorPallete.secondary);
              },
            );
          },
        ),
      ],
    );
  }
}

mixin _PersonalDataStateMixin on State<PersonalData> {
  List<GroupedListItem> _createPersonalDataList(
    FullStudentEntity student,
    Color colorText,
    TextStyle dataStyle,
  ) => <GroupedListItem>[
    GroupedListItem(
      title: UiText.labelLarge('Адрес электронной почты'),
      data: UiText.bodyMedium(
        student.user.email ?? 'Укажите почту',
        style: dataStyle,
      ),
      onTap: () => showUiBottomSheet(
        isScrollControlled: true,
        context,
        _BottomSheetWrapper(
          widget: EmailAddressEdit(initialText: student.user.email ?? ''),
        ),
      ),
    ),
    GroupedListItem(
      title: UiText.labelLarge('Номер телефона'),
      data: UiText.bodyMedium(
        student.user.phoneNumber ?? 'Укажите телефон',
        style: dataStyle,
      ),
      onTap: () => showUiBottomSheet(
        isScrollControlled: true,
        context,
        _BottomSheetWrapper(
          widget: PhoneNumberEdit(initialText: student.user.phoneNumber ?? ''),
        ),
      ),
    ),
    GroupedListItem(
      title: UiText.labelLarge('Общежитие'),
      data: UiText.bodyMedium(student.dormitory.name, style: dataStyle),
      onTap: () {},
    ),
    GroupedListItem(
      title: UiText.labelLarge('Комната'),
      data: UiText.bodyMedium(student.room.number, style: dataStyle),
      onTap: () {},
    ),
  ];
}

class _BottomSheetWrapper extends StatelessWidget {
  const _BottomSheetWrapper({required this.widget});
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: AppPadding.horizontalIncrement(
        increment: 3,
      ).add(EdgeInsets.only(bottom: bottomInset)),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: .center,
          mainAxisAlignment: .center,
          mainAxisSize: .min,
          children: [
            const SizedBox(height: 32),
            widget,
            const SizedBox(height: 64),
          ],
        ),
      ),
    );
  }
}
