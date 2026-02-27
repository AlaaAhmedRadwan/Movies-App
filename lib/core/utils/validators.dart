import 'package:easy_localization/easy_localization.dart';
import '../strings_manager/AppStrings.dart';

class Validators {
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.emailRequired.tr();
    }

    final emailRegex =
    RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(value)) {
      return AppStrings.invalidEmail.tr();
    }

    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.passwordRequired.tr();
    }

    if (value.length < 6) {
      return AppStrings.passwordShort.tr();
    }

    return null;
  }
}