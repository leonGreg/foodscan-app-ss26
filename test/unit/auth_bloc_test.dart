import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_scan/features/auth/data/models/user_model.dart';
import 'package:food_scan/features/auth/data/services/auth_service_base.dart';
import 'package:food_scan/features/auth/presentation/bloc/auth_bloc.dart';

class MockAuthService extends AuthServiceBase {
  bool shouldFailLogin = false;
  bool shouldFailRegister = false;

  @override
  Stream<User?> get authStateChanges => const Stream.empty();

  @override
  User? get currentFirebaseUser => null;

  @override
  Future<AppUser> signInWithEmail(String email, String password) async {
    if (shouldFailLogin) {
      throw FirebaseAuthException(code: 'invalid-credential');
    }
    return AppUser(
      uid: 'fake-uid',
      email: email,
      displayName: 'Fake User',
      createdAt: DateTime(2024),
    );
  }

  @override
  Future<AppUser> registerWithEmail({
    required String email,
    required String password,
    required String displayName,
  }) async {
    if (shouldFailRegister) {
      throw FirebaseAuthException(code: 'email-already-in-use');
    }
    return AppUser(
      uid: 'new-uid',
      email: email,
      displayName: displayName,
      createdAt: DateTime(2024),
    );
  }

  @override
  Future<void> signOut() async {}

  @override
  Future<void> sendPasswordResetEmail(String email) async {}
}

void main() {
  late MockAuthService mockService;
  late AuthBloc bloc;

  setUp(() {
    mockService = MockAuthService();
    bloc = AuthBloc(authService: mockService);
  });

  tearDown(() async {
    await bloc.close();
  });

  // A freshly created bloc must not perform any side effects before an event arrives.
  test('initial state is AuthInitial', () {
    expect(bloc.state, const AuthInitial());
  });

  group('LoginRequested', () {
    // Successful login must load then authenticate, carrying the correct email.
    test('emits AuthLoading then AuthAuthenticated on success', () async {
      final states = <AuthState>[];
      final sub = bloc.stream.listen(states.add);

      bloc.add(
        const LoginRequested(email: 'user@test.com', password: 'pass123'),
      );
      await pumpEventQueue();

      expect(states.length, 2);
      expect(states[0], isA<AuthLoading>());
      expect(states[1], isA<AuthAuthenticated>());
      expect((states[1] as AuthAuthenticated).user.email, 'user@test.com');

      await sub.cancel();
    });

    // A FirebaseAuthException from the service must surface as AuthFailure, not a crash.
    test('emits AuthLoading then AuthFailure on invalid credentials', () async {
      mockService.shouldFailLogin = true;

      final states = <AuthState>[];
      final sub = bloc.stream.listen(states.add);

      bloc.add(const LoginRequested(email: 'user@test.com', password: 'wrong'));
      await pumpEventQueue();

      expect(states.length, 2);
      expect(states[0], isA<AuthLoading>());
      expect(states[1], isA<AuthFailure>());

      await sub.cancel();
    });
  });

  group('RegisterRequested', () {
    // Successful registration must authenticate and pass through the display name.
    test('emits AuthLoading then AuthAuthenticated on success', () async {
      final states = <AuthState>[];
      final sub = bloc.stream.listen(states.add);

      bloc.add(
        const RegisterRequested(
          email: 'new@user.com',
          password: 'pass123',
          displayName: 'New User',
        ),
      );
      await pumpEventQueue();

      expect(states.length, 2);
      expect(states[0], isA<AuthLoading>());
      expect(states[1], isA<AuthAuthenticated>());
      expect((states[1] as AuthAuthenticated).user.displayName, 'New User');

      await sub.cancel();
    });

    // A duplicate-email error from the service must result in AuthFailure.
    test('emits AuthFailure when email is already in use', () async {
      mockService.shouldFailRegister = true;

      final states = <AuthState>[];
      final sub = bloc.stream.listen(states.add);

      bloc.add(
        const RegisterRequested(
          email: 'taken@test.com',
          password: 'pass123',
          displayName: 'User',
        ),
      );
      await pumpEventQueue();

      expect(states[0], isA<AuthLoading>());
      expect(states[1], isA<AuthFailure>());

      await sub.cancel();
    });
  });

  group('LogoutRequested', () {
    // Logout must always result in the unauthenticated state, regardless of prior state.
    test('emits AuthUnauthenticated', () async {
      final states = <AuthState>[];
      final sub = bloc.stream.listen(states.add);

      bloc.add(const LogoutRequested());
      await pumpEventQueue();

      expect(states, [isA<AuthUnauthenticated>()]);

      await sub.cancel();
    });
  });
}
