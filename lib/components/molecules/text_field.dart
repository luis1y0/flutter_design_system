import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_design_system/flutter_design_system.dart';

enum DSTextFieldState { activated, disabled, focused, error }

typedef DSTextEditingCallback = void Function(String value);
typedef DSTextFormEditingCallback = void Function(String? value);
typedef DSTextFormValidateCallback = String? Function(String? value);

class DSTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? errorText;
  final DSTextFieldState state;
  final bool isDense;
  final DSTextEditingCallback? onChanged;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  /// Used only in default TextField constructor
  final DSTextEditingCallback? onSubmitted;

  /// Used only in TextField.form() constructor
  final DSTextFormEditingCallback? onSaved;
  final DSTextFormValidateCallback? validator;
  final AutovalidateMode? autovalidateMode;

  const DSTextField({
    this.controller,
    this.labelText,
    this.errorText,
    this.state = DSTextFieldState.activated,
    this.isDense = false,
    this.keyboardType,
    this.inputFormatters,
    this.onSubmitted,
    this.onChanged,
    super.key,
  })  : _isFormWidget = false,
        onSaved = null,
        validator = null,
        autovalidateMode = null;

  const DSTextField.form({
    this.controller,
    this.labelText,
    this.errorText,
    this.state = DSTextFieldState.activated,
    this.isDense = false,
    this.keyboardType,
    this.inputFormatters,
    this.onSaved,
    this.validator,
    this.autovalidateMode,
    this.onChanged,
    super.key,
  })  : _isFormWidget = true,
        onSubmitted = null;

  final bool _isFormWidget;

  @override
  Widget build(BuildContext context) {
    final ds = DesignSystemProvider.of(context);
    final colorScheme = ds.colorScheme;
    final inputDecoration = InputDecoration(
      alignLabelWithHint: true,
      labelText: labelText,
      contentPadding: const EdgeInsets.all(16.0),
      floatingLabelAlignment: FloatingLabelAlignment.start,
      floatingLabelStyle: DSTextStyles.base(),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      isDense: isDense,
      constraints: const BoxConstraints(
        maxWidth: 48.0,
      ),
      // Default
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: colorScheme.dark.color,
        ),
      ),
      // Focused
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: colorScheme.secondary.color,
        ),
      ),
      // Error
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
        color: colorScheme.error.color,
      )),
      errorStyle: DSTextStyles.quotation().copyWith(
        color: colorScheme.error.color,
      ),
      errorText: state == DSTextFieldState.error ? errorText : null,
    );
    if (_isFormWidget) {
      return TextFormField(
        controller: controller,
        onSaved: onSaved,
        onChanged: onChanged,
        validator: validator,
        autovalidateMode: autovalidateMode,
        enabled: state != DSTextFieldState.disabled,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        style: DSTextStyles.base(),
        cursorColor: colorScheme.secondary.color,
        decoration: inputDecoration,
      );
    }
    return TextField(
      controller: controller,
      onSubmitted: onSubmitted,
      onChanged: onChanged,
      enabled: state != DSTextFieldState.disabled,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      style: DSTextStyles.base(),
      cursorColor: colorScheme.secondary.color,
      decoration: inputDecoration,
    );
  }
}
