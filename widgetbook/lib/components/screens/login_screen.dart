import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Login Screen', type: DSLoginScreen)
Widget buildTextFieldExample(BuildContext context) {
  return DSLoginScreen(
    logo: const FlutterLogo(),
    onForgotPassword: () {},
    onSigninCallback: (email, password) async {
      return const DSSigninResult.generalFail(message: 'Network Exception');
    },
    onRegisterCallback: (email, password) async {
      return const DSSignupResult.success();
    },
    onTermsAndConditions: () {},
    onPrivacyPolicy: () {},
  );
}
