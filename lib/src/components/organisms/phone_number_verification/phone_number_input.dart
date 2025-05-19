import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_design_system/flutter_design_system.dart';

typedef OnPhoneNumberChanged = void Function(String phoneNumber);

class DSPhoneNumberInput extends StatelessWidget {
  final Widget countryCodePicker;
  final OnPhoneNumberChanged onPhoneNumberChanged;
  final VoidCallback? onValidate;
  final bool isLoading;
  final String? errorMessage;
  const DSPhoneNumberInput({
    required this.countryCodePicker,
    required this.onPhoneNumberChanged,
    this.isLoading = false,
    this.onValidate,
    this.errorMessage,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final ds = DesignSystemProvider.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DSTextField(
          onChanged: onPhoneNumberChanged,
          prefix: countryCodePicker,
          labelText: DSString.of(DSTextConstants.labelPhoneNumber),
          state: _getState,
          labelError: errorMessage,
          keyboardType: TextInputType.phone,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          suffix: isLoading
              ? CircularProgressIndicator(
                  color: ds.colorScheme.primary.color,
                )
              : null,
        ),
        const SizedBox(height: 16.0),
        DSButton(
          onPressed: onValidate,
          child: DSText(DSString.of(DSTextConstants.labelSendSms)),
        ),
      ],
    );
  }

  DSTextFieldState get _getState {
    if (isLoading) {
      return DSTextFieldState.disabled;
    }
    if (errorMessage == null) {
      return DSTextFieldState.activated;
    } else {
      return DSTextFieldState.error;
    }
  }
}
