// This file defines the possible states of authentication using Freezed
import 'package:freezed_annotation/freezed_annotation.dart';
import 'auth_user.dart';

// Required for Freezed
part 'auth_state.freezed.dart';

// Define the AuthState class with Freezed
@freezed
class AuthState with _$AuthState {
  // Initial state when the app starts
  const factory AuthState.initial() = _Initial;
  
  // Loading state during authentication processes
  const factory AuthState.loading() = _Loading;
  
  // Authenticated state with user data
  const factory AuthState.authenticated(AuthUser user) = _Authenticated;
  
  // Unauthenticated state
  const factory AuthState.unauthenticated() = _Unauthenticated;
  
  // Error state with error message
  const factory AuthState.error(String message) = _Error;
} 