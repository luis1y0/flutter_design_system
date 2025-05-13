import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart';

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
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.sizeOf(context).width * 0.1),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const DSTextField.form(
              key: ValueKey(DSTextConstants.emailFieldKey),
              prefix: Icon(Icons.alternate_email),
              labelText: 'Correo',
            ),
            DSTextField.form(
              key: const ValueKey(DSTextConstants.passwordFieldKey),
              prefix: const Icon(Icons.lock),
              suffix: IconButton(
                onPressed: () {
                  //
                },
                icon: const Icon(Icons.visibility),
              ),
              labelText: 'Contraseña',
            ),
            Align(
              alignment: Alignment.centerRight,
              child: DSLinkText(
                'Olvide mi contraseña',
                callback: widget.onForgetPasswordCallback,
              ),
            ),
            const DSButton(
              key: ValueKey(DSTextConstants.signinButtonKey),
              child: DSText('Entrar'),
            ),
            Align(
              alignment: Alignment.center,
              child: DSLinkText(
                '¿No tienes una cuenta? Registrate',
                callback: widget.onNavigateToSignup,
              ),
            )
          ],
        ),
      ),
    );
  }
}
