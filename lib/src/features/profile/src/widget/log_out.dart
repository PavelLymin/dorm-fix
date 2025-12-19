import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../authentication/authentication.dart';

class LogOut extends StatelessWidget {
  const LogOut({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorPalette.destructive;
    return GestureDetector(
      child: Row(
        mainAxisAlignment: .center,
        spacing: 8,
        children: [
          UiText.titleMedium('Выйти', color: color),
          Icon(Icons.logout_rounded, color: color),
        ],
      ),
      onTap: () {
        context.read<AuthBloc>().add(.signOut());
        context.router.replace(NamedRoute('SignIn'));
      },
    );
  }
}
