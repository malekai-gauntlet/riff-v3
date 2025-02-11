import 'package:cloud_firestore/cloud_firestore.dart';

/// Rolls back the second batch of videos by deleting them from Firestore
Future<void> rollbackSecondBatch() async {
  try {
    // Get Firestore instance
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    
    // List of document IDs to delete
    final idsToDelete = [
      '3sP72f6Wo5VhykFhRRKZ',
      'vhx71oP9OqEbDXX7w2Ev',
      'jbAuxEWleIf3OEhHOUb8',
      'rRm7pW0iArk7rOZEXvn0',
      '6S2J4X4GL8srRKcVME7s',
      'HjkaBqXeADvTKc0eEPIT',
      '7cV9uV0t4DgjwPSOrI6A'
    ];

    print('\nStarting rollback of second batch videos...');
    print('Videos to delete: ${idsToDelete.length}');

    // Delete each video
    for (final id in idsToDelete) {
      try {
        await firestore.collection('videos').doc(id).delete();
        print('Deleted video with ID: $id');
      } catch (e) {
        print('Error deleting video $id: $e');
      }
    }

    print('\nRollback completed successfully');
  } catch (e) {
    print('Error during rollback: $e');
    rethrow;
  }
} 