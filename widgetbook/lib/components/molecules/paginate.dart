import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Pagination Widget', type: DSPaginateWidget)
Widget textStyles(BuildContext context) {
  return const Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Page 1'),
        DSPaginateWidget(
          total: 10,
          currentPage: 2,
        ),
      ],
    ),
  );
}
