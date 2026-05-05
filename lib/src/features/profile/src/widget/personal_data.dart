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
          child: TileGroup(
            items: _createStudentDataList(context, const .fake()),
          ),
        ),
        authenticated: (user) {
          final items = user.authUser.mapAuthUser(
            firebase: (f) => _createGeneralDataList(context, f),
            profile: (p) => p.mapRoleUser(
              student: (s) => _createStudentDataList(context, s),
              master: (m) => _createMasterDataList(context, m),
            ),
          );
          return TileGroup(items: items);
        },
      );
    },
  );

  List<TileGroupItem> _createGeneralDataList(
    BuildContext context,
    FirebaseUser user,
  ) {
    final localizations = AppLocalizations.of(context);
    final icon = const Icon(UiIcons.chevronRight);
    return <TileGroupItem>[
      TileGroupItem(
        title: localizations.phone_number,
        sufixIcon: icon,
        prefixIcon: Icon(UiIcons.phone),
        subTitle: user.phoneNumber ?? 'Укажите телефон',
        onTap: () => showUiBottomSheet(
          title: localizations.phone_number,
          context,
          isScrollControlled: true,
          widget: PhoneNumberEdit(user: user),
        ),
      ),
    ];
  }

  List<TileGroupItem> _createStudentDataList(
    BuildContext context,
    FullStudent student,
  ) {
    final localizations = AppLocalizations.of(context);
    final icon = const Icon(UiIcons.chevronRight);
    return _createGeneralDataList(context, student.user)
      ..addAll(<TileGroupItem>[
        TileGroupItem(
          title: localizations.dormitory,
          sufixIcon: icon,
          prefixIcon: Icon(UiIcons.home),
          subTitle: localizations.dormitory_number(student.dormitory.number),
          onTap: () {},
        ),
        TileGroupItem(
          title: localizations.room,
          sufixIcon: icon,
          prefixIcon: Icon(UiIcons.key),
          subTitle: student.room.number,
          onTap: () {},
        ),
      ]);
  }

  List<TileGroupItem> _createMasterDataList(
    BuildContext context,
    MasterUser master,
  ) {
    final localizations = AppLocalizations.of(context);
    final icon = const Icon(UiIcons.chevronRight);
    return _createGeneralDataList(context, master.user)..addAll(<TileGroupItem>[
      TileGroupItem(
        title: localizations.dormitory,
        sufixIcon: icon,
        prefixIcon: Icon(UiIcons.home),
        subTitle: localizations.dormitory_number(master.dormitory.number),
        onTap: () {},
      ),
      TileGroupItem(
        title: 'Специализация',
        sufixIcon: icon,
        prefixIcon: Icon(UiIcons.key),
        subTitle: master.specialization.title,
        onTap: () {},
      ),
    ]);
  }
}
