import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart';

part 'data.dart';

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
              key: const ValueKey(DSTextConstants.keyFieldEmail),
              controller: _controller.controllerEmail,
              labelText: DSString.of(DSTextConstants.labelEmail),
              isDense: true,
              prefix: const Icon(Icons.alternate_email),
              keyboardType: TextInputType.emailAddress,
              state: _controller.state.emailState,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: _controller.validateEmail,
              labelError: _controller.state.signupResult.errorEmail,
            ),
            const SizedBox(height: 8.0),
            DSTextField.form(
              key: const ValueKey(DSTextConstants.keyFieldPassword),
              controller: _controller.controllerPassword,
              labelText: DSString.of(DSTextConstants.labelPassword),
              isDense: true,
              prefix: const Icon(Icons.lock),
              state: _controller.state.passwordState,
              obscureText: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: _controller.validatePassword,
              labelError: _controller.state.signupResult.errorPassword,
            ),
            const SizedBox(height: 8.0),
            DSTextField.form(
              key: const ValueKey(DSTextConstants.keyFieldConfirmPassword),
              controller: _controller.controllerConfirmPassword,
              labelText: DSString.of(DSTextConstants.labelConfirmPassword),
              isDense: true,
              prefix: const Icon(Icons.lock),
              state: _controller.state.confirmPasswordState,
              obscureText: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: _controller.validateConfirmPassword,
            ),
            const SizedBox(height: 8.0),
            DSButton(
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
                    Expanded(
                      child: DSText(
                        DSString.of(DSTextConstants.labelSignup),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: DSLinkText(
                DSString.of(DSTextConstants.labelNavigateLogin),
                callback: _controller.state.isLoading ? null : widget.onBack,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onRegisterCallback() async {
    _controller.submit(widget.onRegister);
  }
}
