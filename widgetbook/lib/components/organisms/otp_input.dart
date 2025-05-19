import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'OtpInput Widget', type: DSOtpInput)
Widget buildOtpInputExample(BuildContext context) {
  final smsCode = context.knobs.int.slider(
    label: 'SMS Code',
    initialValue: 3,
    min: 3,
    max: 6,
  );
  final state = context.knobs.list<DSOtpInputState>(
    label: 'State',
    initialOption: DSOtpInputState.activated,
    options: DSOtpInputState.values,
  );
  return DSOtpInput(
    digitCount: smsCode,
    onOtpCompleted: (otp) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('onOtpCompleted: $otp'),
      ));
    },
    state: state,
  );
}
