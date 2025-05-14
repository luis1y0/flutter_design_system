import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:widgetbook_workspace/pages/home_page.dart';

// This file does not exist yet,
// it will be generated in the next step
import 'main.directories.g.dart';

void main() {
  runApp(const WidgetbookApp());
}

@widgetbook.App()
class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DesignSystemProvider(
      stringResolver: (String key) {
        return switch (key) {
          DSTextConstants.labelEmail => 'Email',
          DSTextConstants.labelPassword => 'Password',
          DSTextConstants.labelForgotPassword => 'Forgot password?',
          DSTextConstants.labelSignin => 'Sign In',
          DSTextConstants.labelCreateAccount => 'No Account? Create one',
          DSTextConstants.labelTermsConditions => 'Terms and Conditions',
          DSTextConstants.labelPrivacyPolicy => 'Privacy Policy',
          DSTextConstants.labelConfirmPassword => 'Confirm Password',
          DSTextConstants.labelSignup => 'Sign Up',
          DSTextConstants.labelNavigateLogin => 'Do you already have an '
              'account? Go to login',
          DSTextConstants.errorFieldRequired => 'This field is required',
          DSTextConstants.errorInvalidEmail => 'Use a correct email format',
          DSTextConstants.errorInvalidPassword => 'Use at least 8 characters, '
              'valid characters are letters, numbers and ,.;:<>¿?!@#\$%&*()[]'
              '{}=+-_',
          DSTextConstants.errorConfirmPassword => 'Passwords don\'t match',
          _ => key,
        };
      },
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
      child: Widgetbook.material(
        themeMode: ThemeMode.light,
        directories: directories,
        addons: [
          DeviceFrameAddon(
            devices: Devices.all,
          ),
          MaterialThemeAddon(
            themes: [
              WidgetbookTheme(name: 'Light', data: ThemeData.light()),
            ],
          ),
        ],
        home: const HomePage(),
      ),
    );
  }
}
