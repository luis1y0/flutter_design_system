part of 'phone_verification_screen.dart';

class DSPhoneVerificationResult {
  final bool success;
  final String? message;
  const DSPhoneVerificationResult.success()
      : success = true,
        message = null;
  const DSPhoneVerificationResult.error(this.message) : success = false;
}

abstract class DSPhoneVerificationState {}

class DSPhoneVerificationNumberFormState implements DSPhoneVerificationState {
  final String dialCode;
  final String phoneNumber;
  final bool buttonSendOtpEnabled;
  final bool isLoading;
  final String? errorMessage;
  const DSPhoneVerificationNumberFormState.initial()
      : dialCode = '',
        phoneNumber = '',
        buttonSendOtpEnabled = false,
        errorMessage = null,
        isLoading = false;
  const DSPhoneVerificationNumberFormState({
    required this.dialCode,
    required this.phoneNumber,
    required this.buttonSendOtpEnabled,
    required this.isLoading,
    this.errorMessage,
  });

  DSPhoneVerificationNumberFormState copyWith({
    String? dialCode,
    String? phoneNumber,
    bool? buttonSendOtpEnabled,
    bool? isLoading,
    String? errorMessage,
  }) {
    return DSPhoneVerificationNumberFormState(
      dialCode: dialCode ?? this.dialCode,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      buttonSendOtpEnabled: buttonSendOtpEnabled ?? this.buttonSendOtpEnabled,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class DSPhoneVerificationOtpFormState implements DSPhoneVerificationState {
  final String? otp;
  final bool isLoading;
  final String? errorMessage;
  const DSPhoneVerificationOtpFormState({
    required this.otp,
    required this.isLoading,
    this.errorMessage,
  });

  DSPhoneVerificationOtpFormState copyWith({
    String? otp,
    String? phoneNumber,
    bool? buttonSendOtpEnabled,
    bool? isLoading,
    String? errorMessage,
  }) {
    return DSPhoneVerificationOtpFormState(
      otp: otp ?? this.otp,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class DSPhoneVerificationFinishedState implements DSPhoneVerificationState {
  const DSPhoneVerificationFinishedState();
}

class _DSPhoneVerificationController
    extends ValueNotifier<DSPhoneVerificationState> {
  String _dialCode = '';
  String _phoneNumber = '';
  String _otp = '';
  _DSPhoneVerificationController()
      : super(const DSPhoneVerificationNumberFormState.initial());

  String get dialCode => _dialCode;
  String get phoneNumber => _phoneNumber;
  String get otp => _otp;

  void setErrorMesssage(String message) {
    if (value is DSPhoneVerificationNumberFormState) {
      value = (value as DSPhoneVerificationNumberFormState).copyWith(
        errorMessage: message,
        isLoading: false,
        buttonSendOtpEnabled: false,
      );
    } else if (value is DSPhoneVerificationOtpFormState) {
      _otp = '';
      value = (value as DSPhoneVerificationOtpFormState).copyWith(
        otp: _otp,
        errorMessage: message,
        isLoading: false,
        buttonSendOtpEnabled: false,
      );
    }
  }

  void updatePhoneNumber({String? dialCode, String? phoneNumber}) {
    _dialCode = dialCode ?? _dialCode;
    _phoneNumber = phoneNumber ?? _phoneNumber;
    if (value is DSPhoneVerificationNumberFormState) {
      var state = value as DSPhoneVerificationNumberFormState;
      state = state.copyWith(
        dialCode: _dialCode,
        phoneNumber: _phoneNumber,
      );
      if (_validPhoneNumber && !state.buttonSendOtpEnabled) {
        value = state.copyWith(
          buttonSendOtpEnabled: true,
        );
      } else if (!_validPhoneNumber && state.buttonSendOtpEnabled) {
        value = state.copyWith(
          buttonSendOtpEnabled: false,
        );
      }
    }
  }

  void savePhoneNumber() {
    if (value is DSPhoneVerificationNumberFormState) {
      value = (value as DSPhoneVerificationNumberFormState).copyWith(
        isLoading: true,
        buttonSendOtpEnabled: false,
      );
    }
  }

  bool get _validPhoneNumber {
    if (_dialCode.isEmpty) {
      return false;
    }
    if (_phoneNumber.isEmpty) {
      return false;
    }
    return true;
  }

  void showOtpForm() {
    _otp = '';
    value = DSPhoneVerificationOtpFormState(
      otp: _otp,
      isLoading: false,
    );
  }

  void updateOtp(String otp) {
    _otp = otp;
    if (_otp.length == 4) {
      value = DSPhoneVerificationOtpFormState(
        otp: _otp,
        isLoading: true,
      );
    }
  }

  void saveOtp() {
    if (value is DSPhoneVerificationOtpFormState) {
      value = (value as DSPhoneVerificationOtpFormState).copyWith(
        isLoading: true,
      );
    }
  }

  void finishOtpValidation() {
    value = const DSPhoneVerificationFinishedState();
  }
}
