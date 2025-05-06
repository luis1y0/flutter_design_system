import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart';
// main.dart
import 'package:widgetbook_workspace/utils/page_opener.dart'
    if (dart.library.html) 'package:widgetbook_workspace/utils/web_page_opener.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '\nFlutter Design System Documentation',
              style: DSTextStyles.title(),
              textAlign: TextAlign.center,
            ),
            RichText(
              text: TextSpan(
                text: '\n\n',
                style: DSTextStyles.base().copyWith(
                  color:
                      DesignSystemProvider.of(context).colorScheme.dark.color,
                ),
                children: [
                  const TextSpan(
                    text: 'A demo for a design system using ',
                  ),
                  TextSpan(
                    text: 'Atom Design',
                    style: DSTextStyles.actionable().copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(
                      text: ' in Flutter. You can see in the next links the '
                          'source used to build this widgetbook documentation:'),
                  TextSpan(text: '\n${''.padLeft(8)}'),
                  const WidgetSpan(
                    child: Icon(Icons.arrow_right_rounded),
                    baseline: TextBaseline.alphabetic,
                    alignment: PlaceholderAlignment.middle,
                  ),
                  TextSpan(
                    text: 'Design System Source',
                    mouseCursor: SystemMouseCursors.click,
                    style: DSTextStyles.actionable().copyWith(
                      color: DesignSystemProvider.of(context)
                          .colorScheme
                          .secondary
                          .color,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        if (kIsWeb) {
                          PageOpener.openUrl(
                              'https://github.com/luis1y0/flutter_design_system');
                        }
                      },
                  ),
                  TextSpan(text: '\n${''.padLeft(8)}'),
                  const WidgetSpan(
                    child: Icon(Icons.arrow_right_rounded),
                    baseline: TextBaseline.alphabetic,
                    alignment: PlaceholderAlignment.middle,
                  ),
                  TextSpan(
                    text: 'Widgetbook Source',
                    mouseCursor: SystemMouseCursors.click,
                    style: DSTextStyles.actionable().copyWith(
                      color: DesignSystemProvider.of(context)
                          .colorScheme
                          .secondary
                          .color,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        if (kIsWeb) {
                          PageOpener.openUrl(
                              'https://github.com/luis1y0/flutter_design_system/tree/main/widgetbook');
                        }
                      },
                  ),
                  TextSpan(text: '\n${''.padLeft(8)}'),
                  const WidgetSpan(
                    child: Icon(Icons.arrow_right_rounded),
                    baseline: TextBaseline.alphabetic,
                    alignment: PlaceholderAlignment.middle,
                  ),
                  TextSpan(
                    text: 'Github Action used to deploy',
                    mouseCursor: SystemMouseCursors.click,
                    style: DSTextStyles.actionable().copyWith(
                      color: DesignSystemProvider.of(context)
                          .colorScheme
                          .secondary
                          .color,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        if (kIsWeb) {
                          PageOpener.openUrl(
                              'https://github.com/luis1y0/flutter_design_system/blob/main/.github/workflows/widgetbook-gh-pages.yaml');
                        }
                      },
                  ),
                  const TextSpan(
                    text: '\n\nI can get contacted through LinkedIn:',
                  ),
                  TextSpan(text: '\n${''.padLeft(8)}'),
                  WidgetSpan(
                    child: Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/c/ca/LinkedIn_logo_initials.png/64px-LinkedIn_logo_initials.png?20140125013055',
                      height: 16,
                    ),
                    baseline: TextBaseline.alphabetic,
                    alignment: PlaceholderAlignment.middle,
                  ),
                  TextSpan(
                    text: '  linkedin.com/in/luis1y0',
                    mouseCursor: SystemMouseCursors.click,
                    style: DSTextStyles.actionable().copyWith(
                      color: DesignSystemProvider.of(context)
                          .colorScheme
                          .secondary
                          .color,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        if (kIsWeb) {
                          PageOpener.openUrl(
                              'https://www.linkedin.com/in/luis1y0');
                        }
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
