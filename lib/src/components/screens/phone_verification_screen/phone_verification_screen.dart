import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart';

part 'controller.dart';

typedef OnPhoneVerificationStarted = Future<DSPhoneVerificationResult> Function(
    String code, String phoneNumber);

/// This Screen controlls the phone verification process.
/// It displays a text field for the phone number, within this text field
/// [DSPhoneVerificationScreen.countryCodePicker] is used as a prefix in
/// [DSTextField], and a button to start the verification process.
///
/// If you want to provide the dialCode from [countryCodePicker] selector,
/// you need to use a [GlobalKey] to access the [DSPhoneVerificationScreenState]
/// and call [DSPhoneVerificationScreenState.updateCode] to update the code.
class DSPhoneVerificationScreen extends StatefulWidget {
  /// used as a prefix widget for the phone number text field
  final Widget countryCodePicker;
  final OnPhoneVerificationStarted onPhoneVerificationStarted;
  final DSResultAsyncCallback<String, DSResult> onOtpVerificationStarted;
  final VoidCallback onResendCode;
  final int otpLength;
  final Duration otpTimerDuration;
  final VoidCallback logout;
  const DSPhoneVerificationScreen({
    required this.countryCodePicker,
    required this.onPhoneVerificationStarted,
    required this.onOtpVerificationStarted,
    required this.onResendCode,
    required this.otpTimerDuration,
    required this.otpLength,
    required this.logout,
    super.key,
  });

  @override
  State<DSPhoneVerificationScreen> createState() =>
      DSPhoneVerificationScreenState();
}

class DSPhoneVerificationScreenState extends State<DSPhoneVerificationScreen> {
  final _DSPhoneVerificationController _controller =
      _DSPhoneVerificationController();

  @override
  Widget build(BuildContext context) {
    final ds = DesignSystemProvider.of(context);
    final successColor = ds.colorScheme.success;
    return Scaffold(
      appBar: AppBar(
        title: Text(DSString.of(DSTextConstants.labelVerifyPhone)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListenableBuilder(
              listenable: _controller,
              builder: (context, child) {
                if (_controller.value is DSPhoneVerificationNumberFormState) {
                  return _buildPhoneNumberInput(
                    _controller.value as DSPhoneVerificationNumberFormState,
                  );
                }
                if (_controller.value is DSPhoneVerificationOtpFormState) {
                  return _buildOtpInput(
                    _controller.value as DSPhoneVerificationOtpFormState,
                  );
                }
                return Column(
                  children: [
                    DSIcon(
                      Icons.check_circle_outline,
                      color: successColor,
                    ),
                    const DSText('Phone Number Verification Succeeded'),
                  ],
                );
              },
            ),
            DSButton(
              onPressed: widget.logout,
              child: DSText(DSString.of(DSTextConstants.labelLogout)),
            ),
          ],
        ),
      ),
    );
  }

  void updateCode(String code) {
    Future.microtask(() => _controller.updatePhoneNumber(dialCode: code));
  }

  Widget _buildPhoneNumberInput(DSPhoneVerificationNumberFormState state) {
    VoidCallback? onValidate;
    if (state.buttonSendOtpEnabled) {
      onValidate = _onPhoneVerificationStarted;
    }
    return DSPhoneNumberInput(
      countryCodePicker: widget.countryCodePicker,
      onPhoneNumberChanged: (phoneNumber) {
        _controller.updatePhoneNumber(phoneNumber: phoneNumber);
      },
      onValidate: onValidate,
      isLoading: state.isLoading,
      errorMessage: state.errorMessage,
    );
  }

  Widget _buildOtpInput(DSPhoneVerificationOtpFormState state) {
    return DSSmsCodeValidation(
      digitCount: widget.otpLength,
      timerDuration: widget.otpTimerDuration,
      onCodeCompleted: _onOtpVerificationStarted,
      onResendCode: widget.onResendCode,
    );
  }

  void _onPhoneVerificationStarted() async {
    _controller.savePhoneNumber();
    final result = await widget.onPhoneVerificationStarted(
      _controller.dialCode,
      _controller.phoneNumber,
    );
    if (result.success) {
      _controller.showOtpForm();
    } else {
      _controller.setErrorMesssage(result.message!);
    }
  }

  Future<DSResult> _onOtpVerificationStarted(String otp) async {
    _controller.saveOtp();
    final result = await widget.onOtpVerificationStarted(otp);
    if (result.isSuccess) {
      _controller.finishOtpValidation();
    } else {
      _controller.setErrorMesssage(result.errorMessage!);
    }
    return result;
  }
}
