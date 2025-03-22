import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart';

class DesignSystemProvider extends InheritedWidget {
  const DesignSystemProvider({
    super.key,
    required this.colorScheme,
    required super.child,
  });

  final DSColorScheme colorScheme;

  static DesignSystemProvider? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DesignSystemProvider>();
  }

  static DesignSystemProvider of(BuildContext context) {
    final DesignSystemProvider? result = maybeOf(context);
    assert(result != null, 'No [DesignSystemProvider] found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(DesignSystemProvider oldWidget) => false;
}

class DSLocalColorScheme extends InheritedWidget {
  final DSColor color;
  const DSLocalColorScheme(
      {super.key, required super.child, required this.color});

  static DSLocalColorScheme? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DSLocalColorScheme>();
  }

  static DSLocalColorScheme of(BuildContext context) {
    final DSLocalColorScheme? result = maybeOf(context);
    assert(result != null, 'No [LocalColorScheme] found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(DSLocalColorScheme oldWidget) => true;
}
