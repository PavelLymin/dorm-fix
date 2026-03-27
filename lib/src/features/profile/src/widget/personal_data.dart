import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../authentication/authentication.dart';
import 'email_phone_edit.dart';

class PersonalData extends StatelessWidget {
  const PersonalData({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<AuthBloc, AuthState>(
    builder: (context, state) {
      return state.maybeMap(
        orElse: () => const SizedBox.shrink(),
        loading: (_) => Shimmer(
          child: GroupedList(
            items: _createStudentDataList(context, const .fake()),
            divider: .indented(),
          ),
        ),
        authenticated: (user) {
          final items = user.authUser.mapAuthUser(
            firebase: (_) => _createGeneralDataList(context, user.authUser),
            profile: (p) => p.mapRoleUser(
              student: (s) => _createStudentDataList(context, s),
              master: (m) => _createMasterDataList(context, m),
            ),
          );
          return GroupedList(divider: .indented(), items: items);
        },
      );
    },
  );

  List<GroupedListItem> _createGeneralDataList(
    BuildContext context,
    AuthenticatedUser user,
  ) {
    final icon = const Icon(Icons.chevron_right_rounded);
    return <GroupedListItem>[
      GroupedListItem(
        title: UiText.bodyMedium('Адрес электронной почты'),
        prefixIcon: Icon(Icons.email_outlined),
        subTitle: UiText.bodyMedium(user.email ?? 'Укажите почту'),
        onTap: () => showUiBottomSheet(
          context,
          title: 'Адрес электронной почты',
          isScrollControlled: true,
          widget: EmailAddressEdit(initialText: user.email ?? ''),
        ),
        content: icon,
      ),
      GroupedListItem(
        title: UiText.bodyMedium('Номер телефона'),
        prefixIcon: Icon(Icons.phone_rounded),
        subTitle: UiText.bodyMedium(user.phoneNumber ?? 'Укажите телефон'),
        onTap: () => showUiBottomSheet(
          title: 'Номер телефона',
          context,
          isScrollControlled: true,
          widget: PhoneNumberEdit(initialText: user.phoneNumber ?? ''),
        ),
        content: icon,
      ),
    ];
  }

  List<GroupedListItem> _createStudentDataList(
    BuildContext context,
    FullStudent student,
  ) {
    final icon = const Icon(Icons.chevron_right_rounded);
    return _createGeneralDataList(context, student)..addAll(<GroupedListItem>[
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
    ]);
  }

  List<GroupedListItem> _createMasterDataList(
    BuildContext context,
    MasterUser master,
  ) {
    final icon = const Icon(Icons.chevron_right_rounded);
    return _createGeneralDataList(context, master)..addAll(<GroupedListItem>[
      GroupedListItem(
        title: UiText.bodyMedium('Общежитие'),
        prefixIcon: Icon(Icons.apartment),
        subTitle: UiText.bodyMedium(master.dormitory.name),
        onTap: () {},
        content: icon,
      ),
    ]);
  }
}
