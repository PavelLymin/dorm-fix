import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../../repair_request/request.dart';
import 'history_filter.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    log(context.read<RepairRequestBloc>().toString());
    return Scaffold(
      appBar: AppBar(title: Text('История заявок')),
      body: SafeArea(
        child: Padding(
          padding: AppInsets.screen,
          child: CustomScrollView(
            slivers: [
              const HistorySearch(),
              const HistoryFilter(),
              const SliverPadding(
                padding: .only(top: 24.0),
                sliver: RepairRequest(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
