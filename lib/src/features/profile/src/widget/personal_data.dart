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
          loading: (_) => Shimmer(
            child: GroupedList(
              items: _createPersonalDataList(
                context,
                FakeFullStudent(),
                textStyle,
              ),
              divider: .indented(),
            ),
          ),
          loadedStudent: (state) {
            final student = state.student;
            final items = _createPersonalDataList(context, student, textStyle);
            return GroupedList(divider: .indented(), items: items);
          },
        );
      },
    );
  }

  List<GroupedListItem> _createPersonalDataList(
    BuildContext context,
    FullStudent student,
    TextStyle dataStyle,
  ) {
    final icon = const Icon(Icons.chevron_right_rounded);

    return <GroupedListItem>[
      GroupedListItem(
        title: UiText.bodyMedium('Адрес электронной почты'),
        prefixIcon: Icon(Icons.email_outlined),
        subTitle: UiText.bodyMedium(student.user.email ?? 'Укажите почту'),
        onTap: () => showUiBottomSheet(
          context,
          title: 'Адрес электронной почты',
          isScrollControlled: true,
          widget: EmailAddressEdit(initialText: student.user.email ?? ''),
        ),
        content: icon,
      ),
      GroupedListItem(
        title: UiText.bodyMedium('Номер телефона'),
        prefixIcon: Icon(Icons.phone_rounded),
        subTitle: UiText.bodyMedium(
          student.user.phoneNumber ?? 'Укажите телефон',
        ),
        onTap: () => showUiBottomSheet(
          title: 'Номер телефона',
          context,
          isScrollControlled: true,
          widget: PhoneNumberEdit(initialText: student.user.phoneNumber ?? ''),
        ),
        content: icon,
      ),
      GroupedListItem(
        title: UiText.bodyMedium('Общежитие'),
        prefixIcon: Icon(Icons.apartment),
        subTitle: UiText.bodyMedium(student.dormitory.name),
        onTap: () {},
        content: icon,
      ),
      GroupedListItem(
        title: UiText.bodyMedium('Комната'),
        prefixIcon: Icon(Icons.room_outlined),
        subTitle: UiText.bodyMedium(student.room.number),
        onTap: () {},
        content: icon,
      ),
    ];
  }
}
