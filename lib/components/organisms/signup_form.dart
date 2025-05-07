import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart';

/// Called when Register button is clicked, if any error happens
/// a String message is returned
typedef DSOnRegisterCallback = Future<DSSignupResult> Function(
    String email, String password);
typedef DSOnBackCallback = void Function();

class DSSignupForm extends StatefulWidget {
  final DSOnRegisterCallback? onRegister;
  final DSOnBackCallback? onBack;
  const DSSignupForm({
    this.onRegister,
    this.onBack,
    super.key,
  });

  @override
  State<DSSignupForm> createState() => _DSSignupFormState();
}

class _DSSignupFormState extends State<DSSignupForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final RegisterFormController _controller = RegisterFormController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final ds = DesignSystemProvider.of(context);
    return Padding(
      padding: EdgeInsets.all(MediaQuery.sizeOf(context).width * 0.1),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_controller.state.signupResult.error != null)
              DSText(
                _controller.state.signupResult.error!,
                style: DSTextStyles.base().copyWith(
                  color: ds.colorScheme.error.color,
                ),
              ),
            const SizedBox(height: 8.0),
            DSTextField.form(
              controller: _controller.controllerEmail,
              labelText: 'Email',
              isDense: true,
              keyboardType: TextInputType.emailAddress,
              state: _controller.state.emailState,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: _controller.validateEmail,
              errorText: _controller.state.signupResult.errorEmail,
            ),
            const SizedBox(height: 8.0),
            DSTextField.form(
              controller: _controller.controllerPassword,
              labelText: 'Password',
              isDense: true,
              state: _controller.state.passwordState,
              obscureText: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: _controller.validatePassword,
              errorText: _controller.state.signupResult.errorPassword,
            ),
            const SizedBox(height: 8.0),
            DSTextField.form(
              controller: _controller.controllerConfirmPassword,
              labelText: 'Confirm Password.',
              isDense: true,
              state: _controller.state.confirmPasswordState,
              obscureText: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: _controller.validateConfirmPassword,
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Expanded(
                  child: DSButton(
                    variant: DSButtonVariant.secondary,
                    onPressed:
                        _controller.state.isLoading ? null : widget.onBack,
                    child: const DSText('Go Back'),
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: DSButton(
                    onPressed: _controller.state.isRegisterButtonEnabled
                        ? _onRegisterCallback
                        : null,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxHeight: 16.0,
                              maxWidth: 16.0,
                            ),
                            child: Visibility(
                              visible: _controller.state.isLoading,
                              child: CircularProgressIndicator(
                                color: ds.colorScheme.disabled.color,
                              ),
                            ),
                          ),
                          const Expanded(
                            child: DSText(
                              'Register',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _onRegisterCallback() async {
    _controller.submit(widget.onRegister);
  }
}

class RegisterFormState {
  // fields
  final String email;
  final String password;
  final String confirmPassword;
  // field states
  final DSTextFieldState emailState;
  final DSTextFieldState passwordState;
  final DSTextFieldState confirmPasswordState;
  // error messages
  final DSSignupResult signupResult;
  final bool isRegisterButtonEnabled;
  final bool isLoading;

  RegisterFormState({
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.emailState = DSTextFieldState.activated,
    this.passwordState = DSTextFieldState.activated,
    this.confirmPasswordState = DSTextFieldState.disabled,
    this.signupResult = const DSSignupResult.success(),
    this.isRegisterButtonEnabled = false,
    this.isLoading = false,
  });

  RegisterFormState copyWith({
    String? email,
    String? password,
    String? confirmPassword,
    DSTextFieldState? emailState,
    DSTextFieldState? passwordState,
    DSTextFieldState? confirmPasswordState,
    DSSignupResult? signupResult,
    bool? isRegisterButtonEnabled,
    bool? isLoading,
  }) {
    return RegisterFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      emailState: emailState ?? this.emailState,
      passwordState: passwordState ?? this.passwordState,
      confirmPasswordState: confirmPasswordState ?? this.confirmPasswordState,
      signupResult: signupResult ?? this.signupResult,
      isRegisterButtonEnabled:
          isRegisterButtonEnabled ?? this.isRegisterButtonEnabled,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

/// This class works as a state machine, it is composed of 2 components,
/// its **state** where we can read all values to build the UI and methods
/// that represent the actions to change the state.
class RegisterFormController extends ChangeNotifier {
  RegisterFormState _state = RegisterFormState();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  final TextEditingController controllerConfirmPassword =
      TextEditingController();

  RegisterFormController() {
    controllerEmail.addListener(_onFormChanged);
    controllerPassword.addListener(_onPasswordChanged);
    controllerConfirmPassword.addListener(_onFormChanged);
  }

  // 1st component
  RegisterFormState get state => _state;

  // All methods as the 2nd component representing actions
  void _onFormChanged() {
    final email = controllerEmail.text;
    final confirmPassword = controllerConfirmPassword.text;
    _state = _state.copyWith(
      email: email,
      confirmPassword: confirmPassword,
      emailState: DSTextFieldState.activated,
      passwordState: DSTextFieldState.activated,
      signupResult: const DSSignupResult.success(),
    );
    // handle activate register button
    final errorEmail = validateEmail(email);
    final errorConfirm = validateConfirmPassword(confirmPassword);
    // there are no errors, register button should be active
    if ((errorEmail == null && errorConfirm == null) &&
        !state.isRegisterButtonEnabled) {
      _state = _state.copyWith(
        isRegisterButtonEnabled: true,
      );
      notifyListeners();
    }
    // there are some errors, register button should be disabled
    if ((errorEmail != null || errorConfirm != null) &&
        state.isRegisterButtonEnabled) {
      _state = _state.copyWith(
        isRegisterButtonEnabled: false,
      );
      notifyListeners();
    }
  }

  void _onPasswordChanged() {
    final password = controllerPassword.text;
    _state = _state.copyWith(
      password: password,
      emailState: DSTextFieldState.activated,
      passwordState: DSTextFieldState.activated,
      signupResult: const DSSignupResult.success(),
    );
    // handle activate/disable confirm password
    final errorMessage = validatePassword(password);
    if (errorMessage == null &&
        state.confirmPasswordState == DSTextFieldState.disabled) {
      _state = _state.copyWith(
        confirmPasswordState: DSTextFieldState.activated,
      );
      notifyListeners();
    }
    if (errorMessage != null &&
        state.confirmPasswordState == DSTextFieldState.activated) {
      _state = _state.copyWith(
        confirmPasswordState: DSTextFieldState.disabled,
      );
      notifyListeners();
    }
  }

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'This field is required.';
    }
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
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

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required.';
    }
    final passwd = _state.password;
    if (value != passwd) {
      return 'The password don\'t match.';
    }
    return null;
  }

  Future<void> submit(DSOnRegisterCallback? callback) async {
    if (callback == null) {
      return;
    }
    _state = _state.copyWith(
      isLoading: true,
      isRegisterButtonEnabled: false,
      emailState: DSTextFieldState.disabled,
      passwordState: DSTextFieldState.disabled,
      confirmPasswordState: DSTextFieldState.disabled,
    );
    notifyListeners();

    final signupResult = await callback(state.email, state.password);

    _state = _state.copyWith(
      isLoading: false,
      isRegisterButtonEnabled: signupResult.success
          ? true
          : signupResult.error == null
              ? false
              : true,
      signupResult: signupResult,
      emailState: signupResult.errorEmail == null
          ? DSTextFieldState.activated
          : DSTextFieldState.error,
      passwordState: signupResult.errorPassword == null
          ? DSTextFieldState.activated
          : DSTextFieldState.error,
      confirmPasswordState: signupResult.errorPassword == null
          ? DSTextFieldState.activated
          : DSTextFieldState.disabled,
    );
    notifyListeners();
  }
}

class DSSignupResult {
  final bool success;
  final String? error;
  final String? errorEmail;
  final String? errorPassword;

  const DSSignupResult.success()
      : success = true,
        error = null,
        errorEmail = null,
        errorPassword = null;

  const DSSignupResult.generalFail({required String message})
      : success = false,
        error = message,
        errorEmail = null,
        errorPassword = null;

  const DSSignupResult.fieldFail({this.errorEmail, this.errorPassword})
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
