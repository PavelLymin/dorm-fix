import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../profile.dart';
import 'email_phone_edit.dart';

class PersonalData extends StatelessWidget {
  const PersonalData({super.key});

  @override
  Widget build(BuildContext context) {
    final colorPallete = Theme.of(context).colorPalette;
    final textStyle = TextStyle(color: colorPallete.primary);
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return state.maybeMap(
          orElse: () => const SizedBox.shrink(),
          loadedStudent: (state) {
            final student = state.student;
            final items = _createPersonalDataList(context, student, textStyle);
            return GroupedList(items: items);
          },
        );
      },
    );
  }

  List<GroupedListItem> _createPersonalDataList(
    BuildContext context,
    FullStudentEntity student,
    TextStyle dataStyle,
  ) {
    final icon = const Icon(Icons.chevron_right_rounded);

    return <GroupedListItem>[
      GroupedListItem(
        title: 'Адрес электронной почты',
        prefixIcon: Icons.email_outlined,
        data: student.user.email ?? 'Укажите почту',
        onTap: () => showUiBottomSheet(
          isScrollControlled: true,
          context,
          widget: EmailAddressEdit(initialText: student.user.email ?? ''),
        ),
        content: icon,
      ),
      GroupedListItem(
        title: 'Номер телефона',
        prefixIcon: Icons.phone_rounded,
        data: student.user.phoneNumber ?? 'Укажите телефон',
        onTap: () => showUiBottomSheet(
          isScrollControlled: true,
          context,
          widget: PhoneNumberEdit(initialText: student.user.phoneNumber ?? ''),
        ),
        content: icon,
      ),
      GroupedListItem(
        title: 'Общежитие',
        prefixIcon: Icons.apartment,
        data: student.dormitory.name,
        onTap: () {},
        content: icon,
      ),
      GroupedListItem(
        title: 'Комната',
        prefixIcon: Icons.room_outlined,
        data: student.room.number,
        onTap: () {},
        content: icon,
      ),
    ];
  }
}
