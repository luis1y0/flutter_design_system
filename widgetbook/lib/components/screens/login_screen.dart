import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Login Screen', type: DSLoginScreen)
Widget buildTextFieldExample(BuildContext context) {
  return const DSLoginScreen();
}
