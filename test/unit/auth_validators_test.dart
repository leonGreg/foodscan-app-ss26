import 'package:flutter_test/flutter_test.dart';
import 'package:food_scan/features/auth/utils/auth_validators.dart';

void main() {
  group('validateEmail', () {
    // Null must be treated as empty — no crash.
    test('returns error for null input', () {
      expect(validateEmail(null), isNotNull);
    });

    // Empty string is not a valid email.
    test('returns error for empty string', () {
      expect(validateEmail(''), isNotNull);
    });

    // Whitespace-only should be rejected after trim.
    test('returns error for whitespace only', () {
      expect(validateEmail('   '), isNotNull);
    });

    // A string without @ cannot be a valid email address.
    test('returns error for missing @ symbol', () {
      expect(validateEmail('notanemail'), isNotNull);
    });

    // Addresses like "user@" have no domain part.
    test('returns error for missing domain', () {
      expect(validateEmail('user@'), isNotNull);
    });

    // A domain without a TLD (e.g. "user@domain") fails the regex.
    test('returns error for missing TLD', () {
      expect(validateEmail('user@domain'), isNotNull);
    });

    // Standard address — must pass without error.
    test('returns null for valid email', () {
      expect(validateEmail('user@example.com'), isNull);
    });

    // Subdomains are valid and must not be rejected.
    test('returns null for valid email with subdomain', () {
      expect(validateEmail('user@mail.example.org'), isNull);
    });

    // Dots in the local part are allowed per RFC.
    test('returns null for email with dots in local part', () {
      expect(validateEmail('first.last@example.com'), isNull);
    });
  });

  group('validatePassword', () {
    // Null must be treated as missing — no crash.
    test('returns error for null input', () {
      expect(validatePassword(null), isNotNull);
    });

    // Empty string means the field was left blank.
    test('returns error for empty string', () {
      expect(validatePassword(''), isNotNull);
    });

    // A 3-character password is below the 6-character minimum.
    test('returns error for password with 3 characters', () {
      expect(validatePassword('abc'), isNotNull);
    });

    // A 5-character password is one character short of the minimum.
    test('returns error for password with 5 characters', () {
      expect(validatePassword('12345'), isNotNull);
    });

    // Exactly 6 characters is the minimum accepted length.
    test('returns null for password with exactly 6 characters', () {
      expect(validatePassword('abc123'), isNull);
    });

    // Any password above the minimum must be accepted.
    test('returns null for password longer than 6 characters', () {
      expect(validatePassword('securepassword'), isNull);
    });
  });

  group('validateDisplayName', () {
    // Null must not crash the validator.
    test('returns error for null input', () {
      expect(validateDisplayName(null), isNotNull);
    });

    // An empty name is not acceptable.
    test('returns error for empty string', () {
      expect(validateDisplayName(''), isNotNull);
    });

    // A name that is only spaces should be rejected after trim.
    test('returns error for whitespace only', () {
      expect(validateDisplayName('   '), isNotNull);
    });

    // A single word name is valid.
    test('returns null for valid name', () {
      expect(validateDisplayName('John'), isNull);
    });

    // Names with spaces (first + last) must also be accepted.
    test('returns null for name with spaces', () {
      expect(validateDisplayName('John Doe'), isNull);
    });
  });

  group('validateConfirmPassword', () {
    // Null confirm field must not crash; treated as empty.
    test('returns error for null input', () {
      expect(validateConfirmPassword(null, 'password'), isNotNull);
    });

    // Empty confirm means the field was left blank.
    test('returns error for empty string', () {
      expect(validateConfirmPassword('', 'password'), isNotNull);
    });

    // Mismatched values must always be rejected regardless of content.
    test('returns error when passwords do not match', () {
      expect(validateConfirmPassword('other', 'password'), isNotNull);
    });

    // Identical values must pass validation.
    test('returns null when passwords match', () {
      expect(validateConfirmPassword('password123', 'password123'), isNull);
    });

    // Null confirm with empty original is still an empty-field error.
    test('returns error when confirm is null but password is empty', () {
      expect(validateConfirmPassword(null, ''), isNotNull);
    });
  });
}
