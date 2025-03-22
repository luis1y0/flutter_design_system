import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart';

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
    final dsProvider = DesignSystemProvider.of(context);
    final colorScheme = dsProvider.colorScheme;
    final bgColor = _getBackgroundColor(colorScheme);
    return RawMaterialButton(
      fillColor: bgColor.color,
      shape: RoundedRectangleBorder(
        side: BorderSide.none,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(8),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              color: bgColor.isLight
                  ? colorScheme.dark.color
                  : colorScheme.light.color,
            ),
            const SizedBox(width: 8),
          ],
          Text(
            text,
            style: TextStyle(
              color: bgColor.isLight
                  ? colorScheme.dark.color
                  : colorScheme.light.color,
            ),
          ),
        ],
      ),
    );
  }

  DSColor _getBackgroundColor(DSColorScheme colorScheme) {
    switch (variant) {
      case DSButtonVariant.primary:
        return colorScheme.primary;
      case DSButtonVariant.secondary:
        return colorScheme.secondary;
      case DSButtonVariant.tertiary:
        return colorScheme.tertiary;
    }
  }
}
