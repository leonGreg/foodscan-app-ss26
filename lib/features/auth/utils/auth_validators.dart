import 'package:food_scan/l10n/app_localizations.dart';

// Pure validation functions (no localization, testable)

String? validateEmail(String? value) {
  if (value == null || value.trim().isEmpty) return 'required';
  if (!RegExp(r'^[\w\-.]+@([\w-]+\.)+[\w-]{2,}$').hasMatch(value.trim())) {
    return 'invalid';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) return 'required';
  if (value.length < 6) return 'tooShort';
  return null;
}

String? validateDisplayName(String? value) {
  if (value == null || value.trim().isEmpty) return 'required';
  return null;
}

String? validateConfirmPassword(String? value, String password) {
  if (value == null || value.isEmpty) return 'required';
  if (value != password) return 'mismatch';
  return null;
}

// Localized validator factories (for use in Form widgets)

String? Function(String?) emailValidator(AppLocalizations l10n) {
  return (value) {
    final err = validateEmail(value);
    if (err == 'required') return l10n.emailRequired;
    if (err == 'invalid') return l10n.emailInvalid;
    return null;
  };
}

String? Function(String?) passwordValidator(AppLocalizations l10n) {
  return (value) {
    final err = validatePassword(value);
    if (err == 'required') return l10n.passwordRequired;
    if (err == 'tooShort') return l10n.passwordTooShort;
    return null;
  };
}

String? Function(String?) displayNameValidator(AppLocalizations l10n) {
  return (value) {
    final err = validateDisplayName(value);
    if (err == 'required') return l10n.nameRequired;
    return null;
  };
}

String? Function(String?) confirmPasswordValidator(
  AppLocalizations l10n,
  String password,
) {
  return (value) {
    final err = validateConfirmPassword(value, password);
    if (err == 'required') return l10n.confirmPasswordRequired;
    if (err == 'mismatch') return l10n.passwordsDoNotMatch;
    return null;
  };
}
