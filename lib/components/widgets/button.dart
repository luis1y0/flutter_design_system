import 'package:flutter/material.dart';

class DSButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  const DSButton({
    required this.text,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
