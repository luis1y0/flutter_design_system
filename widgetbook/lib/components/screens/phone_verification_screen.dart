import 'dart:math';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
    name: 'PoneVerification Screen', type: DSPhoneVerificationScreen)
Widget buildPhoneVerificationScreen(BuildContext context) {
  final smsCode = context.knobs.int.input(
    label: 'SMS Code',
    initialValue: 1234,
  );
  final codeValidDuration = context.knobs.duration(
    label: 'Code Duration',
    initialValue: const Duration(minutes: 1),
  );
  final globalKey = GlobalKey<DSPhoneVerificationScreenState>();
  return DSPhoneVerificationScreen(
    key: globalKey,
    countryCodePicker: CountryCodePicker(
      favorite: const ['+52', '+1'],
      initialSelection: '+52',
      onChanged: (value) {
        globalKey.currentState?.updateCode(value.dialCode ?? '');
      },
      onInit: (value) {
        globalKey.currentState?.updateCode(value?.dialCode ?? '');
      },
    ),
    otpLength: smsCode.toString().length,
    otpTimerDuration: codeValidDuration,
    onPhoneVerificationStarted: (code, phoneNumber) async {
      await Future.delayed(const Duration(seconds: 2));
      bool isValid = Random().nextBool();
      if (!isValid) {
        return const DSPhoneVerificationResult.error('Firebase error');
      }
      return const DSPhoneVerificationResult.success();
    },
    onOtpVerificationStarted: (otp) async {
      await Future.delayed(const Duration(seconds: 2));
      if (otp == smsCode.toString()) {
        return const DSResult.success();
      } else {
        return const DSResult.error(errorMessage: 'Invalid code');
      }
    },
    onResendCode: () {
      // call your resend code function
    },
    logout: () {
      // call your logout function
    },
  );
}
