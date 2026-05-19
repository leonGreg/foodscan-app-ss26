import 'package:food_scan/l10n/app_localizations.dart';

String mapAuthErrorCode(String code, AppLocalizations l10n) {
  switch (code) {
    case 'user-not-found':
      return l10n.authErrorUserNotFound;
    case 'wrong-password':
      return l10n.authErrorWrongPassword;
    case 'email-already-in-use':
      return l10n.authErrorEmailAlreadyInUse;
    case 'invalid-email':
      return l10n.emailInvalid;
    case 'weak-password':
      return l10n.authErrorWeakPassword;
    case 'network-request-failed':
      return l10n.authErrorNetworkFailed;
    case 'too-many-requests':
      return l10n.authErrorTooManyRequests;
    case 'invalid-credential':
      return l10n.authErrorInvalidCredential;
    case 'missing-email':
      return l10n.emailRequired;
    default:
      return l10n.authErrorGeneric;
  }
}
