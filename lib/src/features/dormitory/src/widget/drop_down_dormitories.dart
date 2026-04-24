import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../dormitory.dart';

class DropDownDormitories extends StatefulWidget {
  const DropDownDormitories({super.key, this.initialId, this.onSelected});

  final int? initialId;
  final void Function(int?)? onSelected;

  @override
  State<DropDownDormitories> createState() => _DropDownDormitoriesState();
}

class _DropDownDormitoriesState extends State<DropDownDormitories> {
  @override
  void initState() {
    super.initState();
    context.read<DormitoryBloc>().add(.get());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DormitoryBloc, DormitoryState>(
      builder: (context, state) {
        final items = state.dormitories
            .map((d) => DropdownMenuEntry<int>(label: d.name, value: d.id))
            .toList();
        return UiDropDownButton<int>(
          hintText: 'Общежитие',
          initialSelection: widget.initialId,
          selectOnly: true,
          textAlign: .start,
          width: MediaQuery.sizeOf(context).width - AppInsets.screen.horizontal,
          dropdownMenuEntries: items,
          onSelected: widget.onSelected,
        );
      },
    );
  }
}
