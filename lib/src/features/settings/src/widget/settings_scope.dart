import 'package:flutter/material.dart';

import '../injection.dart';

class SettingsScope extends InheritedWidget {
  const SettingsScope({
    required this.settingsContainer,
    required super.child,
    super.key,
  });

  final SettingsContainer settingsContainer;

  static SettingsContainer of(BuildContext context) {
    final settings = context
        .getInheritedWidgetOfExactType<SettingsScope>()
        ?.settingsContainer;
    if (settings == null) {
      throw ArgumentError(
        'Out of scope, not found inherited widget '
            'a $settings of the exact type',
        'out_of_scope',
      );
    }
    return context
        .getInheritedWidgetOfExactType<SettingsScope>()!
        .settingsContainer;
  }

  @override
  bool updateShouldNotify(covariant SettingsScope oldWidget) {
    return !identical(settingsContainer, oldWidget.settingsContainer);
  }
}
