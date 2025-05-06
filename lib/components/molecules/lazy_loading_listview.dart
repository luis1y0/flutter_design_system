import 'package:flutter/material.dart';

typedef DSLazyLoadingBuilder<T> = Widget Function(
    BuildContext context, int index, T item);

class DSLazyLoadingListView<T> extends StatefulWidget {
  /// Whether if using a button at the bottom to fetch new data
  final bool manualPagination;

  /// Fetching the total to compute the number of new items when end is reached
  final List<T> Function()? onEndReached;

  final DSLazyLoadingBuilder itemBuilder;
  const DSLazyLoadingListView({
    this.onEndReached,
    required this.itemBuilder,
    required this.manualPagination,
    super.key,
  });

  @override
  State<DSLazyLoadingListView> createState() => _DSLazyLoadingListViewState();
}

class _DSLazyLoadingListViewState extends State<DSLazyLoadingListView> {
  List _items = [];
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    if (widget.onEndReached == null) {
      return;
    }
    final items = widget.onEndReached!();
    _items = items;
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.position.extentAfter < 200) {
        final items = widget.onEndReached!();
        setState(() {
          _items = items;
        });
      }
    });
    return ListView.builder(
      controller: _scrollController,
      itemCount: _items.length,
      itemBuilder: (context, index) {
        return widget.itemBuilder(context, index, _items[index]);
      },
    );
  }

  void _onScroll() {
    if (_scrollController.position.extentAfter < 200) {
      final items = widget.onEndReached!();
      setState(() {
        _items = items;
      });
      return;
    }
    final position = _scrollController.positions.first.pixels;
    final max = _scrollController.positions.first.maxScrollExtent;
    if (max - position > 50 || widget.onEndReached == null) {
      return;
    }
    final items = widget.onEndReached!();
    setState(() {
      _items = items;
    });
  }

  @override
  void didUpdateWidget(covariant DSLazyLoadingListView oldWidget) {
    super.didUpdateWidget(oldWidget);
  }
}
