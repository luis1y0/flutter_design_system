import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// TODO: split tests in different files to separate for example tests related
  /// to each screen.
  testWidgets('Signup form first build test', (WidgetTester tester) async {
    await tester.pumpWidget(wrapWidget(const DSSignupForm()));

    final emailFinder = find.byKey(const ValueKey('email_signup_field'));
    final passwordFinder = find.byKey(const ValueKey('password_signup_field'));
    final confirmPasswordFinder =
        find.byKey(const ValueKey('confirm_password_signup_field'));
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
    await tester.pumpWidget(wrapWidget(const DSSignupForm()));

    final emailFinder = find.byKey(const ValueKey('email_signup_field'));
    final passwordFinder = find.byKey(const ValueKey('password_signup_field'));
    final confirmPasswordFinder =
        find.byKey(const ValueKey('confirm_password_signup_field'));
    // type text to email and password
    tester.tap(emailFinder);
    tester.pumpAndSettle();
    tester.testTextInput.enterText('user@mail.com');
    tester.pumpAndSettle();
    tester.tap(passwordFinder);
    tester.pumpAndSettle();
    tester.testTextInput.enterText('qwertyuiop');
    tester.pumpAndSettle();
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

Widget wrapWidget(Widget child) {
  return DesignSystemProvider(
    colorScheme: DSColorScheme(
      primary: DSColor(color: const Color(0xFFF273B2), isLight: true),
      secondary: DSColor(color: const Color(0xFF0099FF), isLight: false),
      tertiary: DSColor(color: const Color(0xFF4C3BB2), isLight: false),
      success: DSColor(color: const Color(0xFF2DBF34), isLight: true),
      error: DSColor(color: const Color(0xFFDE3730), isLight: false),
      dark: DSColor(color: const Color(0xFF003F5F), isLight: false),
      light: DSColor(color: const Color(0xFFF1F5FF), isLight: true),
      backgroundDisabled: DSColor(
          color: const Color.fromARGB(255, 163, 173, 201), isLight: true),
      disabled: DSColor(
          color: const Color.fromARGB(255, 134, 140, 174), isLight: true),
    ),
    child: MaterialApp(
      home: Scaffold(
        body: child,
      ),
    ),
  );
}
