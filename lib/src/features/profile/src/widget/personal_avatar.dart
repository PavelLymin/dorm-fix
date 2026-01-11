import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../profile.dart';

class PersonalAvatar extends StatelessWidget {
  const PersonalAvatar({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<ProfileBloc, ProfileState>(
    builder: (context, state) {
      return state.maybeMap(
        orElse: () => const SizedBox.shrink(),
        loadedStudent: (state) {
          final student = state.student;
          return _PersonalAvatarView(
            photoUrl: student.user.photoURL,
            displayName: student.user.displayName,
            dormitory: student.dormitory.name,
            room: student.room.number,
          );
        },
      );
    },
  );
}

class _PersonalAvatarView extends StatelessWidget {
  const _PersonalAvatarView({
    this.photoUrl,
    this.displayName,
    this.dormitory,
    this.room,
  });

  final String? photoUrl;
  final String? displayName;
  final String? dormitory;
  final String? room;

  @override
  Widget build(BuildContext context) {
    final colorPalette = Theme.of(context).colorPalette;
    return UiCard.standart(
      padding: AppPadding.allMedium,
      child: Row(
        crossAxisAlignment: .center,
        mainAxisAlignment: .start,
        spacing: 24.0,
        children: [
          CircleAvatar(
            radius: 40.0,
            backgroundColor: colorPalette.secondary,
            backgroundImage: photoUrl != null ? NetworkImage(photoUrl!) : null,
          ),
          Column(
            mainAxisAlignment: .center,
            crossAxisAlignment: .start,
            children: [
              UiText.titleLarge(
                displayName ?? 'User',
                style: TextStyle(color: colorPalette.primary),
              ),
              UiText.titleMedium(dormitory ?? ''),
              UiText.titleMedium(room ?? ''),
            ],
          ),
        ],
      ),
    );
  }
}
