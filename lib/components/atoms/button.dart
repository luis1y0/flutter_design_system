import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart';

enum DSButtonVariant {
  primary,
  secondary,
  tertiary,
}

class DSButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final DSButtonVariant variant;
  const DSButton({
    required this.child,
    this.onPressed,
    this.variant = DSButtonVariant.primary,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DSActionableWidget(
      onPressed: onPressed,
      defineStyle: (state, ds) {
        final color = _getBackgroundColor(ds.colorScheme);
        switch (state) {
          case DSActionableState.activated:
            return DSStyle(
              background: color,
              textStyle: DSTextStyles.actionable().copyWith(
                color: color.isLight
                    ? ds.colorScheme.dark.color
                    : ds.colorScheme.light.color,
              ),
            );
          case DSActionableState.disabled:
            return DSStyle(
              background: ds.colorScheme.backgroundDisabled,
              textStyle: DSTextStyles.actionable().copyWith(
                color: ds.colorScheme.disabled.color,
              ),
            );
          case DSActionableState.pressed || DSActionableState.hovered:
            return DSStyle(
              background: _getBackgroundColor(ds.colorScheme),
              textStyle: DSTextStyles.actionable().copyWith(
                color: color.isLight
                    ? ds.colorScheme.dark.color
                    : ds.colorScheme.light.color,
              ),
            );
          default:
            return const DSStyle();
        }
      },
      builder: (context, state, style) {
        return RawMaterialButton(
          fillColor: style.background!.color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.all(8),
          onPressed: onPressed,
          child: child,
        );
      },
    );
  }

  DSColor _getBackgroundColor(DSColorScheme colorScheme) {
    if (onPressed == null) {
      return colorScheme.backgroundDisabled;
    }
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
