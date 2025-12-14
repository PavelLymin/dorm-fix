import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';

import '../../request.dart';

class DescriptionText extends StatefulWidget {
  const DescriptionText({super.key, required this.controller});

  final TextEditingController controller;

  @override
  State<DescriptionText> createState() => _DescriptionTextState();
}

class _DescriptionTextState extends State<DescriptionText> {
  late final RequestFormBloc _requestFormBloc;
  @override
  void initState() {
    super.initState();
    _requestFormBloc = context.read<RequestFormBloc>();
    widget.controller.addListener(_onChange);
  }

  void _onChange() {
    _requestFormBloc.add(
      .updateRequestForm(description: widget.controller.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return UiTextField.standard(
      controller: widget.controller,
      maxLines: 5,
      maxLength: 200,
      showCounter: true,
      style: UiTextFieldStyle(hintText: 'Введите текст'),
    );
  }
}
