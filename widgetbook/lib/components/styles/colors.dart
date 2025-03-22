import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Color Scheme', type: DSColorScheme)
Widget textStyles(BuildContext context) {
  final dsProvider = DesignSystemProvider.of(context);
  final colorScheme = dsProvider.colorScheme;
  return GridView(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
    ),
    children: [
      Container(
        color: colorScheme.primary.color,
        child: const Text('Primary'),
      ),
      Container(
        color: colorScheme.secondary.color,
        child: const Text('Secondary'),
      ),
      Container(
        color: colorScheme.tertiary.color,
        child: const Text(
          'Tertiary',
          style: TextStyle(color: Colors.white),
        ),
      ),
      Container(
        color: colorScheme.light.color,
        child: const Text('Light'),
      ),
      Container(
        color: colorScheme.dark.color,
        child: const Text(
          'Dark',
          style: TextStyle(color: Colors.white),
        ),
      ),
      Container(
        color: colorScheme.success.color,
        child: const Text('Success'),
      ),
      Container(
        color: colorScheme.error.color,
        child: const Text(
          'Error',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ],
  );
}
