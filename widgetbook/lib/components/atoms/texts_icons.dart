import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Text and Icons', type: DSText)
Widget buildWidgets(BuildContext context) {
  final colorScheme = DesignSystemProvider.of(context).colorScheme;
  return SafeArea(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Texts and Icons adapting their color to the '
            'background used by the app color scheme with DSActionableWidget widget'),
        Expanded(
          child: GridView(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 250,
            ),
            children: [
              DSActionableWidget(
                defineStyle: (state, ds) {
                  return DSStyle(
                    background: ds.colorScheme.dark,
                    textStyle: DSTextStyles.actionable().copyWith(
                      color: ds.colorScheme.light.color,
                    ),
                  );
                },
                builder: (context, state, style) {
                  final bgColor =
                      style.background?.color ?? colorScheme.light.color;
                  return Container(
                    color: bgColor,
                    alignment: Alignment.center,
                    child: const DSText('Example Text'),
                  );
                },
              ),
              DSActionableWidget(
                defineStyle: (state, ds) {
                  return DSStyle(
                    background: ds.colorScheme.light,
                    textStyle: DSTextStyles.actionable().copyWith(
                      color: ds.colorScheme.dark.color,
                    ),
                  );
                },
                builder: (context, state, style) {
                  final bgColor =
                      style.background?.color ?? colorScheme.light.color;
                  return Container(
                    color: bgColor,
                    alignment: Alignment.center,
                    child: const DSText('Example Text'),
                  );
                },
              ),
              DSActionableWidget(
                defineStyle: (state, ds) {
                  return DSStyle(
                    background: ds.colorScheme.dark,
                    textStyle: DSTextStyles.actionable().copyWith(
                      color: ds.colorScheme.light.color,
                      decorationColor: ds.colorScheme.light.color,
                    ),
                  );
                },
                builder: (context, state, style) {
                  final bgColor =
                      style.background?.color ?? colorScheme.light.color;
                  return Container(
                    color: bgColor,
                    alignment: Alignment.center,
                    child: const DSLinkText('Example Text'),
                  );
                },
              ),
              DSActionableWidget(
                defineStyle: (state, ds) {
                  return DSStyle(
                    background: ds.colorScheme.light,
                    textStyle: DSTextStyles.actionable().copyWith(
                      color: ds.colorScheme.dark.color,
                      decorationColor: ds.colorScheme.dark.color,
                    ),
                  );
                },
                builder: (context, state, style) {
                  final bgColor =
                      style.background?.color ?? colorScheme.light.color;
                  return Container(
                    color: bgColor,
                    alignment: Alignment.center,
                    child: const DSLinkText('Example Text'),
                  );
                },
              ),
              DSActionableWidget(
                defineStyle: (state, ds) {
                  return DSStyle(
                    background: ds.colorScheme.dark,
                    textStyle: DSTextStyles.actionable().copyWith(
                      color: ds.colorScheme.light.color,
                    ),
                  );
                },
                builder: (context, state, style) {
                  final bgColor =
                      style.background?.color ?? colorScheme.light.color;
                  return Container(
                    color: bgColor,
                    alignment: Alignment.center,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DSIcon(Icons.done),
                        DSText('Example Text'),
                      ],
                    ),
                  );
                },
              ),
              DSActionableWidget(
                defineStyle: (state, ds) {
                  return DSStyle(
                    background: ds.colorScheme.light,
                    textStyle: DSTextStyles.actionable().copyWith(
                      color: ds.colorScheme.dark.color,
                    ),
                  );
                },
                builder: (context, state, style) {
                  final bgColor =
                      style.background?.color ?? colorScheme.light.color;
                  return Container(
                    color: bgColor,
                    alignment: Alignment.center,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DSIcon(Icons.done),
                        DSText('Example Text'),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
