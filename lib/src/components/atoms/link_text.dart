import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart';

class DSLinkText extends StatelessWidget {
  final String data;
  final VoidCallback? callback;
  final Color? color;
  const DSLinkText(this.data, {this.callback, this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: DSText(
        data,
        style: TextStyle(
          decoration: TextDecoration.underline,
          color: color,
        ),
      ),
    );
  }
}
