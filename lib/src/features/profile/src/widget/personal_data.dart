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
    final icon = const Icon(Icons.chevron_right_rounded);
    return <TileGroupItem>[
      TileGroupItem(
        title: localizations.email_address,
        sufixIcon: icon,
        prefixIcon: Icon(Icons.email_outlined),
        subTitle: user.email ?? 'Укажите почту',
        onTap: () => showUiBottomSheet(
          context,
          title: localizations.email_address,
          isScrollControlled: true,
          widget: EmailAddressEdit(initialText: user.email ?? ''),
        ),
      ),
      TileGroupItem(
        title: localizations.phone_number,
        sufixIcon: icon,
        prefixIcon: Icon(Icons.phone_rounded),
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
    final icon = const Icon(Icons.chevron_right_rounded);
    return _createGeneralDataList(context, student.user)
      ..addAll(<TileGroupItem>[
        TileGroupItem(
          title: localizations.dormitory,
          sufixIcon: icon,
          prefixIcon: Icon(Icons.apartment),
          subTitle: localizations.dormitory_name(student.dormitory.number),
          onTap: () {},
        ),
        TileGroupItem(
          title: localizations.room,
          sufixIcon: icon,
          prefixIcon: Icon(Icons.room_outlined),
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
    final icon = const Icon(Icons.chevron_right_rounded);
    return _createGeneralDataList(context, master.user)..addAll(<TileGroupItem>[
      TileGroupItem(
        title: localizations.dormitory,
        sufixIcon: icon,
        prefixIcon: Icon(Icons.apartment),
        subTitle: localizations.dormitory_name(master.dormitory.number),
        onTap: () {},
      ),
    ]);
  }
}
