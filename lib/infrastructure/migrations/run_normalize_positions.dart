import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import '../../firebase_options.dart';
import 'normalize_tab_positions.dart';

/// Main function to run the tab position normalization migration
Future<void> main() async {
  try {
    // Initialize Flutter bindings
    WidgetsFlutterBinding.ensureInitialized();
    
    // Initialize Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    
    print('Starting tab position normalization migration...');
    
    // Run the normalization migration
    await normalizeTabPositions();
    
    print('\nMigration completed successfully!');
  } catch (e) {
    print('Error running migration: $e');
    rethrow;
  }
} 