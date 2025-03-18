import 'package:flutter/material.dart';
import 'package:flutter_design_system/colors/colors.dart';

enum DSButtonVariant {
  primary,
  secondary,
  tertiary,
}

class DSButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final DSButtonVariant variant;
  final IconData? icon;
  const DSButton({
    required this.text,
    required this.onPressed,
    this.variant = DSButtonVariant.primary,
    this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: _getBackgroundColor(),
      shape: RoundedRectangleBorder(
        side: _getBorder(),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(8),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, color: _getContentColor()),
            const SizedBox(width: 8),
          ],
          Text(
            text,
            style: TextStyle(color: _getContentColor()),
          ),
        ],
      ),
    );
  }

  Color _getBackgroundColor() {
    switch (variant) {
      case DSButtonVariant.primary:
        return DSColors.primary;
      case DSButtonVariant.secondary:
        return DSColors.secondary;
      case DSButtonVariant.tertiary:
        return DSColors.tertiary;
    }
  }

  Color _getContentColor() {
    switch (variant) {
      case DSButtonVariant.primary:
        return Colors.white;
      case DSButtonVariant.secondary:
        return Colors.white;
      case DSButtonVariant.tertiary:
        return Colors.white;
    }
  }

  BorderSide _getBorder() {
    switch (variant) {
      case DSButtonVariant.primary:
        return BorderSide.none;
      case DSButtonVariant.secondary:
        return BorderSide.none;
      case DSButtonVariant.tertiary:
        return BorderSide.none;
    }
  }
}
