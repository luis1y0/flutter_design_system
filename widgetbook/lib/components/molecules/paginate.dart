import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:widgetbook/widgetbook.dart';

@widgetbook.UseCase(name: 'Pagination Widget', type: DSPaginateWidget)
Widget textStyles(BuildContext context) {
  final pageNumber = context.knobs.int.slider(
    label: 'Page Number',
    initialValue: 1,
    min: 1,
    max: 100,
  );
  final paginationController = DSPaginateController(
    listener: ValueNotifier(1),
  );
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ValueListenableBuilder<int>(
          valueListenable: paginationController.listener,
          builder: (context, page, child) {
            return Text('Page $page');
          },
        ),
        Container(
          decoration: const BoxDecoration(),
          child: DSPaginateWidget(
            controller: paginationController,
            total: pageNumber,
          ),
        ),
      ],
    ),
  );
}
