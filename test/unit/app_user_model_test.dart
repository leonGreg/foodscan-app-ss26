import 'package:flutter_test/flutter_test.dart';
import 'package:food_scan/features/auth/data/models/user_model.dart';

void main() {
  final fixedDate = DateTime(2026, 3, 15, 10, 30);

  group('AppUser.toMap', () {
    // Every field must appear in the serialised map with the correct value.
    test('returns map with all fields', () {
      final user = AppUser(
        uid: 'uid-123',
        email: 'test@example.com',
        displayName: 'Test User',
        createdAt: fixedDate,
      );

      final map = user.toMap();

      expect(map['uid'], 'uid-123');
      expect(map['email'], 'test@example.com');
      expect(map['displayName'], 'Test User');
      expect(map['createdAt'], fixedDate.millisecondsSinceEpoch);
    });

    // No extra or missing keys — the map shape must be exact.
    test('toMap contains exactly the expected keys', () {
      final user = AppUser(
        uid: 'u1',
        email: 'a@b.com',
        displayName: 'Adam',
        createdAt: fixedDate,
      );

      final keys = user.toMap().keys.toSet();
      expect(keys, {'uid', 'email', 'displayName', 'createdAt'});
    });
  });

  group('AppUser.fromMap', () {
    // Deserialisation must produce an object with the correct field values.
    test('creates user with correct fields', () {
      final map = {
        'uid': 'uid-456',
        'email': 'hello@world.com',
        'displayName': 'Hello World',
        'createdAt': fixedDate.millisecondsSinceEpoch,
      };

      final user = AppUser.fromMap(map);

      expect(user.uid, 'uid-456');
      expect(user.email, 'hello@world.com');
      expect(user.displayName, 'Hello World');
      expect(user.createdAt, fixedDate);
    });
  });

  group('AppUser fromMap/toMap roundtrip', () {
    // An object serialised and then deserialised must equal the original.
    test('reconstructed user equals original', () {
      final original = AppUser(
        uid: 'uid-789',
        email: 'round@trip.com',
        displayName: 'Round Trip',
        createdAt: fixedDate,
      );

      final reconstructed = AppUser.fromMap(original.toMap());

      expect(reconstructed, original);
    });

    // Each individual field survives the roundtrip without corruption.
    test('roundtrip preserves all field values', () {
      final original = AppUser(
        uid: 'abc',
        email: 'preserve@test.de',
        displayName: 'Preserve Me',
        createdAt: DateTime(2023, 1, 1),
      );

      final copy = AppUser.fromMap(original.toMap());

      expect(copy.uid, original.uid);
      expect(copy.email, original.email);
      expect(copy.displayName, original.displayName);
      expect(copy.createdAt, original.createdAt);
    });
  });
}
