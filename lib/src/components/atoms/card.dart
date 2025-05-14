import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart';

class DSCard extends StatelessWidget {
  final Widget child;
  const DSCard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final dsProvider = DesignSystemProvider.of(context);
    final colorScheme = dsProvider.colorScheme;
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: colorScheme.light.color,
        borderRadius: const BorderRadius.all(Radius.circular(32)),
        border: Border.all(
          color: colorScheme.light.color,
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.light.color,
            offset: const Offset(4, 4),
            blurRadius: 16,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: child,
    );
  }
}
