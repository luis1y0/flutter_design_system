import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart';

part 'data.dart';

/// Called when Register button is clicked, if any error happens
/// a String message is returned
typedef DSOnSigninCallback = Future<DSSignupResult> Function(
    String email, String password);
typedef DSOnForgetPasswordCallback = void Function();
typedef DSOnNavigateToSignupCallback = void Function();

class DSSigninForm extends StatefulWidget {
  final DSOnSigninCallback? onSignin;
  final DSOnForgetPasswordCallback? onForgetPasswordCallback;
  final DSOnNavigateToSignupCallback? onNavigateToSignup;
  const DSSigninForm({
    this.onSignin,
    this.onForgetPasswordCallback,
    this.onNavigateToSignup,
    super.key,
  });

  @override
  State<DSSigninForm> createState() => _DSSigninFormState();
}

class _DSSigninFormState extends State<DSSigninForm> {
  final DSSigninFormController _controller = DSSigninFormController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.sizeOf(context).width * 0.1),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DSTextField.form(
              key: const ValueKey(DSTextConstants.keyFieldEmail),
              controller: _controller.controllerEmail,
              prefix: const Icon(Icons.alternate_email),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: _controller.validateEmail,
              labelText: DSString.of(DSTextConstants.labelEmail),
            ),
            DSTextField.form(
              key: const ValueKey(DSTextConstants.keyFieldPassword),
              controller: _controller.controllerPassword,
              prefix: const Icon(Icons.lock),
              obscureText: !_controller.state.isPasswordVisible,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: _controller.validatePassword,
              suffix: IconButton(
                onPressed: () {
                  _controller.togglePasswordVisibility();
                },
                icon: Icon(switch (_controller.state.isPasswordVisible) {
                  true => Icons.visibility_off,
                  false => Icons.visibility,
                }),
              ),
              labelText: DSString.of(DSTextConstants.labelPassword),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: DSLinkText(
                DSString.of(DSTextConstants.labelForgotPassword),
                callback: widget.onForgetPasswordCallback,
              ),
            ),
            DSButton(
              key: const ValueKey(DSTextConstants.keyBtnSignin),
              onPressed: _controller.state.isButtonEnabled ? () {} : null,
              child: DSText(DSString.of(DSTextConstants.labelSignin)),
            ),
            Align(
              alignment: Alignment.center,
              child: DSLinkText(
                DSString.of(DSTextConstants.labelCreateAccount),
                callback: widget.onNavigateToSignup,
              ),
            )
          ],
        ),
      ),
    );
  }
}
