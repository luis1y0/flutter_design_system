part of 'widget.dart';

class DSSigninFormState {
  final String email;
  final String password;
  final DSTextFieldState emailState;
  final DSTextFieldState passwordState;
  final bool isPasswordVisible;
  final bool isLoading;
  final bool isButtonEnabled;

  const DSSigninFormState({
    this.email = '',
    this.password = '',
    this.emailState = DSTextFieldState.activated,
    this.passwordState = DSTextFieldState.activated,
    this.isPasswordVisible = false,
    this.isLoading = false,
    this.isButtonEnabled = false,
  });

  DSSigninFormState copyWith({
    String? email,
    String? password,
    DSTextFieldState? emailState,
    DSTextFieldState? passwordState,
    bool? isPasswordVisible,
    bool? isLoading,
    bool? isButtonEnabled,
  }) {
    return DSSigninFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      emailState: emailState ?? this.emailState,
      passwordState: passwordState ?? this.passwordState,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isLoading: isLoading ?? this.isLoading,
      isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
    );
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
        emailState: errorEmail != null ? DSTextFieldState.error : null,
        passwordState: errorPassword != null ? DSTextFieldState.error : null,
      );
      notifyListeners();
    }
    // there are some errors, register button should be disabled
    if ((errorEmail != null || errorPassword != null) &&
        state.isButtonEnabled) {
      _state = _state.copyWith(
        isButtonEnabled: false,
        emailState: errorEmail != null ? DSTextFieldState.error : null,
        passwordState: errorPassword != null ? DSTextFieldState.error : null,
      );
      notifyListeners();
    }
  }

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'This field is required.';
    }
    final emailRegex = RegExp(DSTextConstants.regexEmail);
    bool validEmail = emailRegex.hasMatch(email);
    if (validEmail) {
      return null;
    }
    return 'Invalid email.';
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required.';
    }
    if (value.length < 8) {
      return 'Your password must be 8 or more characters.';
    }
    return null;
  }

  void togglePasswordVisibility() {
    _state = _state.copyWith(
      isPasswordVisible: !_state.isPasswordVisible,
    );
    notifyListeners();
  }

  void submit() async {
    _state = _state.copyWith(
      isLoading: true,
      isButtonEnabled: false,
      emailState: DSTextFieldState.disabled,
      passwordState: DSTextFieldState.disabled,
    );
    notifyListeners();

    //final signupResult = await callback(state.email, state.password);

    _state = _state.copyWith(
      isLoading: false,
      isButtonEnabled: true,
      emailState: DSTextFieldState.activated,
      passwordState: DSTextFieldState.activated,
    );
    notifyListeners();
  }
}
