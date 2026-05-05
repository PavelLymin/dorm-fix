import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ui_kit/ui.dart';
import '../../../../../l10n/gen/app_localizations.dart';
import '../../../../app/widget/dependencies_scope.dart';
import '../../../../core/utils/src/error_util.dart';
import '../../../authentication/authentication.dart';
import '../../profile.dart';

class NamePhotoEdit extends StatefulWidget {
  const NamePhotoEdit({super.key, required this.user});

  final FirebaseUser user;

  @override
  State<NamePhotoEdit> createState() => _NamePhotoEditState();
}

class _NamePhotoEditState extends State<NamePhotoEdit> {
  late final TextEditingController _controller;
  late final ValueNotifier<String?> _photoURL;
  late final ValueNotifier<bool> _isEnabled;
  late NamePhotoBloc _namePhotoBloc;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.user.displayName);
    final dependency = DependeciesScope.of(context);
    _namePhotoBloc = NamePhotoBloc(
      logger: dependency.logger,
      firebaseUserRepository: dependency.firebaseUserRepository,
      userRepository: dependency.userRepository,
    );
    _isEnabled = ValueNotifier<bool>(false);
    _photoURL = ValueNotifier<String?>(null);
  }

  @override
  void dispose() {
    _controller.dispose();
    _isEnabled.dispose();
    _photoURL.dispose();
    _namePhotoBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _namePhotoBloc,
      child: Padding(
        padding: .only(bottom: MediaQuery.viewInsetsOf(context).bottom),
        child: Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .start,
          mainAxisSize: .min,
          children: [
            Align(
              alignment: .center,
              child: UserAvatar(
                user: widget.user,
                isEnabled: _isEnabled,
                photoURL: _photoURL,
              ),
            ),
            const SizedBox(height: 24.0),
            UiText2.lBold(AppLocalizations.of(context).specify_name),
            const SizedBox(height: 10.0),
            UiTextField.standard(
              controller: _controller,
              autofocus: false,
              keyboardType: .name,
              textInputAction: .done,
              style: UiTextFieldStyle(
                hintText: 'Иван Иванов',
                prefixIcon: const Icon(UiIcons.userProfile),
                suffixIcon: ValueListenableBuilder<TextEditingValue>(
                  valueListenable: _controller,
                  builder: (_, value, _) {
                    if (value.text.isEmpty) return const SizedBox.shrink();
                    return IconButton(
                      icon: const Icon(UiIcons.edit),
                      onPressed: () => _controller.clear(),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            _ButtonNamePhotoUpdate(
              user: widget.user,
              controller: _controller,
              isEnabled: _isEnabled,
              photoURL: _photoURL,
            ),
          ],
        ),
      ),
    );
  }
}

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.user,
    required this.photoURL,
    this.isEnabled,
  });

  final FirebaseUser user;
  final ValueNotifier<bool>? isEnabled;
  final ValueNotifier<String?> photoURL;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette2;
    return user.isFake
        ? const Shimmer(child: CircleAvatar(radius: 37.0))
        : Stack(
            alignment: .center,
            children: [
              ValueListenableBuilder(
                valueListenable: photoURL,
                builder: (_, value, _) {
                  return CircleAvatar(
                    radius: 37.0,
                    backgroundColor: palette.secondary,
                    backgroundImage: value != null
                        ? FileImage(File(value))
                        : user.photoURL != null
                        ? NetworkImage(user.photoURL!)
                        : null,
                  );
                },
              ),
              Positioned(
                right: .0,
                bottom: .0,
                child: UiButton.icon(
                  onPressed: () async {
                    final image = await ImagePicker().pickImage(
                      source: .gallery,
                    );
                    photoURL.value = image?.path;
                    if (photoURL.value != null) {
                      isEnabled?.value = true;
                    }
                  },
                  icon: const Icon(UiIcons.edit),
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(palette.primary),
                    iconColor: WidgetStatePropertyAll(palette.foregroundAccent),
                    iconSize: const WidgetStatePropertyAll(16.0),
                    padding: const WidgetStatePropertyAll(.all(4.0)),
                    minimumSize: const WidgetStatePropertyAll(.zero),
                  ),
                ),
              ),
            ],
          );
  }
}

class _ButtonNamePhotoUpdate extends StatefulWidget {
  const _ButtonNamePhotoUpdate({
    required this.user,
    required this.controller,
    required this.isEnabled,
    required this.photoURL,
  });

  final FirebaseUser user;
  final TextEditingController controller;
  final ValueNotifier<bool> isEnabled;
  final ValueNotifier<String?> photoURL;
  @override
  State<_ButtonNamePhotoUpdate> createState() => _ButtonNamePhotoUpdateState();
}

class _ButtonNamePhotoUpdateState extends State<_ButtonNamePhotoUpdate> {
  final _nameValidator = NameValidator();

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_checkValidation);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_checkValidation);
    super.dispose();
  }

  void _checkValidation() => widget.isEnabled.value =
      widget.isEnabled.value ||
      (_nameValidator.validate(widget.controller.text) &&
          widget.controller.text != widget.user.displayName);

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
    valueListenable: widget.isEnabled,
    builder: (_, value, _) => SizedBox(
      width: .infinity,
      child: UiButton.filledPrimary(
        enabled: value,
        onPressed: () =>
            context.read<NamePhotoBloc>().add(.update(user: widget.user)),
        label: BlocConsumer<NamePhotoBloc, NamePhotoState>(
          listener: (context, state) => state.mapOrNull(
            error: (state) => ErrorUtil.showSnackBar(context, state.message),
          ),
          builder: (context, state) => state.maybeMap(
            orElse: () => Text(AppLocalizations.of(context).save),
            loading: (_) => SizedBox.square(
              dimension: 20.0,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Theme.of(context).colorPalette2.secondary,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
