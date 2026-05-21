import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_scan/features/auth/data/models/user_model.dart';
import 'package:food_scan/features/auth/data/services/auth_service.dart';
import 'package:food_scan/features/auth/data/services/auth_service_base.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthServiceBase _authService;

  AuthBloc({AuthServiceBase? authService})
    : _authService = authService ?? AuthService(),
      super(const AuthInitial()) {
    on<AuthStarted>(_onAuthStarted);
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<UpdateProfileRequested>(_onUpdateProfileRequested);
    on<AuthErrorCleared>((_, emit) => emit(const AuthUnauthenticated()));
  }

  Future<void> _onAuthStarted(
    AuthStarted event,
    Emitter<AuthState> emit,
  ) async {
    await emit.forEach(
      _authService.authStateChanges,
      onData: (User? user) => user != null
          ? AuthAuthenticated(user: AppUser.fromFirebaseUser(user))
          : const AuthUnauthenticated(),
      onError: (_, _) => const AuthUnauthenticated(),
    );
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      final user = await _authService.signInWithEmail(
        event.email,
        event.password,
      );
      emit(AuthAuthenticated(user: user));
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(code: e.code));
    } catch (_) {
      emit(const AuthFailure(code: 'unknown'));
    }
  }

  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      final user = await _authService.registerWithEmail(
        email: event.email,
        password: event.password,
        displayName: event.displayName,
      );
      emit(AuthAuthenticated(user: user));
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(code: e.code));
    } catch (_) {
      emit(const AuthFailure(code: 'unknown'));
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _authService.signOut();
    emit(const AuthUnauthenticated());
  }

  Future<void> _onUpdateProfileRequested(
    UpdateProfileRequested event,
    Emitter<AuthState> emit,
  ) async {
    final current = state;
    if (current is! AuthAuthenticated) return;
    try {
      await _authService.updateDisplayName(event.displayName);
      emit(
        AuthAuthenticated(
          user: AppUser(
            uid: current.user.uid,
            email: current.user.email,
            displayName: event.displayName.trim(),
            createdAt: current.user.createdAt,
          ),
        ),
      );
    } catch (_) {
      emit(const AuthFailure(code: 'unknown'));
    }
  }
}
