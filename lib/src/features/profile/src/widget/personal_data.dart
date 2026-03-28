import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../../../l10n/gen/app_localizations.dart';
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
    final localizations = AppLocalizations.of(context);
    final icon = const Icon(Icons.chevron_right_rounded);
    return <GroupedListItem>[
      GroupedListItem(
        title: UiText.bodyMedium(localizations.email_address),
        prefixIcon: Icon(Icons.email_outlined),
        subTitle: UiText.bodyMedium(user.email ?? 'Укажите почту'),
        onTap: () => showUiBottomSheet(
          context,
          title: localizations.email_address,
          isScrollControlled: true,
          widget: EmailAddressEdit(initialText: user.email ?? ''),
        ),
        content: icon,
      ),
      GroupedListItem(
        title: UiText.bodyMedium(localizations.phone_number),
        prefixIcon: Icon(Icons.phone_rounded),
        subTitle: UiText.bodyMedium(user.phoneNumber ?? 'Укажите телефон'),
        onTap: () => showUiBottomSheet(
          title: localizations.phone_number,
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
    final localizations = AppLocalizations.of(context);
    final icon = const Icon(Icons.chevron_right_rounded);
    return _createGeneralDataList(context, student)..addAll(<GroupedListItem>[
      GroupedListItem(
        title: UiText.bodyMedium(localizations.dormitory),
        prefixIcon: Icon(Icons.apartment),
        subTitle: UiText.bodyMedium(
          localizations.dormitory_name(student.dormitory.number),
        ),
        onTap: () {},
        content: icon,
      ),
      GroupedListItem(
        title: UiText.bodyMedium(localizations.room),
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
    final localizations = AppLocalizations.of(context);
    final icon = const Icon(Icons.chevron_right_rounded);
    return _createGeneralDataList(context, master)..addAll(<GroupedListItem>[
      GroupedListItem(
        title: UiText.bodyMedium(localizations.dormitory),
        prefixIcon: Icon(Icons.apartment),
        subTitle: UiText.bodyMedium(
          localizations.dormitory_name(master.dormitory.number),
        ),
        onTap: () {},
        content: icon,
      ),
    ]);
  }
}
