import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart';

class DSIcon extends StatelessWidget {
  final IconData data;
  final DSColor? color;
  const DSIcon(this.data, {super.key, this.color});

  @override
  Widget build(BuildContext context) {
    final dsProvider = DesignSystemProvider.of(context);
    final colorScheme = dsProvider.colorScheme;
    return Icon(
      data,
      color: color?.color ?? colorScheme.light.color,
    );
  }
}
