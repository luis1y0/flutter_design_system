import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart';

class DSLoginScreen extends StatefulWidget {
  final Widget logo;
  final VoidCallback onTermsAndConditions;
  final VoidCallback onPrivacyPolicy;
  final DSOnForgetPasswordCallback onForgotPassword;
  final DSOnSigninCallback onSigninCallback;
  final DSOnRegisterCallback onRegisterCallback;
  const DSLoginScreen({
    super.key,
    required this.logo,
    required this.onForgotPassword,
    required this.onTermsAndConditions,
    required this.onPrivacyPolicy,
    required this.onSigninCallback,
    required this.onRegisterCallback,
  });

  @override
  State<DSLoginScreen> createState() => _DSLoginScreenState();
}

class _DSLoginScreenState extends State<DSLoginScreen> {
  bool _showSignin = true;
  @override
  Widget build(BuildContext context) {
    final sizeLogo =
        min(200, MediaQuery.sizeOf(context).width * 0.7).toDouble();
    return Scaffold(
      body: ListView(
        children: [
          FlutterLogo(
            size: sizeLogo,
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              final begin = switch (child) {
                DSSigninForm() => -1.0,
                DSSignupForm() => 1.0,
                _ => 0.0
              };
              final animate = animation.drive(Tween<Offset>(
                begin: Offset(begin, 0.0),
                end: const Offset(0.0, 0.0),
              ));
              return SlideTransition(
                position: animate,
                child: child,
              );
            },
            child: _buildForm(isSignIn: _showSignin),
          ),
          Row(
            children: [
              Expanded(
                child: Center(
                  child: DSLinkText(
                    'Terms and Conditions',
                    callback: widget.onTermsAndConditions,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: DSLinkText(
                    'Privacy Policy',
                    callback: widget.onPrivacyPolicy,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildForm({bool isSignIn = true}) {
    if (isSignIn) {
      return DSSigninForm(
        onNavigateToSignup: () {
          setState(() {
            _showSignin = !_showSignin;
          });
        },
        onSignin: widget.onSigninCallback,
        onForgetPasswordCallback: widget.onForgotPassword,
      );
    } else {
      return DSSignupForm(
        onBack: () {
          setState(() {
            _showSignin = !_showSignin;
          });
        },
        onRegister: widget.onRegisterCallback,
      );
    }
  }
}
