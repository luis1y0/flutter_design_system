import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart';

class DSIcon extends StatelessWidget {
  final IconData data;
  final DSColor? color;
  const DSIcon(this.data, {super.key, this.color});

  @override
  Widget build(BuildContext context) {
    final stateWidget = DSStateWidget.of(context);
    final textStyle = stateWidget?.style?.textStyle;
    return Icon(
      data,
      color: color?.color ?? textStyle?.color,
    );
  }
}
