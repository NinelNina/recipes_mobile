import 'package:flutter/material.dart';
import 'package:recipes/features/common/widgets/back_icon_widget.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
    required this.text,
    required this.height,
    this.width, required this.color, required this.textColor, required this.onPressed
  });

  final String text;
  final Color color;
  final Color textColor;
  final double? width;
  final double height;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonal(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
            color),
        minimumSize: MaterialStateProperty.all<Size>(
            Size(width ?? 0, height)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Poppins',
          color: textColor,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}