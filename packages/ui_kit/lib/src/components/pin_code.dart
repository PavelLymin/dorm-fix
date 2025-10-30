import 'package:flutter/services.dart';
import 'package:ui_kit/ui.dart';

class PinCode extends StatefulWidget {
  const PinCode({
    super.key,
    required this.controller,
    this.isFocus = false,
    this.isEnable = true,
    this.length = 6,
  });

  final TextEditingController controller;
  final bool isFocus;
  final bool isEnable;
  final int length;

  @override
  State<PinCode> createState() => _PinCodeState();
}

class _PinCodeState extends State<PinCode> {
  final _focusNodes = FocusNode();
  String _pinCode = '';
  late List<bool> _isFilled;

  @override
  void initState() {
    super.initState();
    _isFilled = List.filled(widget.length, false);
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    _focusNodes.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    String pin = widget.controller.text;

    if (pin.length <= widget.length) {
      _isFilled = List.generate(widget.length, (index) => index < pin.length);
      setState(() {
        _pinCode = pin;
      });
    }
  }

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 60,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Opacity(
          opacity: 0,
          child: SizedBox(
            height: 0,
            child: TextField(
              controller: widget.controller,
              focusNode: _focusNodes,
              enabled: widget.isEnable,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              maxLength: widget.length,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            if (widget.isFocus) {
              setState(() {
                _focusNodes.requestFocus();
              });
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              widget.length,
              (index) => PinInput(
                isFocus: _focusNodes.hasFocus,
                isCurentFocus: index > 0
                    ? _isFilled[index - 1]
                    : _focusNodes.hasFocus,
                number: _isFilled[index] ? _pinCode[index] : '',
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

class PinInput extends StatelessWidget {
  const PinInput({
    super.key,
    required this.isFocus,
    required this.isCurentFocus,
    required this.number,
  });

  final bool isFocus;
  final bool isCurentFocus;
  final String number;

  @override
  Widget build(BuildContext context) {
    late Color color;
    if (isFocus) {
      color = Theme.of(context).colorPalette.primary;
    } else {
      color = Theme.of(context).colorPalette.border;
    }

    return Container(
      width: isCurentFocus ? 45 : 40,
      height: isCurentFocus ? 60 : 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color),
      ),
      child: Center(
        child: number.isEmpty && isCurentFocus
            ? Container(
                height: 40,
                width: 1.5,
                decoration: BoxDecoration(color: color),
              )
            : UiText.bodyLarge(number),
      ),
    );
  }
}
