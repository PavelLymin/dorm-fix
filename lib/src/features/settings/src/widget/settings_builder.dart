import 'package:flutter/material.dart';
import '../../settings.dart';

class SettingsBuilder extends StatefulWidget {
  const SettingsBuilder({required this.builder, super.key});

  final Widget Function(BuildContext context, SettingsEntity settings) builder;

  @override
  State<SettingsBuilder> createState() => _SettingsBuilderState();
}

class _SettingsBuilderState extends State<SettingsBuilder> {
  @override
  Widget build(BuildContext context) {
    final service = SettingsScope.of(context).settingsService;

    return StreamBuilder(
      stream: service.stream,
      initialData: service.current,
      builder: (context, snapshot) {
        return widget.builder(context, snapshot.data ?? const SettingsEntity());
      },
    );
  }
}
