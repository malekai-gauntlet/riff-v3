import 'package:firebase_core/firebase_core.dart';
import '../../firebase_options.dart';
import 'rollback_second_batch.dart';

/// Main function to run rollback
Future<void> main() async {
  try {
    // Initialize Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    
    print('Running rollback...');
    await rollbackSecondBatch();
    print('Rollback completed successfully!');
  } catch (e) {
    print('Error during rollback: $e');
    rethrow;
  }
} 