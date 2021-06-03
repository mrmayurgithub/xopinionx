import 'package:flutter/foundation.dart';

class Validator {
  String validateEmail(String email) {
    const Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

//TODO: check, initially it was just pattern, not pattern.toString()
    final RegExp regex = RegExp(pattern.toString());

    if (email.isEmpty) {
      return "This field cannot be empty";
    } else if (!regex.hasMatch(email)) {
      return "Enter a valid email";
    } else {
      return null;
    }
  }

  String validatePassword(String password) {
    if (password.isEmpty) {
      return "This field cannot be empty";
    } else if (password.length < 8) {
      return "Password length too short";
    } else if (password.contains(" ")) {
      return "Password should not contain spaces";
    } else {
      return null;
    }
  }

  String validateConfirmPassword(
      {@required String confirmPassword, @required String newPassword}) {
    final _normalValidation = validatePassword(confirmPassword);

    if (_normalValidation != null) return _normalValidation;

    if (confirmPassword != newPassword) {
      return "Passwords do not match";
    } else {
      return null;
    }
  }

  String validateCost(String cost) {
    if (cost.isEmpty) {
      return "This field cannot be empty";
    } else if (cost.contains(",") ||
        cost.contains("-") ||
        cost.contains(" ") ||
        cost.contains("_")) {
      return "Enter a valid amount";
    } else if (cost.contains(RegExp('[A-Za-z]'))) {
      return "Enter a valid amount";
    } else {
      return null;
    }
  }

  String validateName(String name) {
    if (name.isEmpty) {
      return "This field cannot be empty";
    } else if (name.contains(RegExp('[0-9]'))) {
      return "Enter a valid name";
    } else {
      return null;
    }
  }

  ///  To validate normal text which cannot be empty
  String validateNonEmptyText(String text) {
    if (text.isEmpty) {
      return "This field cannot be empty";
    } else {
      return null;
    }
  }

  ///  To validate normal text which can be empty
  String validateCanBeEmptyText(String text) {
    return null;
  }
}
