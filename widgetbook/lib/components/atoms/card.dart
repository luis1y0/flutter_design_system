import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Card', type: DSCard)
Widget textStyles(BuildContext context) {
  return Center(
    child: SizedBox(
      width: MediaQuery.sizeOf(context).width / 2,
      child: DSCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Example title',
              style: DSTextStyles.cardTitle(),
            ),
            Text(
              'Example subtitle',
              style: DSTextStyles.cardSubtitle(),
            ),
            const FlutterLogo(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DSButton(
                  text: 'Cancel',
                  onPressed: () {},
                  variant: DSButtonVariant.tertiary,
                ),
                const SizedBox(
                  width: 16,
                ),
                DSButton(
                  text: 'Accept',
                  onPressed: () {},
                  variant: DSButtonVariant.primary,
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
