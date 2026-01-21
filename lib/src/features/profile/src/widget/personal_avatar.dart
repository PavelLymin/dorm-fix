import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../profile.dart';

class PersonalAvatar extends StatelessWidget {
  const PersonalAvatar({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<ProfileBloc, ProfileState>(
    builder: (context, state) {
      return state.maybeMap(
        loading: (_) => Shimmer(
          child: const _PersonalAvatarView(student: FakeFullStudentEntity()),
        ),
        loadedStudent: (state) => _PersonalAvatarView(student: state.student),
        orElse: () => const SizedBox.shrink(),
      );
    },
  );
}

class _PersonalAvatarView extends StatelessWidget {
  const _PersonalAvatarView({required this.student});

  final FullStudentEntity student;

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
            backgroundImage: student.user.photoURL != null
                ? NetworkImage(student.user.photoURL!)
                : null,
          ),
          Column(
            mainAxisAlignment: .center,
            crossAxisAlignment: .start,
            children: [
              UiText.titleLarge(
                student.user.displayName ?? 'User',
                style: TextStyle(color: colorPalette.primaryForeground),
              ),
              UiText.titleMedium(student.dormitory.name),
              UiText.titleMedium(student.room.number),
            ],
          ),
        ],
      ),
    );
  }
}
