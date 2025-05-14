import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'SigninForm Widget', type: DSSigninForm)
Widget buildTextFieldExample(BuildContext context) {
  final result = context.knobs.list<DSSigninResult>(
    label: 'Example Response',
    options: [
      const DSSigninResult.success(),
      const DSSigninResult.generalFail(
        message: 'There was a connection error. Try later.',
      ),
      const DSSigninResult.fieldFail(
        errorEmail: 'This email hasn\'t been verified.',
      ),
    ],
  );
  return Center(
    child: DSSigninForm(
      onNavigateToSignup: () {},
      onSignin: (email, password) async {
        await Future.delayed(const Duration(seconds: 2));
        return result;
      },
    ),
  );
}
