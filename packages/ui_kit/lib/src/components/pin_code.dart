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

  void _onFocusChanged() => setState(() {});

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

  bool _isFilled(int index) => index < _pinCode.length;

  @override
  Widget build(BuildContext context) => Column(
    mainAxisAlignment: .center,
    mainAxisSize: .min,
    children: [
      Opacity(
        opacity: 0,
        child: SizedBox(
          height: 0,
          child: TextField(
            controller: widget.controller,
            focusNode: _focusNode,
            enabled: widget.isEnable,
            keyboardType: .number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            maxLength: widget.length,
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          if (widget.isFocus) {
            setState(() => _focusNode.requestFocus());
          }
        },
        child: SizedBox(
          height: 66.0,
          child: Row(
            mainAxisAlignment: .spaceEvenly,
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
      ),
    ],
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
    final palette = Theme.of(context).colorPalette2;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: isCurrentFocus ? 56 : 51,
      height: isCurrentFocus ? 66 : 56,
      decoration: BoxDecoration(
        color: palette.card,
        borderRadius: const .all(.circular(16.0)),
      ),
      child: Center(
        child: number.isEmpty && isCurrentFocus
            ? Padding(
                padding: const .symmetric(vertical: 12.0, horizontal: 16.0),
                child: Container(color: palette.primary, width: 2),
              )
            : UiText2.m(number),
      ),
    );
  }
}
