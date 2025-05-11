import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_helpers.dart';

void main() {
  testWidgets('Initial signin form state test', (WidgetTester tester) async {
    await tester.pumpWidget(wrapWithMaterialApp(const DSSigninForm()));
    final emailFind = find.byKey(const ValueKey('email_field'));
    final passwordFind = find.byKey(const ValueKey('password_field'));
    expect(emailFind, findsOne);
    expect(passwordFind, findsOne);
    final emailWidget = tester.widget<DSTextField>(emailFind);
    final passwordWidget = tester.widget<DSTextField>(emailFind);
    expect(emailWidget.state, DSTextFieldState.activated);
    expect(passwordWidget.state, DSTextFieldState.activated);
    // TODO: test toggle icon show password is disabled
  });
  testWidgets('Input wrong formatted values test', (WidgetTester tester) async {
    expect(true, isFalse);
  });
  testWidgets('Input correct values enable signin button test',
      (WidgetTester tester) async {
    expect(true, isFalse);
  });
}
