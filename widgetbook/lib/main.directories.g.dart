// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:widgetbook/widgetbook.dart' as _i1;
import 'package:widgetbook_workspace/components/widgets/button.dart' as _i2;

final directories = <_i1.WidgetbookNode>[
  _i1.WidgetbookFolder(
    name: 'components',
    children: [
      _i1.WidgetbookFolder(
        name: 'widgets',
        children: [
          _i1.WidgetbookComponent(
            name: 'DSButton',
            useCases: [
              _i1.WidgetbookUseCase(
                name: 'Primary',
                builder: _i2.primaryButton,
              ),
              _i1.WidgetbookUseCase(
                name: 'Secondary',
                builder: _i2.secondaryButton,
              ),
              _i1.WidgetbookUseCase(
                name: 'Tertiary',
                builder: _i2.tertiaryButton,
              ),
            ],
          )
        ],
      )
    ],
  )
];
