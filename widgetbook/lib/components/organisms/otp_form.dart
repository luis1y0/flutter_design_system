import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'OtpForm Widget', type: DSSmsCodeValidation)
Widget buildOtpFormExample(BuildContext context) {
  final smsCode = context.knobs.int.input(
    label: 'SMS Code',
    initialValue: 1234,
  );
  final codeValidDuration = context.knobs.duration(
    label: 'Code Duration',
    initialValue: const Duration(minutes: 1),
  );
  return DSSmsCodeValidation(
    digitCount: smsCode.toString().length,
    onResendCode: () {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('onResendCode'),
      ));
    },
    onCodeCompleted: (value) async {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('onCodeCompleted: $value'),
      ));
      await Future.delayed(const Duration(seconds: 1));
      if (value == smsCode.toString()) {
        return const DSResult.success();
      }
      return const DSResult.error();
    },
    timerDuration: codeValidDuration,
  );
}
