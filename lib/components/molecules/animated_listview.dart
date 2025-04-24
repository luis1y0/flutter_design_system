import 'package:flutter/material.dart';

typedef DSAnimatedListBuilder<T> = Widget Function(
    BuildContext context, int index, T item);

/// This listview automatically generates animations
/// for added and removed items
class DSAnimatedListview<T> extends StatefulWidget {
  final DSAnimatedListController<T> controller;
  final DSAnimatedListBuilder<T> itemBuilder;
  const DSAnimatedListview({
    required this.controller,
    required this.itemBuilder,
    super.key,
  });

  @override
  State<DSAnimatedListview<T>> createState() => _DSAnimatedListviewState<T>();
}

class _DSAnimatedListviewState<T> extends State<DSAnimatedListview<T>> {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: widget.controller.key,
      initialItemCount: widget.controller.items.length,
      itemBuilder: (context, index, animation) {
        return FadeTransition(
          opacity: animation,
          child: widget.itemBuilder(
              context, index, widget.controller.items[index]),
        );
      },
    );
  }
}

class DSAnimatedListController<T> {
  final List<T> items = [];
  final GlobalKey<AnimatedListState> key;
  final DSAnimatedListBuilder<T> itemBuilder;

  DSAnimatedListController({required this.itemBuilder, required this.key});

  void insertItem(int index, T value) {
    items.insert(index, value);
    key.currentState?.insertItem(index, duration: const Duration(seconds: 1));
  }

  void removeItem(int index) {
    final item = items.removeAt(index); // store while animation is running
    key.currentState?.removeItem(index, (context, animation) {
      return FadeTransition(
        opacity: animation,
        child: itemBuilder(context, index, item),
      );
    }, duration: const Duration(seconds: 1));
  }
}

class _ItemListWidget extends StatefulWidget {
  final Widget child;
  const _ItemListWidget({required super.key, required this.child});

  @override
  State<_ItemListWidget> createState() => _ItemListWidgetState();
}

class _ItemListWidgetState extends State<_ItemListWidget>
    with SingleTickerProviderStateMixin {
  static final _animatedItems = <Key>{};
  bool get _firstBuild =>
      !(widget.key == null || _animatedItems.contains(widget.key));

  @override
  void initState() {
    super.initState();
    if (widget.key != null) {
      Future.microtask(() {
        _animatedItems.add(widget.key!);
        if (mounted) setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: widget.key!,
      background: const ColoredBox(color: Colors.red),
      onDismissed: (_) {},
      child: AnimatedContainer(
        duration: const Duration(seconds: 1),
        transform: Matrix4.translationValues(0, _firstBuild ? -50 : 0, 0),
        child: AnimatedOpacity(
          opacity: _firstBuild ? 0.0 : 1.0,
          duration: const Duration(seconds: 1),
          child: widget.child,
        ),
      ),
    );
  }
}
