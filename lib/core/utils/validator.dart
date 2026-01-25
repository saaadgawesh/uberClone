import 'package:flutter/material.dart';
import 'package:uberCloneDriver/l10n/app_localizations.dart';

class Validator {
  static String? validateEmail(String? val, BuildContext context) {
    final applocalizations = AppLocalizations.of(context)!;
    final RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    if (val == null) {
      return applocalizations.thisfieldisrequired;
    } else if (val.trim().isEmpty) {
      return applocalizations.thisfieldisrequired;
    } else if (emailRegex.hasMatch(val) == false) {
      return "enter valid email";
    } else {
      return null;
    }
  }

  static String? validatePassword(String? val, BuildContext context) {
    final applocalizations = AppLocalizations.of(context)!;
    if (val == null) {
      return applocalizations.thisfieldisrequired;
    } else if (val.isEmpty) {
      return applocalizations.thisfieldisrequired;
    } else if (val.length < 8) {
      return "strong password please";
    } else {
      return null;
    }
  }

  static String? validateConfirmPassword(
    String? val,
    String? password,
    BuildContext context,
  ) {
    final applocalizations = AppLocalizations.of(context)!;
    if (val == null || val.isEmpty) {
      return applocalizations.thisfieldisrequired;
    } else if (val != password) {
      return "same password";
    } else {
      return null;
    }
  }

  static String? validateUsername(String? val, BuildContext context) {
    final applocalizations = AppLocalizations.of(context)!;
    final RegExp usernameRegex = RegExp(r'^[a-zA-Z0-9,.-]+$');
    if (val == null) {
      return applocalizations.thisfieldisrequired;
    } else if (val.isEmpty) {
      return applocalizations.thisfieldisrequired;
    } else if (!usernameRegex.hasMatch(val)) {
      return "enter valid username";
    } else {
      return null;
    }
  }

  static String? validateFullName(String? val, BuildContext context) {
    final applocalizations = AppLocalizations.of(context)!;
    if (val == null || val.isEmpty) {
      return applocalizations.thisfieldisrequired;
    } else {
      return null;
    }
  }

  static String? validatePhoneNumber(String? val, BuildContext context) {
    final applocalizations = AppLocalizations.of(context)!;
    if (val == null) {
      return applocalizations.thisfieldisrequired;
    } else if (int.tryParse(val.trim()) == null) {
      return applocalizations.enternumbersonly;
    } else if (val.trim().length != 11) {
      return applocalizations.entervaluemustequal11digit;
    } else {
      return null;
    }
  }
}
