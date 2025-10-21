import '../ui.dart';

class BaseButton extends StatelessWidget {
  const BaseButton({
    required this.onPressed,
    required this.isEnable,
    required this.widget,
    super.key,
  });
  final void Function()? onPressed;
  final bool isEnable;
  final Widget widget;

  @override
  Widget build(BuildContext context) => ElevatedButton(
    onPressed: !isEnable ? null : onPressed,
    style: ButtonStyle(
      foregroundColor: !isEnable
          ? WidgetStatePropertyAll<Color>(
              Theme.of(context).extension<ThemeColors>()!.disableTextColor,
            )
          : null,
      fixedSize: WidgetStatePropertyAll<Size>(Size(double.maxFinite, 60)),
      backgroundColor: !isEnable
          ? WidgetStatePropertyAll<Color>(
              Theme.of(context).extension<ThemeColors>()!.disableButtonColor,
            )
          : null,
    ),
    child: widget,
  );
}
