import 'package:firebase_core/firebase_core.dart';
import '../../../firebase_options.dart';
import 'add_sample_notes.dart';

/// Runs all migrations in sequence
Future<void> runMigrations() async {
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  print('🚀 Running migrations...\n');
  
  // Run migrations in sequence
  await AddSampleNotesMigration.run();
  
  print('\n✅ All migrations completed');
} 