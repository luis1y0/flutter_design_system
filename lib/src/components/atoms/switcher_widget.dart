import 'package:flutter/material.dart';

class DSSwitcherWidget extends StatelessWidget {
  const DSSwitcherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const AnimatedSwitcher(
      duration: Duration(seconds: 1),
    );
  }
}

class DSSwitcher extends InheritedWidget {
  const DSSwitcher({required super.child, super.key});

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static DSSwitcher of(BuildContext context) {
    final switcher = context.dependOnInheritedWidgetOfExactType<DSSwitcher>();
    assert(switcher != null, 'Be sure calling from a DSSwitcherWidget child.');
    return switcher!;
  }
}
