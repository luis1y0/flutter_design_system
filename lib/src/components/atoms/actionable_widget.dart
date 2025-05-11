import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart';

enum DSActionableState { activated, disabled, pressed, hovered }

/// Parent widget that rebuilds its children every action state
/// like activated, disabled, pressed, hovered, etc.
/// Widgets that require being notified using these widget:
///
///  - [DSButton]
///  - [DSFabButton]
///
/// Widgets reading values from parents:
///
///  - [DSText]
///  - [DSIcon]
///
/// Access to Actionable styles through `DSStateWidget.of()`.
class DSActionableWidget extends StatefulWidget {
  final VoidCallback? onPressed;
  final Function(DSActionableState state, DesignSystemProvider ds)? defineStyle;
  final Function(BuildContext context, DSActionableState state, DSStyle style)
      builder;
  const DSActionableWidget({
    this.onPressed,
    this.defineStyle,
    required this.builder,
    super.key,
  });

  @override
  State<DSActionableWidget> createState() => _DSActionableWidgetState();
}

class _DSActionableWidgetState extends State<DSActionableWidget> {
  DSActionableState _state = DSActionableState.activated;

  @override
  void initState() {
    super.initState();
    if (widget.onPressed == null) {
      _state = DSActionableState.disabled;
    }
  }

  @override
  void didUpdateWidget(covariant DSActionableWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.onPressed != widget.onPressed) {
      _state = widget.onPressed == null
          ? DSActionableState.disabled
          : DSActionableState.activated;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ds = DesignSystemProvider.of(context);
    final style = widget.defineStyle == null
        ? _resolveStyle(_state, ds)
        : widget.defineStyle!(_state, ds);
    return GestureDetector(
      onTap: widget.onPressed,
      child: Listener(
        onPointerDown: (details) {
          if (_state != DSActionableState.disabled) {
            setState(() {
              _state = DSActionableState.pressed;
            });
          }
        },
        onPointerUp: (details) {
          if (_state != DSActionableState.disabled) {
            setState(() {
              _state = DSActionableState.activated;
            });
          }
        },
        child: DSStateWidget(
          style: style,
          state: _state,
          child: widget.builder(context, _state, style),
        ),
      ),
    );
  }

  DSStyle _resolveStyle(DSActionableState state, DesignSystemProvider ds) {
    switch (state) {
      case DSActionableState.activated:
        return DSStyle(
          background: ds.colorScheme.primary,
          textStyle: DSTextStyles.actionable().copyWith(
            color: ds.colorScheme.light.color,
          ),
        );
      case DSActionableState.disabled:
        return DSStyle(
          background: ds.colorScheme.primary,
          textStyle: DSTextStyles.actionable().copyWith(
            color: ds.colorScheme.light.color,
          ),
        );
      case DSActionableState.pressed || DSActionableState.hovered:
        return DSStyle(
          background: ds.colorScheme.backgroundDisabled,
          textStyle: DSTextStyles.actionable().copyWith(
            color: ds.colorScheme.disabled.color,
          ),
        );
      default:
        return const DSStyle();
    }
  }
}

class DSStateWidget extends InheritedWidget {
  final DSStyle? style;
  final DSActionableState state;
  const DSStateWidget({
    this.style,
    this.state = DSActionableState.activated,
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(covariant DSStateWidget oldWidget) {
    return style != oldWidget.style;
  }

  static DSStateWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DSStateWidget>();
  }
}

class DSStyle {
  final DSColor? background;
  final Border? border;
  final TextStyle? textStyle;
  const DSStyle({this.background, this.border, this.textStyle});
}
