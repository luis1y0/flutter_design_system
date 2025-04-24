import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart';

enum DSFabButtonVariant { accent, outlined, flattened }

class DSFabButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final DSFabButtonVariant variant;
  const DSFabButton({
    super.key,
    required this.child,
    this.onPressed,
    this.variant = DSFabButtonVariant.accent,
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
              border: Border.all(
                color: ds.colorScheme.secondary.color,
                width: 1.0,
              ),
            );
          case DSActionableState.disabled:
            return DSStyle(
              background: ds.colorScheme.backgroundDisabled,
              textStyle: DSTextStyles.actionable().copyWith(
                color: ds.colorScheme.disabled.color,
              ),
              border: Border.all(
                color: ds.colorScheme.disabled.color,
                width: 1.0,
              ),
            );
          case DSActionableState.pressed || DSActionableState.hovered:
            return DSStyle(
              background: color,
              textStyle: DSTextStyles.actionable().copyWith(
                color: color.isLight
                    ? ds.colorScheme.dark.color
                    : ds.colorScheme.light.color,
              ),
              border: Border.all(
                color: ds.colorScheme.secondary.color,
                width: 1.0,
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
            side: variant == DSFabButtonVariant.outlined
                ? style.border!.top
                : BorderSide.none,
          ),
          constraints: const BoxConstraints(
            maxHeight: 48.0,
            minHeight: 48.0,
            maxWidth: 48.0,
            minWidth: 48.0,
          ),
          onPressed: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: child,
          ),
        );
      },
    );
  }

  DSColor _getBackgroundColor(DSColorScheme colorScheme) {
    switch (variant) {
      case DSFabButtonVariant.accent:
        return colorScheme.primary;
      case DSFabButtonVariant.flattened || DSFabButtonVariant.outlined:
        return colorScheme.light;
      default:
        return colorScheme.light;
    }
  }
}
