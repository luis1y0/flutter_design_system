import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DSTextStyles {
  static TextStyle base() {
    return const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      height: 1,
      letterSpacing: 0.25,
    );
  }

  static TextStyle headline() {
    return base().merge(const TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.bold,
      height: 1,
      letterSpacing: 0,
    ));
  }

  static TextStyle title() {
    return base().merge(const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.normal,
      height: 1.3,
      letterSpacing: -1,
    ));
  }

  static TextStyle cardTitle() {
    return base().merge(const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      height: 1.3,
      letterSpacing: 0.5,
    ));
  }

  static TextStyle cardSubtitle() {
    return base().merge(const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      height: 1.7,
      letterSpacing: 0.5,
    ));
  }

  static TextStyle placeholder() {
    return base().merge(const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      height: 1.45,
      letterSpacing: 0.25,
    ));
  }

  static TextStyle actionable() {
    return base().merge(const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.5,
      letterSpacing: 0.15,
    ));
  }

  static TextStyle quotation() {
    return base().merge(const TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.normal,
      height: 1.6,
      letterSpacing: 0.5,
    ));
  }

  static TextStyle editableQuotation() {
    return base().merge(const TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w200,
      height: 1.6,
      letterSpacing: 0.5,
    ));
  }
}
