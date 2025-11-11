import 'package:flutter/services.dart';
import 'package:ui_kit/ui.dart';

class PinCode extends StatefulWidget {
  const PinCode({
    super.key,
    required this.controller,
    this.isFocus = false,
    this.isEnable = true,
    this.length = 6,
    this.height = 60,
  });

  final TextEditingController controller;
  final bool isFocus;
  final bool isEnable;
  final int length;
  final double height;

  @override
  State<PinCode> createState() => _PinCodeState();
}

class _PinCodeState extends State<PinCode> {
  final _focusNode = FocusNode();
  String _pinCode = '';

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    widget.controller.removeListener(_onFocusChanged);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChanged() {
    setState(() {});
  }

  void _onTextChanged() {
    String pin = widget.controller.text;

    if (pin.length <= widget.length) {
      setState(() {
        _pinCode = pin;
      });
    }
  }

  @override
  void didUpdateWidget(covariant PinCode oldWidget) {
    super.didUpdateWidget(oldWidget);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (oldWidget.isFocus != widget.isFocus) {
        if (widget.isFocus) {
          _focusNode.requestFocus();
        } else {
          _focusNode.unfocus();
        }
      }
    });
  }

  bool _isFilled(int index) {
    return index < _pinCode.length;
  }

  @override
  Widget build(BuildContext context) => SizedBox(
    height: widget.height,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Opacity(
          opacity: 0,
          child: SizedBox(
            height: 0,
            child: TextField(
              controller: widget.controller,
              focusNode: _focusNode,
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
                _focusNode.requestFocus();
              });
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              widget.length,
              (index) => PinInput(
                isFocus: _focusNode.hasFocus,
                isCurrentFocus: index == _pinCode.length && _focusNode.hasFocus,
                number: _isFilled(index) ? _pinCode[index] : '',
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
    required this.isCurrentFocus,
    required this.number,
  });

  final bool isFocus;
  final bool isCurrentFocus;
  final String number;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).colorPalette;
    Color color = isFocus ? palette.accent : palette.border;

    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: isCurrentFocus ? 45 : 40,
      height: isCurrentFocus ? 60 : 50,
      decoration: BoxDecoration(
        color: palette.secondary,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color),
      ),
      child: Center(
        child: number.isEmpty && isCurrentFocus
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
