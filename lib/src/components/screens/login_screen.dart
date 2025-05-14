import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart';

class DSLoginScreen extends StatefulWidget {
  const DSLoginScreen({super.key});

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
          const Row(
            children: [
              Expanded(
                child: Center(
                  child: DSLinkText('Terms and Conditions'),
                ),
              ),
              Expanded(
                child: Center(
                  child: DSLinkText('Privacy Policy'),
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
      );
    } else {
      return DSSignupForm(
        onBack: () {
          setState(() {
            _showSignin = !_showSignin;
          });
        },
      );
    }
  }
}
