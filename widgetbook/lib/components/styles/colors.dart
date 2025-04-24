import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Color Scheme', type: DSColorScheme)
Widget textStyles(BuildContext context) {
  final dsProvider = DesignSystemProvider.of(context);
  final colorScheme = dsProvider.colorScheme;
  final light = colorScheme.light.color;
  return GridView(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
    ),
    children: [
      Container(
        color: colorScheme.primary.color,
        alignment: Alignment.center,
        child: const Text('Primary'),
      ),
      Container(
        color: colorScheme.secondary.color,
        alignment: Alignment.center,
        child: DSText('Secondary', style: TextStyle(color: light)),
      ),
      Container(
        color: colorScheme.tertiary.color,
        alignment: Alignment.center,
        child: Text('Tertiary', style: TextStyle(color: light)),
      ),
      Container(
        color: colorScheme.light.color,
        alignment: Alignment.center,
        child: const Text('Light'),
      ),
      Container(
        color: colorScheme.dark.color,
        alignment: Alignment.center,
        child: Text('Dark', style: TextStyle(color: light)),
      ),
      Container(
        color: colorScheme.error.color,
        alignment: Alignment.center,
        child: DSText('Error', style: TextStyle(color: light)),
      ),
      Container(
        color: colorScheme.success.color,
        alignment: Alignment.center,
        child: const DSText('Success'),
      ),
      Container(
        color: colorScheme.backgroundDisabled.color,
        alignment: Alignment.center,
        child: const DSText('Disabled Background'),
      ),
      Container(
        color: colorScheme.disabled.color,
        alignment: Alignment.center,
        child: const DSText('Disabled color'),
      ),
    ],
  );
}
