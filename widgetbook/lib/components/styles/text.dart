import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'TextStyle', type: DSTextStyles)
Widget textStyles(BuildContext context) {
  final style = context.knobs.list<TextStyleOption>(
    label: 'TextStyle',
    options: [
      TextStyleOption(
        'Headline',
        DSTextStyles.headline(),
      ),
      TextStyleOption(
        'Title',
        DSTextStyles.title(),
      ),
      TextStyleOption(
        'Card Title',
        DSTextStyles.cardTitle(),
      ),
      TextStyleOption(
        'Card Subtitle',
        DSTextStyles.cardSubtitle(),
      ),
      TextStyleOption(
        'Placeholder',
        DSTextStyles.placeholder(),
      ),
      TextStyleOption(
        'Quotation',
        DSTextStyles.quotation(),
      ),
      TextStyleOption(
        'Editable Quotation',
        DSTextStyles.editableQuotation(),
      ),
      TextStyleOption(
        'Actionable',
        DSTextStyles.actionable(),
      ),
    ],
  );
  return Center(
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      child: Text(
        context.knobs.string(
          label: 'Text',
          initialValue: 'Hello World',
        ),
        style: style.style,
      ),
    ),
  );
}

class TextStyleOption {
  final String label;
  final TextStyle style;

  TextStyleOption(this.label, this.style);
  @override
  String toString() {
    return label;
  }
}
