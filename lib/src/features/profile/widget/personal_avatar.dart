import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../state_management/profile_bloc/profile_bloc.dart';

class PersonalAvatar extends StatelessWidget {
  const PersonalAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    final colorPallete = Theme.of(context).colorPalette;
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return state.maybeMap(
          orElse: () => const SizedBox.shrink(),
          loadedStudent: (state) {
            final student = state.student;
            final photoUrl = student.user.photoURL;
            return Column(
              crossAxisAlignment: .center,
              children: [
                CircleAvatar(
                  radius: 56.0,
                  backgroundColor: colorPallete.primary,
                  backgroundImage: photoUrl != null
                      ? NetworkImage(photoUrl)
                      : null,
                ),
                const SizedBox(height: 16),
                UiText.titleLarge(
                  student.user.displayName ?? '',
                  style: TextStyle(color: colorPallete.primary),
                ),
                UiText.titleLarge(student.dormitory.name),
                UiText.titleLarge(student.room.number.toString()),
              ],
            );
          },
        );
      },
    );
  }
}
