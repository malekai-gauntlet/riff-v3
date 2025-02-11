// This file defines the authenticated user data model using Freezed
import 'package:freezed_annotation/freezed_annotation.dart';

// Required for Freezed
part 'auth_user.freezed.dart';

// Define the AuthUser class with Freezed
@freezed
class AuthUser with _$AuthUser {
  // Factory constructor with required user data
  const factory AuthUser({
    required String id,
    required String email,
    String? displayName,
    String? photoURL,
    @Default(false) bool emailVerified,
  }) = _AuthUser;
} 