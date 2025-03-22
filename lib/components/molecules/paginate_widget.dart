import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart';

class DSPaginateWidget extends StatelessWidget {
  final int total;
  final int currentPage;
  const DSPaginateWidget({
    super.key,
    required this.total,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        DSFabButton(
          onPressed: () {},
          child: const DSIcon(Icons.arrow_circle_left_outlined),
        ),
        const SizedBox(
          width: 4,
        ),
        DSFabButton(
          onPressed: () {},
          variant: DSFabButtonVariant.outlined,
          child: const Text('1'),
        ),
        const SizedBox(
          width: 4,
        ),
        DSFabButton(
          onPressed: () {},
          variant: DSFabButtonVariant.accent,
          child: const Text('2'),
        ),
        const SizedBox(
          width: 4,
        ),
        DSFabButton(
          onPressed: () {},
          variant: DSFabButtonVariant.flattened,
          child: const Text('...'),
        ),
        const SizedBox(
          width: 4,
        ),
        DSFabButton(
          onPressed: () {},
          variant: DSFabButtonVariant.outlined,
          child: const Text('10'),
        ),
        const SizedBox(
          width: 4,
        ),
        DSFabButton(
          onPressed: () {},
          child: const DSIcon(Icons.arrow_circle_right_outlined),
        ),
      ],
    );
  }
}
