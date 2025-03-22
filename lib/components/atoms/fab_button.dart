import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart';

enum DSFabButtonVariant { accent, outlined, flattened }

class DSFabButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final DSFabButtonVariant variant;
  const DSFabButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.variant = DSFabButtonVariant.accent,
  });

  @override
  Widget build(BuildContext context) {
    final dsProvider = DesignSystemProvider.of(context);
    final colorScheme = dsProvider.colorScheme;
    switch (variant) {
      case DSFabButtonVariant.accent:
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: colorScheme.secondary.color,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: colorScheme.secondary.color,
                blurRadius: 2,
                offset: const Offset(1, 1),
              ),
            ],
          ),
          child: DSLocalColorScheme(
            color: colorScheme.secondary,
            child: child,
          ),
        );
      case DSFabButtonVariant.outlined:
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: colorScheme.light.color,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: colorScheme.secondary.color),
            boxShadow: [
              BoxShadow(
                color: colorScheme.secondary.color,
                blurRadius: 2,
                offset: const Offset(1, 1),
              ),
            ],
          ),
          child: DSLocalColorScheme(
            color: colorScheme.light,
            child: child,
          ),
        );
      case DSFabButtonVariant.flattened:
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: colorScheme.light.color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: DSLocalColorScheme(
            color: colorScheme.light,
            child: child,
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
