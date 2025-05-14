part of 'widget.dart';

class DSSigninFormState {
  final String email;
  final String password;
  final DSTextFieldState emailState;
  final DSTextFieldState passwordState;
  final DSSigninResult result;
  final bool isPasswordVisible;
  final bool isLoading;
  final bool isButtonEnabled;

  const DSSigninFormState({
    this.email = '',
    this.password = '',
    this.emailState = DSTextFieldState.activated,
    this.passwordState = DSTextFieldState.activated,
    this.result = const DSSigninResult.success(),
    this.isPasswordVisible = false,
    this.isLoading = false,
    this.isButtonEnabled = false,
  });

  DSSigninFormState copyWith({
    String? email,
    String? password,
    DSTextFieldState? emailState,
    DSTextFieldState? passwordState,
    DSSigninResult? result,
    bool? isPasswordVisible,
    bool? isLoading,
    bool? isButtonEnabled,
  }) {
    return DSSigninFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      emailState: emailState ?? this.emailState,
      passwordState: passwordState ?? this.passwordState,
      result: result ?? this.result,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isLoading: isLoading ?? this.isLoading,
      isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
    );
  }
}

class DSSigninResult {
  final bool success;
  final String? error;
  final String? errorEmail;
  final String? errorPassword;

  const DSSigninResult.success()
      : success = true,
        error = null,
        errorEmail = null,
        errorPassword = null;

  const DSSigninResult.generalFail({required String message})
      : success = false,
        error = message,
        errorEmail = null,
        errorPassword = null;

  const DSSigninResult.fieldFail({this.errorEmail, this.errorPassword})
      : success = false,
        error = null;

  @override
  String toString() {
    if (success) {
      return 'Success';
    }
    if (error != null) {
      return 'General Error';
    }
    if (errorEmail != null) {
      return 'Email Error';
    }
    if (errorPassword != null) {
      return 'Password Error';
    }
    return super.toString();
  }
}

class DSSigninFormController extends ChangeNotifier {
  DSSigninFormState _state = const DSSigninFormState();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  DSSigninFormController() {
    controllerEmail.addListener(_onChanged);
    controllerPassword.addListener(_onChanged);
  }

  DSSigninFormState get state => _state;

  void _onChanged() {
    final email = controllerEmail.text;
    final password = controllerPassword.text;
    _state = _state.copyWith(
      email: email,
      password: password,
      emailState: DSTextFieldState.activated,
      passwordState: DSTextFieldState.activated,
    );
    // handle activate register button
    final errorEmail = validateEmail(email);
    final errorPassword = validatePassword(password);
    // there are no errors, register button should be active
    if ((errorEmail == null && errorPassword == null) &&
        !state.isButtonEnabled) {
      _state = _state.copyWith(
        isButtonEnabled: true,
        emailState: errorEmail != null
            ? DSTextFieldState.error
            : DSTextFieldState.activated,
        passwordState: errorPassword != null
            ? DSTextFieldState.error
            : DSTextFieldState.activated,
      );
      notifyListeners();
    }
    // there are some errors, register button should be disabled
    if ((errorEmail != null || errorPassword != null) &&
        state.isButtonEnabled) {
      _state = _state.copyWith(
        isButtonEnabled: false,
        emailState: errorEmail != null
            ? DSTextFieldState.error
            : DSTextFieldState.activated,
        passwordState: errorPassword != null
            ? DSTextFieldState.error
            : DSTextFieldState.activated,
      );
      notifyListeners();
    }
  }

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return DSString.of(DSTextConstants.errorFieldRequired);
    }
    final emailRegex = RegExp(DSTextConstants.regexEmail);
    bool validEmail = emailRegex.hasMatch(email);
    if (validEmail) {
      return null;
    }
    return DSString.of(DSTextConstants.errorInvalidEmail);
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return DSString.of(DSTextConstants.errorFieldRequired);
    }
    if (value.length < 8) {
      return DSString.of(DSTextConstants.errorInvalidPassword);
    }
    return null;
  }

  void togglePasswordVisibility() {
    _state = _state.copyWith(
      isPasswordVisible: !_state.isPasswordVisible,
    );
    notifyListeners();
  }

  void submit(DSOnSigninCallback? callback) async {
    if (callback == null) {
      return;
    }
    _state = _state.copyWith(
      isLoading: true,
      isButtonEnabled: false,
      emailState: DSTextFieldState.disabled,
      passwordState: DSTextFieldState.disabled,
    );
    notifyListeners();

    final signinResult = await callback(state.email, state.password);

    _state = _state.copyWith(
      isButtonEnabled: false,
      emailState: DSTextFieldState.activated,
      passwordState: DSTextFieldState.activated,
      result: signinResult,
    );
    if (signinResult.error != null) {
      _state = _state.copyWith(
        isButtonEnabled: true,
      );
    }
    if (signinResult.errorEmail != null) {
      _state = _state.copyWith(
        emailState: DSTextFieldState.error,
      );
    }
    if (signinResult.errorPassword != null) {
      _state = _state.copyWith(
        passwordState: DSTextFieldState.error,
      );
    }
    notifyListeners();
  }
}
