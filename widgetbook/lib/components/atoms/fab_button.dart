import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'FabButton', type: DSFabButton)
Widget textStyles(BuildContext context) {
  final dsProvider = DesignSystemProvider.of(context);
  final colorScheme = dsProvider.colorScheme;
  return Center(
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        DSFabButton(
          onPressed: () {},
          variant: DSFabButtonVariant.accent,
          child: DSIcon(
            Icons.done,
            color: DSColor(
              color: colorScheme.light.color,
              isLight: true,
            ),
          ),
        ),
        DSFabButton(
          onPressed: () {},
          variant: DSFabButtonVariant.outlined,
          child: DSIcon(
            Icons.done,
            color: DSColor(
              color: colorScheme.secondary.color,
              isLight: true,
            ),
          ),
        ),
        DSFabButton(
          onPressed: () {},
          variant: DSFabButtonVariant.flattened,
          child: DSIcon(
            Icons.done,
            color: DSColor(
              color: colorScheme.dark.color,
              isLight: true,
            ),
          ),
        ),
        DSFabButton(
          onPressed: () {},
          variant: DSFabButtonVariant.outlined,
          child: const DSText('1'),
        ),
        DSFabButton(
          onPressed: () {},
          variant: DSFabButtonVariant.outlined,
          child: const DSText('2'),
        ),
        DSFabButton(
          onPressed: () {},
          variant: DSFabButtonVariant.outlined,
          child: const DSText('3'),
        ),
      ],
    ),
  );
}
