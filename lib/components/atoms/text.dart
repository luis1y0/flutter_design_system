import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart';

class DSText extends StatelessWidget {
  final String data;
  final TextStyle? style;
  final TextAlign? textAlign;
  const DSText(this.data, {this.style, this.textAlign, super.key});

  @override
  Widget build(BuildContext context) {
    final stateWidget = DSStateWidget.of(context);
    final textStyle = stateWidget?.style?.textStyle;
    return Text(
      data,
      style: style?.merge(textStyle) ?? textStyle,
      textAlign: textAlign,
    );
  }
}
