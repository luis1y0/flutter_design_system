import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Home Screen', type: DSHomeScreen)
Widget buildTextFieldExample(BuildContext context) {
  return const DSHomeScreen();
}
