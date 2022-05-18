import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Helper {
  static toast(String message) {
    Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_LONG);
  }

  static String? validateReferralCode(String? value) {
    String pattern = r"\w{3}-\w{3}";
    RegExp regExp = RegExp(pattern);
    if (value == null || value.isEmpty) {
      return 'referral code is required';
    } else if (!regExp.hasMatch(value)) {
      return 'invalid referral code format';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      return 'enter a valid email address';
    } else {
      return null;
    }
  }

  static String? validatePassword(String? value) {
    String pattern = r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$";
    final regexp = RegExp(pattern);
    if (value == null || value.isEmpty) {
      return 'enter a password';
    } else if (!regexp.hasMatch(value)) {
      return 'password must have at least one alphabet, one number and at least 6 characters';
    } else {
      return null;
    }
  }

  static enabledBorder() => OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(
          color: Color(0xff4f4f4f),
          width: 1,
        ),
      );

  static focusedBorder() => OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(
          color: Colors.white.withOpacity(0.6),
          width: 1,
        ),
      );
}
