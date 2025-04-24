import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Button Type', type: DSButton)
Widget primaryButton(BuildContext context) {
  final buttonType = context.knobs.list<ButtonTypeOption>(
    label: 'Button Type',
    options: [
      ButtonTypeOption('Primary', DSButtonVariant.primary),
      ButtonTypeOption('Secondary', DSButtonVariant.secondary),
      ButtonTypeOption('Tertiary', DSButtonVariant.tertiary),
    ],
  );
  return Column(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      DSButton(
        onPressed: () {},
        variant: buttonType.type,
        child: const DSText('Enabled Button'),
      ),
      DSButton(
        variant: buttonType.type,
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            DSIcon(Icons.done),
            SizedBox(width: 8.0),
            DSText('Disabled Button'),
          ],
        ),
      ),
    ],
  );
}

class ButtonTypeOption {
  final String label;
  final DSButtonVariant type;

  ButtonTypeOption(this.label, this.type);
  @override
  String toString() {
    return label;
  }
}
