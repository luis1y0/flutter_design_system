import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_helpers.dart';

void main() {
  testWidgets('Signup form first build test', (WidgetTester tester) async {
    await tester.pumpWidget(wrapWithMaterialApp(const DSSignupForm()));

    final emailFinder =
        find.byKey(const ValueKey(DSTextConstants.keyFieldEmail));
    final passwordFinder =
        find.byKey(const ValueKey(DSTextConstants.keyFieldPassword));
    final confirmPasswordFinder =
        find.byKey(const ValueKey(DSTextConstants.keyFieldConfirmPassword));
    expect(emailFinder, findsOneWidget);
    expect(passwordFinder, findsOneWidget);
    expect(confirmPasswordFinder, findsOneWidget);
    final emailWidget = tester.widget<DSTextField>(emailFinder);
    final passwordWidget = tester.widget<DSTextField>(passwordFinder);
    final confirmPasswordWidget =
        tester.widget<DSTextField>(confirmPasswordFinder);
    expect(emailWidget.state, DSTextFieldState.activated);
    expect(passwordWidget.state, DSTextFieldState.activated);
    expect(confirmPasswordWidget.state, DSTextFieldState.disabled);
  });
  testWidgets('Signup form activate confirm password test',
      (WidgetTester tester) async {
    await tester.pumpWidget(wrapWithMaterialApp(const DSSignupForm()));

    final emailFinder =
        find.byKey(const ValueKey(DSTextConstants.keyFieldEmail));
    final passwordFinder =
        find.byKey(const ValueKey(DSTextConstants.keyFieldPassword));
    final confirmPasswordFinder =
        find.byKey(const ValueKey(DSTextConstants.keyFieldConfirmPassword));
    // type text to email and password
    await tester.tap(emailFinder);
    await tester.pumpAndSettle();
    tester.testTextInput.enterText('user@mail.com');
    await tester.pumpAndSettle();
    await tester.tap(passwordFinder);
    await tester.pumpAndSettle();
    tester.testTextInput.enterText('qwertyuiop');
    await tester.pumpAndSettle();
    // check confirm password state has changed
    final emailWidget = tester.widget<DSTextField>(emailFinder);
    final passwordWidget = tester.widget<DSTextField>(passwordFinder);
    final confirmPasswordWidget =
        tester.widget<DSTextField>(confirmPasswordFinder);
    expect(emailWidget.state, DSTextFieldState.activated);
    expect(passwordWidget.state, DSTextFieldState.activated);
    expect(confirmPasswordWidget.state, DSTextFieldState.activated);
  });
}
