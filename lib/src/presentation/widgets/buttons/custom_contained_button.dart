import 'package:flutter/material.dart';

class CustomContainedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool fullWidth;

  const CustomContainedButton({
    super.key,
    required this.text,
    this.onPressed,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    final button = ElevatedButton(
      onPressed: onPressed,
      child: Text(text, textAlign: TextAlign.center),
    );

    if (fullWidth) {
      return SizedBox(
        width: double.infinity,
        child: button,
      );
    }

    return button;
  }
}