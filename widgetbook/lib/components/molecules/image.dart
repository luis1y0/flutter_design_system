import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:widgetbook/widgetbook.dart';

@widgetbook.UseCase(name: 'Image Widget', type: DSImage)
Widget buildImageWidget(BuildContext context) {
  final imageUrl = context.knobs.string(
    label: 'Image URL',
    initialValue: 'https://picsum.photos/id/0/300',
  );
  return Center(
    child: DSImage(src: imageUrl),
  );
}
