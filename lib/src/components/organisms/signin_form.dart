import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart';

/// Called when Register button is clicked, if any error happens
/// a String message is returned
typedef DSOnSigninCallback = Future<DSSignupResult> Function(
    String email, String password);
typedef DSOnNavigateToSignupCallback = void Function();

class DSSigninForm extends StatefulWidget {
  final DSOnSigninCallback? onSignin;
  final DSOnNavigateToSignupCallback? onNavigateToSignup;
  const DSSigninForm({
    this.onSignin,
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
      child: const Form(
        child: Placeholder(),
      ),
    );
  }
}
