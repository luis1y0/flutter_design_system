// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:widgetbook/widgetbook.dart' as _i1;
import 'package:widgetbook_workspace/components/atoms/button.dart' as _i2;
import 'package:widgetbook_workspace/components/atoms/card.dart' as _i3;
import 'package:widgetbook_workspace/components/atoms/fab_button.dart' as _i4;
import 'package:widgetbook_workspace/components/molecules/paginate.dart' as _i5;
import 'package:widgetbook_workspace/components/styles/colors.dart' as _i6;
import 'package:widgetbook_workspace/components/styles/text.dart' as _i7;

final directories = <_i1.WidgetbookNode>[
  _i1.WidgetbookFolder(
    name: 'components',
    children: [
      _i1.WidgetbookFolder(
        name: 'atoms',
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
          ),
          _i1.WidgetbookLeafComponent(
            name: 'DSCard',
            useCase: _i1.WidgetbookUseCase(
              name: 'Card',
              builder: _i3.textStyles,
            ),
          ),
          _i1.WidgetbookLeafComponent(
            name: 'DSFabButton',
            useCase: _i1.WidgetbookUseCase(
              name: 'FabButton',
              builder: _i4.textStyles,
            ),
          ),
        ],
      ),
      _i1.WidgetbookFolder(
        name: 'molecules',
        children: [
          _i1.WidgetbookLeafComponent(
            name: 'DSPaginateWidget',
            useCase: _i1.WidgetbookUseCase(
              name: 'Pagination Widget',
              builder: _i5.textStyles,
            ),
          )
        ],
      ),
    ],
  ),
  _i1.WidgetbookFolder(
    name: 'styles',
    children: [
      _i1.WidgetbookLeafComponent(
        name: 'DSColorScheme',
        useCase: _i1.WidgetbookUseCase(
          name: 'Color Scheme',
          builder: _i6.textStyles,
        ),
      ),
      _i1.WidgetbookLeafComponent(
        name: 'DSTextStyles',
        useCase: _i1.WidgetbookUseCase(
          name: 'TextStyle',
          builder: _i7.textStyles,
        ),
      ),
    ],
  ),
];
