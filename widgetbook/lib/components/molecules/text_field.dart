import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'TextField Widget', type: DSTextField)
Widget buildTextFieldExample(BuildContext context) {
  const exampleText = 'TextField Widget';
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DSTextField(
          controller: TextEditingController(text: exampleText),
          labelText: 'Email',
          isDense: true,
        ),
        const SizedBox(height: 8.0),
        DSTextField(
          controller: TextEditingController(text: exampleText),
          labelText: 'Password',
          isDense: true,
          state: DSTextFieldState.error,
        ),
        const SizedBox(height: 8.0),
        DSTextField(
          controller: TextEditingController(text: exampleText),
          labelText: 'Confirm Password',
          isDense: true,
          state: DSTextFieldState.disabled,
        ),
      ],
    ),
  );
}
