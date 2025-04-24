import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'AnimatedList Widget', type: DSAnimatedListview)
Widget buildAnimatedListExample(BuildContext context) {
  final controller = DSAnimatedListController<String>(
    key: GlobalKey<AnimatedListState>(),
    itemBuilder: (context, index, item) {
      return ListTile(
        title: DSText(item),
        trailing: const DSFabButton(
          child: DSIcon(Icons.remove),
        ),
      );
    },
  );
  controller.insertItem(0, 'Java');
  controller.insertItem(0, 'Python');
  controller.insertItem(0, 'Dart');
  controller.insertItem(0, 'PHP');
  controller.insertItem(0, 'C#');
  controller.insertItem(0, 'C++');
  controller.insertItem(0, 'Rust');
  controller.insertItem(0, 'Go');
  return Padding(
    padding: const EdgeInsets.all(36.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DSTextField(
          onSubmitted: (value) {
            controller.insertItem(0, value);
          },
        ),
        Expanded(
          child: DSAnimatedListview<String>(
            controller: controller,
            itemBuilder: (context, index, item) {
              return ListTile(
                title: DSText(item),
                trailing: DSFabButton(
                  child: const DSIcon(Icons.remove),
                  onPressed: () {
                    controller.removeItem(index);
                  },
                ),
                onTap: () {},
              );
            },
          ),
        ),
      ],
    ),
  );
}
