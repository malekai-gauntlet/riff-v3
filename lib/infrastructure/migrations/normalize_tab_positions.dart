import 'package:cloud_firestore/cloud_firestore.dart';

/// Normalizes tab positions by dividing them by 27 and using the quotient as index
/// and remainder as position. This ensures all positions are within 0-26 range.
Future<void> normalizeTabPositions() async {
  try {
    // Get Firestore instance
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    
    print('\nStarting tab position normalization...');
    
    // Get all documents from ai_tabs collection
    final QuerySnapshot tabDocs = await firestore.collection('ai_tabs').get();
    
    print('Found ${tabDocs.docs.length} tab documents to process');
    
    // Process each tab document
    for (final DocumentSnapshot doc in tabDocs.docs) {
      final data = doc.data() as Map<String, dynamic>;
      
      // Get the content section
      final content = data['content'] as Map<String, dynamic>;
      if (!content.containsKey('sections')) {
        print('Skipping document ${doc.id}: No sections found');
        continue;
      }
      
      final sections = content['sections'] as List<dynamic>;
      if (sections.isEmpty) {
        print('Skipping document ${doc.id}: Empty sections');
        continue;
      }
      
      // Process first section (currently we only have one section)
      final section = Map<String, dynamic>.from(sections[0] as Map<dynamic, dynamic>);
      final measures = Map<String, dynamic>.from(section['measures'] as Map<dynamic, dynamic>);
      
      // Create new normalized measures
      final Map<String, dynamic> normalizedMeasures = {};
      
      // Track the highest position to determine total measures needed
      int highestPosition = 0;
      
      // First pass: find the highest position
      for (final measure in measures.values) {
        final measureData = Map<String, dynamic>.from(measure as Map<dynamic, dynamic>);
        final strings = Map<String, dynamic>.from(measureData['strings'] as Map<dynamic, dynamic>);
        
        for (final string in strings.values) {
          final stringData = Map<String, dynamic>.from(string as Map<dynamic, dynamic>);
          final notes = Map<String, dynamic>.from(stringData['notes'] as Map<dynamic, dynamic>);
          
          for (final note in notes.values) {
            final noteData = Map<String, dynamic>.from(note as Map<dynamic, dynamic>);
            final position = noteData['position'] as int;
            if (position > highestPosition) {
              highestPosition = position;
            }
          }
        }
      }
      
      print('Highest position found: $highestPosition');
      
      // Second pass: normalize positions
      for (final measure in measures.values) {
        final measureData = Map<String, dynamic>.from(measure as Map<dynamic, dynamic>);
        final strings = Map<String, dynamic>.from(measureData['strings'] as Map<dynamic, dynamic>);
        
        for (final stringEntry in strings.entries) {
          final stringData = Map<String, dynamic>.from(stringEntry.value as Map<dynamic, dynamic>);
          final notes = Map<String, dynamic>.from(stringData['notes'] as Map<dynamic, dynamic>);
          
          for (final noteEntry in notes.entries) {
            final noteData = Map<String, dynamic>.from(noteEntry.value as Map<dynamic, dynamic>);
            final oldPosition = noteData['position'] as int;
            
            // Calculate new index and position
            final newIndex = oldPosition ~/ 27;  // Integer division
            final newPosition = oldPosition - (newIndex * 27); // Remainder
            
            // Create or update measure at newIndex
            normalizedMeasures[newIndex.toString()] ??= {
              'index': newIndex,
              'timeSignature': '4/4',
              'strings': {},
            };
            
            // Create or update string in measure
            final measureStrings = normalizedMeasures[newIndex.toString()]!['strings'] as Map<String, dynamic>;
            measureStrings[stringEntry.key] ??= {
              'notes': {},
            };
            
            // Add note to string with new position
            final noteKey = measureStrings[stringEntry.key]['notes'].length.toString();
            measureStrings[stringEntry.key]['notes'][noteKey] = {
              'duration': noteData['duration'],
              'fret': noteData['fret'],
              'position': newPosition,
              'string': noteData['string'],
            };
          }
        }
      }
      
      // Update the document with normalized measures
      await doc.reference.update({
        'content.sections.0.measures': normalizedMeasures,
      });
      
      print('Normalized positions for tab document: ${doc.id}');
      print('Created ${normalizedMeasures.length} measures from original ${measures.length} measures');
    }
    
    print('\nSuccessfully normalized all tab positions');
    
  } catch (e, stackTrace) {
    print('Error normalizing tab positions: $e');
    print('Stack trace: $stackTrace');
    rethrow;
  }
} 