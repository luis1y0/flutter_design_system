import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart';

typedef DSOnResendCode = void Function();

enum _DSOtpFormState {
  initial,
  loading,
  disabled,
  error,
}

/// Widget para la validación de códigos OTP enviados por SMS
///
/// Permite configurar la cantidad de dígitos del código, un temporizador
/// para el límite de tiempo, y callbacks para solicitar un nuevo código
/// y para cuando el código ha sido introducido completamente.
class DSSmsCodeValidation extends StatefulWidget {
  /// Número de dígitos del código OTP
  final int digitCount;

  /// Duración del temporizador para solicitar un nuevo código
  final Duration timerDuration;

  /// Callback que se ejecuta cuando se completa el código
  final DSResultAsyncCallback<String, dynamic>? onCodeCompleted;

  /// Callback que se ejecuta cuando se solicita un nuevo código
  final VoidCallback? onResendCode;

  const DSSmsCodeValidation({
    this.digitCount = 6,
    this.timerDuration = const Duration(minutes: 2),
    this.onCodeCompleted,
    this.onResendCode,
    super.key,
  }) : assert(digitCount > 0, 'El número de dígitos debe ser mayor a cero');

  @override
  State<DSSmsCodeValidation> createState() => _DSSmsCodeValidationState();
}

class _DSSmsCodeValidationState extends State<DSSmsCodeValidation> {
  late Timer _timer;
  int _remainingSeconds = 0;
  bool _canResend = false;
  _DSOtpFormState _state = _DSOtpFormState.initial;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    final ds = DesignSystemProvider.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        DSText(
          DSString.of(DSTextConstants.labelOtp),
          style: DSTextStyles.base(),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        DSOtpInput(
          digitCount: widget.digitCount,
          onOtpCompleted: (otp) async {
            if (widget.onCodeCompleted != null) {
              setState(() {
                _state = _DSOtpFormState.loading;
              });
              final result = await widget.onCodeCompleted!(otp);
              if (mounted) {
                setState(() {
                  _state = result.isSuccess
                      ? _DSOtpFormState.initial
                      : _DSOtpFormState.error;
                });
              }
            }
          },
          state: _otpInputState,
        ),
        const SizedBox(height: 16),
        Center(
          child: _canResend
              ? DSLinkText(
                  DSString.of(DSTextConstants.labelOtpExpiredResend),
                  callback: _onResend,
                  color: ds.colorScheme.error.color,
                )
              : DSText(
                  '${DSString.of(DSTextConstants.labelOtpRemainingTime)}: ${_formatRemainingTime()}',
                  style: DSTextStyles.base().copyWith(
                    color: switch (_state) {
                      _DSOtpFormState.loading => ds.colorScheme.disabled.color,
                      _ => ds.colorScheme.dark.color,
                    },
                  ),
                ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  DSOtpInputState get _otpInputState {
    if (_state == _DSOtpFormState.loading) {
      return DSOtpInputState.disabled;
    }
    if (_state == _DSOtpFormState.error) {
      return DSOtpInputState.error;
    }
    if (_state == _DSOtpFormState.disabled) {
      return DSOtpInputState.disabled;
    }
    return DSOtpInputState.activated;
  }

  void _startTimer() {
    _remainingSeconds = widget.timerDuration.inSeconds;
    _canResend = false;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _canResend = true;
          _state = _DSOtpFormState.disabled;
          _timer.cancel();
        }
      });
    });
  }

  void _onResend() {
    if (_canResend && widget.onResendCode != null) {
      widget.onResendCode!();
      _state = _DSOtpFormState.initial;
      _startTimer();
    }
  }

  String _formatRemainingTime() {
    final minutes = _remainingSeconds ~/ 60;
    final seconds = _remainingSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}
