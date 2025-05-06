import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'LazyLoadingList Widget', type: DSLazyLoadingListView)
Widget buildLazyLoadingExample(BuildContext context) {
  final total = context.knobs.int.slider(
    label: 'Items to paginate',
    divisions: 30,
    min: 0,
    max: 500,
  );
  final fakeRepository = DataRepository(
    totalItems: total,
  );
  final notifier = ValueNotifier<List<int>>([]);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      PaginationListenerWidget(
        notifier: notifier,
      ),
      Expanded(
        child: DSLazyLoadingListView<String>(
          manualPagination: false,
          itemBuilder: (context, index, item) {
            return ListTile(
              title: DSText(item),
            );
          },
          onEndReached: () {
            final items = fakeRepository.fetchNextPage();
            Future.microtask(() {
              notifier.value = [items.length, ...notifier.value];
            });
            return items;
          },
        ),
      ),
    ],
  );
}

class DataRepository {
  final int totalItems;
  final List<String> items = [];

  DataRepository({required this.totalItems});

  List<String> fetchItems() {
    return items;
  }

  List<String> fetchNextPage() {
    for (int i = 0; i < 10; i++) {
      if (items.length >= totalItems) {
        break;
      }
      items.add('Item ${items.length}');
    }
    return items;
  }
}

class PaginationListenerWidget extends StatefulWidget {
  final ValueNotifier<List<int>> notifier;
  const PaginationListenerWidget({
    required this.notifier,
    super.key,
  });

  @override
  State<PaginationListenerWidget> createState() =>
      _PaginationListenerWidgetState();
}

class _PaginationListenerWidgetState extends State<PaginationListenerWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<int>>(
        valueListenable: widget.notifier,
        builder: (context, items, child) {
          if (items.isEmpty) {
            return const Text('No elements loaded');
          }
          return Text('${items.first} items loaded.');
        });
  }
}
