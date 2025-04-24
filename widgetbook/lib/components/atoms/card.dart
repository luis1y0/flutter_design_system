import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Card', type: DSCard)
Widget textStyles(BuildContext context) {
  return Center(
    child: SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.8,
      child: DSCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DSText(
              'Example title',
              style: DSTextStyles.cardTitle(),
            ),
            DSText(
              'Example subtitle',
              style: DSTextStyles.cardSubtitle(),
            ),
            const FlutterLogo(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DSButton(
                  onPressed: () {},
                  variant: DSButtonVariant.tertiary,
                  child: const DSText('Cancel'),
                ),
                const SizedBox(
                  width: 16,
                ),
                DSButton(
                  onPressed: () {},
                  variant: DSButtonVariant.primary,
                  child: const DSText('Accept'),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
