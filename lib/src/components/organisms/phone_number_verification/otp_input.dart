import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_design_system/flutter_design_system.dart';

enum DSOtpInputState { activated, disabled, error }

typedef OnOtpCompleted = void Function(String otp);

class DSOtpInput extends StatefulWidget {
  final int digitCount;
  final OnOtpCompleted onOtpCompleted;
  final DSOtpInputState state;
  const DSOtpInput({
    required this.digitCount,
    required this.onOtpCompleted,
    this.state = DSOtpInputState.activated,
    super.key,
  });

  @override
  State<DSOtpInput> createState() => _DSOtpInputState();
}

class _DSOtpInputState extends State<DSOtpInput> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      widget.digitCount,
      (_) => TextEditingController(),
    );
    _focusNodes = List.generate(
      widget.digitCount,
      (_) => FocusNode(
        onKeyEvent: _onKeyEvent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < widget.digitCount; i++) _buildOtpField(i),
      ],
    );
  }

  @override
  void didUpdateWidget(covariant DSOtpInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.state != widget.state &&
        widget.state == DSOtpInputState.activated) {
      for (var controller in _controllers) {
        controller.clear();
      }
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  Widget _buildOtpField(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DSTextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        maxLength: 1,
        style: DSTextStyles.title(),
        state: switch (widget.state) {
          DSOtpInputState.activated => DSTextFieldState.activated,
          DSOtpInputState.disabled => DSTextFieldState.disabled,
          DSOtpInputState.error => DSTextFieldState.error,
        },
        onChanged: (value) {
          if (value.isNotEmpty) {
            // Mover al siguiente campo
            if (index < widget.digitCount - 1) {
              _focusNodes[index + 1].requestFocus();
            } else {
              // Último campo, ocultar teclado
              FocusScope.of(context).unfocus();
            }
          } else if (index > 0) {
            _focusNodes[index - 1].requestFocus();
          } else {
            FocusScope.of(context).unfocus();
          }
          _onCodeChanged();
        },
      ),
    );
  }

  String get _completeCode {
    return _controllers.map((controller) => controller.text).join();
  }

  bool get _isCodeComplete {
    return _controllers.every((controller) => controller.text.isNotEmpty);
  }

  void _onCodeChanged() {
    if (_isCodeComplete) {
      widget.onOtpCompleted(_completeCode);
    }
  }

  KeyEventResult _onKeyEvent(FocusNode node, KeyEvent event) {
    if (event is KeyUpEvent) {
      return KeyEventResult.handled;
    }
    if (event.logicalKey == LogicalKeyboardKey.backspace) {
      final index = _focusNodes.indexOf(node);
      _controllers[index].clear();
      if (index > 0) {
        _controllers[index - 1].clear();
        _focusNodes[index - 1].requestFocus();
        return KeyEventResult.handled;
      }
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }
}
