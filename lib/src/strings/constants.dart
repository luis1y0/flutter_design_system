class DSTextConstants {
  const DSTextConstants._();

  // keys
  static const String keyFieldEmail = 'field.email';
  static const String keyFieldPassword = 'field.password';
  static const String keyFieldConfirmPassword = 'field.confirm_password';
  static const String keyBtnSignin = 'btn.signin';
  static const String keyBtnSignup = 'btn.signup';
  // regex
  static const String regexEmail =
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  // labels
  static const String labelContinue = 'label.continue';
  static const String labelSkip = 'label.skip';
  static const String labelLogout = 'label.logout';
  static const String labelLogin = 'label.login';
  static const String labelRegister = 'label.register';
  static const String labelEmail = 'label.email';
  static const String labelPassword = 'label.password';
  static const String labelConfirmPassword = 'label.confirm_password';
  static const String labelSignin = 'label.signin';
  static const String labelSignup = 'label.signup';
  static const String labelForgotPassword = 'label.forgot_password';
  static const String labelCreateAccount = 'label.create_account';
  static const String labelNavigateLogin = 'label.navigate_login';
  static const String labelTermsConditions = 'label.terms_conditions';
  static const String labelPrivacyPolicy = 'label.privacy_policy';

  static const String labelVerifyPhone = 'label.verify_phone';
  static const String labelPhoneNumber = 'label.phone_number';
  static const String labelSendSms = 'label.send_sms';

  static const String labelOtp = 'label.otp';
  static const String labelOtpExpiredResend = 'label.otp_expired_resend';
  static const String labelOtpRemainingTime = 'label.otp_remaining_time';
  // errors
  static const String errorFieldRequired = 'error.field_required';
  static const String errorInvalidEmail = 'error.invalid_email';
  static const String errorInvalidPassword = 'error.invalid_password';
  static const String errorConfirmPassword = 'error.confirm_password';
}
