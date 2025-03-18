import 'package:flutter/material.dart';
import 'package:flutter_design_system/components/components.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Primary', type: DSButton)
Widget primaryButton(BuildContext context) {
  return DSButton(
    text: context.knobs.string(
      label: 'Label',
      initialValue: 'Primary',
    ),
    onPressed: () {},
  );
}

@widgetbook.UseCase(name: 'Secondary', type: DSButton)
Widget secondaryButton(BuildContext context) {
  return DSButton(
    variant: DSButtonVariant.secondary,
    text: 'Secondary',
    onPressed: () {},
  );
}

@widgetbook.UseCase(name: 'Tertiary', type: DSButton)
Widget tertiaryButton(BuildContext context) {
  return DSButton(
    variant: DSButtonVariant.tertiary,
    text: 'Tertiary',
    onPressed: () {},
  );
}
