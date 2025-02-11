import 'package:flutter/material.dart';
import '../../../auth/infrastructure/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {
  final _authRepository = AuthRepository();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _displayNameController = TextEditingController();
  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;
  late final AnimationController _exitController;
  late final Animation<Offset> _logoSlideAnimation;
  late final Animation<Offset> _titleSlideAnimation;
  late final Animation<Offset> _emailButtonSlideAnimation;
  late final Animation<Offset> _skipButtonSlideAnimation;
  String? _errorMessage;
  bool _isLoading = false;
  bool _showInputs = false;
  bool _isSignUpMode = false;
  bool _acceptedTerms = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        reverseCurve: const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.0, 0.05),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        reverseCurve: const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );
    
    // Initialize exit animations controller
    _exitController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500), // Back to 1 second duration
    );

    // Create staggered slide animations for each element
    _logoSlideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(3.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _exitController,
      curve: const Interval(0.0, 0.25, curve: Curves.easeInOut),
    ));

    _titleSlideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(3.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _exitController,
      curve: const Interval(0.25, 0.5, curve: Curves.easeInOut),
    ));

    _emailButtonSlideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(3.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _exitController,
      curve: const Interval(0.5, 0.75, curve: Curves.easeInOut),
    ));

    _skipButtonSlideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(3.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _exitController,
      curve: const Interval(0.75, 1.0, curve: Curves.easeInOut),
    ));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _displayNameController.dispose();
    _animationController.dispose();
    _exitController.dispose();
    super.dispose();
  }

  void _toggleInputs() {
    setState(() {
      _showInputs = true;
    });
  }

  void _toggleAuthMode() async {
    if (_animationController.isAnimating) return;
    
    await _animationController.forward();
    setState(() {
      _isSignUpMode = !_isSignUpMode;
      _errorMessage = null;
    });
    await _animationController.reverse();
  }

  Future<void> _signIn() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await _authRepository.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
        rememberMe: true, // Default to true for better UX
      );
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Successfully signed in!')),
        );
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _signUp() async {
    // Check terms acceptance
    if (!_acceptedTerms) {
      setState(() {
        _errorMessage = 'Please accept the Terms of Service to continue';
      });
      return;
    }

    // Check if display name is provided
    final displayName = _displayNameController.text.trim();
    if (displayName.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter a display name';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Create the user account
      final userCredential = await _authRepository.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      // Update display name through Firebase Auth directly
      await FirebaseAuth.instance.currentUser?.updateDisplayName(displayName);
      
      // Wait for the display name to be properly set
      await FirebaseAuth.instance.currentUser?.reload();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Welcome to Riff, $displayName!'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        // Provide user-friendly error messages
        _errorMessage = switch (e.code) {
          'email-already-in-use' => 'This email is already registered',
          'invalid-email' => 'Please enter a valid email address',
          'operation-not-allowed' => 'Email/password accounts are not enabled',
          'weak-password' => 'Please choose a stronger password',
          _ => e.message ?? 'An error occurred during sign up'
        };
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'An unexpected error occurred';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // Handle guest sign-in
  Future<void> _signInAsGuest() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await _exitController.forward();
      
      await _authRepository.signInAnonymously();
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Welcome! Signed in as guest')),
        );
      }
    } catch (e) {
      _exitController.reverse();
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            children: [
              // Animated Logo and Title Section
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOut,
                margin: EdgeInsets.only(
                  top: _showInputs ? 60 : MediaQuery.of(context).size.height * 0.3,
                ),
                child: Column(
                  children: [
                    // Logo with slide animation
                    SlideTransition(
                      position: _logoSlideAnimation,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        width: _showInputs ? 80 : 120,
                        height: _showInputs ? 80 : 120,
                        child: SvgPicture.asset(
                          'assets/images/electric-guitar.svg',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Title with slide animation
                    SlideTransition(
                      position: _titleSlideAnimation,
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 300),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: _isSignUpMode ? 30 : 34,
                          fontWeight: FontWeight.w600,
                          height: 1.2,
                          letterSpacing: -0.5,
                        ),
                        child: Text(
                          _isSignUpMode ? 'Create\nAccount' : 'Welcome to\nRiff',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              const Spacer(),
              
              // Initial buttons with slide animations
              if (!_showInputs) ...[
                SlideTransition(
                  position: _emailButtonSlideAnimation,
                  child: _buildLoginButton(
                    text: 'Continue with E-mail',
                    icon: Icons.mail_outline,
                    onTap: _toggleInputs,
                  ),
                ),
                const SizedBox(height: 16),
                SlideTransition(
                  position: _skipButtonSlideAnimation,
                  child: _buildLoginButton(
                    text: 'Skip Signup',
                    icon: Icons.fast_forward_rounded,
                    onTap: _isLoading ? null : _signInAsGuest,
                    isSecondary: true,
                  ),
                ),
              ],
              
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton({
    required String text,
    required IconData icon,
    required VoidCallback? onTap,
    bool isSecondary = false,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 44,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: isSecondary ? Colors.transparent : Colors.white,
          foregroundColor: isSecondary ? Colors.white : Colors.black,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
            side: isSecondary ? BorderSide(color: Colors.white.withOpacity(0.5)) : BorderSide.none,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSecondary ? Colors.white : Colors.black,
            ),
            const SizedBox(width: 12),
            Text(
              text,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.3,
                color: isSecondary ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 