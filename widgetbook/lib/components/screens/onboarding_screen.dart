import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Onboarding Screen', type: DSOnboardingScreen)
Widget buildTextFieldExample(BuildContext context) {
  return DSOnboardingScreen(
    onSkip: () {},
    onPageViewed: (page) {},
    pages: const [
      Center(
        child: FlutterLogo(),
      ),
      Center(
        child: Placeholder(),
      ),
      Center(
        child: AboutDialog(),
      ),
    ],
  );
}
