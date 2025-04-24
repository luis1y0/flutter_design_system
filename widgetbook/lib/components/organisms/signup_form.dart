import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'SignupForm Widget', type: DSSignupForm)
Widget buildTextFieldExample(BuildContext context) {
  final result = context.knobs.list<DSSignupResult>(
    label: 'Example Response',
    options: [
      const DSSignupResult.success(),
      const DSSignupResult.generalFail(
        message: 'There was a connection error. Try later.',
      ),
      const DSSignupResult.fieldFail(
        errorEmail: 'This email is already registered.',
      ),
      const DSSignupResult.fieldFail(
        errorPassword: 'This password is not secure.',
      ),
    ],
  );
  return Center(
    child: DSSignupForm(
      onBack: () {},
      onRegister: (email, password) async {
        await Future.delayed(const Duration(seconds: 2));
        return result;
      },
    ),
  );
}
