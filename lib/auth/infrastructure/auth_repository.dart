// Repository that handles all authentication related operations
import 'package:firebase_auth/firebase_auth.dart';
import '../domain/models/auth_user.dart';
import 'package:flutter/foundation.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;

  // Constructor that takes a FirebaseAuth instance
  AuthRepository({FirebaseAuth? firebaseAuth}) 
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  // Public method to set persistence
  Future<void> setPersistence(bool rememberMe) async {
    if (kIsWeb) {
      try {
        await _firebaseAuth.setPersistence(
          rememberMe ? Persistence.LOCAL : Persistence.SESSION
        );
        print('Persistence set to: ${rememberMe ? 'LOCAL' : 'SESSION'}'); // Debug log
      } catch (e) {
        print('Error setting persistence: $e'); // Debug log
        rethrow;
      }
    }
  }

  // Get the current user as a Stream
  Stream<AuthUser?> get authStateChanges => 
    _firebaseAuth.authStateChanges().map(_mapFirebaseUser);

  // Convert Firebase User to our AuthUser model
  AuthUser? _mapFirebaseUser(User? user) {
    if (user == null) {
      return null;
    }
    
    return AuthUser(
      id: user.uid,
      email: user.email ?? '', // Make email optional for anonymous users
      displayName: user.displayName,
      photoURL: user.photoURL,
      emailVerified: user.emailVerified,
    );
  }

  // Sign in with email and password
  Future<AuthUser?> signInWithEmailAndPassword({
    required String email,
    required String password,
    bool rememberMe = true,
  }) async {
    try {
      // Set persistence before signing in
      await setPersistence(rememberMe);
      
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _mapFirebaseUser(userCredential.user);
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseAuthError(e);
    }
  }

  // Sign up with email and password
  Future<AuthUser?> createUserWithEmailAndPassword({
    required String email,
    required String password,
    bool rememberMe = true,
  }) async {
    try {
      // Set persistence before signing up
      await setPersistence(rememberMe);
      
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _mapFirebaseUser(userCredential.user);
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseAuthError(e);
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  // Sign in anonymously as guest
  Future<AuthUser?> signInAnonymously() async {
    try {
      // Set persistence to local for guest users
      await setPersistence(true);
      
      print('📱 Starting anonymous sign-in...'); // Debug log
      final userCredential = await _firebaseAuth.signInAnonymously();
      print('✅ Anonymous sign-in successful'); // Debug log
      
      return _mapFirebaseUser(userCredential.user);
    } on FirebaseAuthException catch (e) {
      print('❌ Anonymous sign-in error: ${e.code}'); // Debug log
      throw _mapFirebaseAuthError(e);
    }
  }

  // Map Firebase Auth errors to user-friendly messages
  String _mapFirebaseAuthError(FirebaseAuthException error) {
    switch (error.code) {
      case 'user-not-found':
        return 'No user found with this email.';
      case 'wrong-password':
        return 'Wrong password provided.';
      case 'email-already-in-use':
        return 'An account already exists with this email.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'weak-password':
        return 'The password provided is too weak.';
      default:
        return 'An error occurred. Please try again.';
    }
  }
} 