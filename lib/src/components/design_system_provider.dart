import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart';

class DesignSystemProvider extends InheritedWidget {
  DesignSystemProvider({
    super.key,
    required this.colorScheme,
    required this.stringResolver,
    required super.child,
  }) {
    DSString.init(stringResolver);
  }

  final DSColorScheme colorScheme;
  final DSStringResolver stringResolver;

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
