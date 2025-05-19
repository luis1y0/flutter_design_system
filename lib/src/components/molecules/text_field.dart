import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_design_system/flutter_design_system.dart';

enum DSTextFieldState { activated, disabled, focused, error }

typedef DSTextEditingCallback = void Function(String value);
typedef DSTextFormEditingCallback = void Function(String? value);
typedef DSTextFormValidateCallback = String? Function(String? value);

class DSTextField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Iterable<String>? autofillHints;
  final String? labelText;
  final String? labelError;
  final DSTextFieldState state;
  final bool isDense;
  final TextStyle? style;
  final TextAlign textAlign;
  final int? maxLength;
  final EdgeInsetsGeometry? contentPadding;
  final DSTextEditingCallback? onChanged;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final Widget? prefix;
  final Widget? suffix;

  /// Used only in default TextField constructor
  final DSTextEditingCallback? onSubmitted;

  /// Used only in TextField.form() constructor
  final DSTextFormEditingCallback? onSaved;
  final DSTextFormValidateCallback? validator;
  final AutovalidateMode? autovalidateMode;

  const DSTextField({
    this.controller,
    this.focusNode,
    this.autofillHints,
    this.labelText,
    this.labelError,
    this.state = DSTextFieldState.activated,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLength,
    this.contentPadding,
    this.isDense = false,
    this.prefix,
    this.suffix,
    this.keyboardType,
    this.obscureText = false,
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
    this.focusNode,
    this.autofillHints,
    this.labelText,
    this.labelError,
    this.state = DSTextFieldState.activated,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLength,
    this.contentPadding,
    this.isDense = false,
    this.prefix,
    this.suffix,
    this.keyboardType,
    this.obscureText = false,
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
      contentPadding: contentPadding,
      floatingLabelAlignment: FloatingLabelAlignment.start,
      floatingLabelStyle: DSTextStyles.base(),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      isDense: isDense,
      constraints: const BoxConstraints(
        maxWidth: 48.0,
      ),
      // side icons
      prefixIcon: prefix,
      prefixIconColor: colorScheme.primary.color,
      suffixIcon: suffix,
      suffixIconColor: colorScheme.primary.color,
      error: labelError != null
          ? DSText(
              labelError!,
              style: TextStyle(color: colorScheme.error.color),
            )
          : null,
      // Default
      border: UnderlineInputBorder(
        borderSide: BorderSide(
          color: colorScheme.dark.color,
        ),
      ),
      // Focused
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: colorScheme.primary.color,
        ),
      ),
      // Error
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: colorScheme.error.color,
        ),
      ),
      errorStyle: DSTextStyles.quotation().copyWith(
        color: colorScheme.error.color,
      ),
    );
    if (_isFormWidget) {
      return TextFormField(
        controller: controller,
        focusNode: focusNode,
        autofillHints: autofillHints,
        onSaved: onSaved,
        onChanged: onChanged,
        validator: validator,
        autovalidateMode: autovalidateMode,
        obscureText: obscureText,
        enabled: state != DSTextFieldState.disabled,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        style: style,
        textAlign: textAlign,
        buildCounter: (context,
            {required currentLength, required isFocused, required maxLength}) {
          return const SizedBox.shrink();
        },
        cursorColor: colorScheme.primary.color,
        decoration: inputDecoration,
      );
    }
    return TextField(
      controller: controller,
      focusNode: focusNode,
      autofillHints: autofillHints,
      onSubmitted: onSubmitted,
      onChanged: onChanged,
      obscureText: obscureText,
      enabled: state != DSTextFieldState.disabled,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      style: style,
      textAlign: textAlign,
      maxLength: maxLength,
      buildCounter: (context,
          {required currentLength, required isFocused, required maxLength}) {
        return const SizedBox.shrink();
      },
      cursorColor: colorScheme.secondary.color,
      decoration: inputDecoration,
    );
  }
}
