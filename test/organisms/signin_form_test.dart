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
    final iconFind = find.byIcon(Icons.visibility);
    final iconSwitchFind =
        find.descendant(of: passwordFind, matching: iconFind);
    expect(iconSwitchFind, findsOneWidget);
  });
  testWidgets('Input wrong formatted values test', (WidgetTester tester) async {
    await tester.pumpWidget(wrapWithMaterialApp(const DSSigninForm()));
    final emailFind = find.byKey(const ValueKey('email_field'));
    final passwordFind = find.byKey(const ValueKey('password_field'));
    var emailWidget = tester.widget<DSTextField>(emailFind);
    var passwordWidget = tester.widget<DSTextField>(passwordFind);
    expect(emailWidget.state, DSTextFieldState.activated);
    expect(passwordWidget.state, DSTextFieldState.activated);
    await inputLoginValues(
      tester: tester,
      emailFind: emailFind,
      email: 'wrong email',
      passwordFind: passwordFind,
      password: 'passwd',
    );
    emailWidget = tester.widget<DSTextField>(emailFind);
    passwordWidget = tester.widget<DSTextField>(passwordFind);
    expect(emailWidget.state, DSTextFieldState.error);
    expect(passwordWidget.state, DSTextFieldState.error);
  });
  testWidgets('Input correct values enable signin button test',
      (WidgetTester tester) async {
    await tester.pumpWidget(wrapWithMaterialApp(const DSSigninForm()));
    final emailFind = find.byKey(const ValueKey('email_field'));
    final passwordFind = find.byKey(const ValueKey('password_field'));
    var emailWidget = tester.widget<DSTextField>(emailFind);
    var passwordWidget = tester.widget<DSTextField>(passwordFind);
    expect(emailWidget.state, DSTextFieldState.activated);
    expect(passwordWidget.state, DSTextFieldState.activated);
    await inputLoginValues(
      tester: tester,
      emailFind: emailFind,
      email: 'user@mail.com',
      passwordFind: passwordFind,
      password: 'qwertyuiop',
    );
    emailWidget = tester.widget<DSTextField>(emailFind);
    passwordWidget = tester.widget<DSTextField>(passwordFind);
    expect(emailWidget.state, DSTextFieldState.activated);
    expect(passwordWidget.state, DSTextFieldState.activated);
  });
  testWidgets('Show and hide password pressing icon button test',
      (WidgetTester tester) async {
    await tester.pumpWidget(wrapWithMaterialApp(const DSSigninForm()));
    final passwordFind = find.byKey(const ValueKey('password_field'));
    var iconFind = find.byIcon(Icons.visibility);
    final iconShowFind = find.descendant(of: passwordFind, matching: iconFind);
    expect(iconShowFind, findsOneWidget);
    iconFind = find.byIcon(Icons.visibility_off);
    final iconHideFind = find.descendant(of: passwordFind, matching: iconFind);
    expect(iconHideFind, findsOneWidget);
  });
}

Future<void> inputLoginValues({
  required WidgetTester tester,
  required Finder emailFind,
  required String email,
  required Finder passwordFind,
  required String password,
}) async {
  await tester.tap(emailFind);
  await tester.pump();
  tester.testTextInput.enterText(email);
  await tester.pump();
  await tester.tap(passwordFind);
  await tester.pump();
  tester.testTextInput.enterText(password);
  await tester.pump();
  await tester.tap(emailFind);
  await tester.pump();
}
