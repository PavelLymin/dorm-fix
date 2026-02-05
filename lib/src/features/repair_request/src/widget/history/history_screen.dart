import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../request.dart';
import 'search_appbar.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<RepairRequestBloc>().add(.get());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: UiButton.filledPrimary(
        onPressed: () => context.router.push(const NamedRoute('RequestScreen')),
        icon: const Icon(Icons.add_outlined),
        label: UiText.titleMedium('Создать заявку'),
      ),
      body: CustomScrollView(
        slivers: const [SearchAppBar(), RepairRequestList()],
      ),
    );
  }
}
