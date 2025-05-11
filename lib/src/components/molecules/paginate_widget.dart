import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_design_system/flutter_design_system.dart';

class DSPaginateWidget extends StatefulWidget {
  final int total;
  final DSPaginateController? controller;
  const DSPaginateWidget({
    super.key,
    this.controller,
    required this.total,
  }) : assert(total > 0, 'total of pages must be more than zero');

  @override
  State<DSPaginateWidget> createState() => _DSPaginateWidgetState();
}

class _DSPaginateWidgetState extends State<DSPaginateWidget> {
  final TextEditingController _editingController = TextEditingController();
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.controller?.listener.value ?? _currentPage;
    _editingController.text = _currentPage.toString();
  }

  @override
  void didUpdateWidget(covariant DSPaginateWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      _currentPage = widget.controller?.listener.value ?? _currentPage;
      _editingController.text = _currentPage.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DSFabButton(
          onPressed: !_atBegin ? _moveBegin : null,
          child: const DSIcon(Icons.skip_previous_outlined),
        ),
        const SizedBox(width: 8.0),
        DSFabButton(
          onPressed: !_atBegin ? _movePrevious : null,
          child: const DSIcon(Icons.arrow_left_outlined),
        ),
        const SizedBox(width: 8.0),
        DSTextField(
          controller: _editingController,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          onSubmitted: (value) {
            final parsed = int.tryParse(value);
            if (parsed == null) {
              _editingController.text = _currentPage.toString();
              return;
            }
            if (parsed == 0 || parsed > widget.total) {
              _editingController.text = _currentPage.toString();
              return;
            }
            setState(() {
              _currentPage = parsed;
              widget.controller?.listener.value = _currentPage;
            });
          },
        ),
        DSText(' of ${widget.total}'),
        const SizedBox(width: 8.0),
        DSFabButton(
          onPressed: !_atEnd ? _moveNext : null,
          child: const DSIcon(Icons.arrow_right_outlined),
        ),
        const SizedBox(width: 8.0),
        DSFabButton(
          onPressed: !_atEnd ? _moveEnd : null,
          child: const DSIcon(Icons.skip_next_outlined),
        ),
      ],
    );
  }

  bool get _atBegin => _currentPage == 1;

  bool get _atEnd => _currentPage == widget.total;

  void _moveBegin() {
    setState(() {
      _currentPage = 1;
    });
    widget.controller?.listener.value = _currentPage;
    _editingController.text = _currentPage.toString();
  }

  void _movePrevious() {
    if (_currentPage <= 1) {
      return;
    }
    setState(() {
      _currentPage -= 1;
    });
    widget.controller?.listener.value = _currentPage;
    _editingController.text = _currentPage.toString();
  }

  void _moveNext() {
    if (_currentPage >= widget.total) {
      return;
    }
    setState(() {
      _currentPage += 1;
    });
    widget.controller?.listener.value = _currentPage;
    _editingController.text = _currentPage.toString();
  }

  void _moveEnd() {
    setState(() {
      _currentPage = widget.total;
    });
    widget.controller?.listener.value = _currentPage;
    _editingController.text = _currentPage.toString();
  }
}

class DSPaginateController {
  final ValueNotifier<int> listener;

  DSPaginateController({required this.listener});
}
