import 'package:cloud_firestore/cloud_firestore.dart';
import 'tab_template.dart';
import '../video/video_model.dart';

/// Repository for managing tab storage and retrieval
class TabRepository {
  final FirebaseFirestore _firestore;
  
  TabRepository({FirebaseFirestore? firestore}) 
      : _firestore = firestore ?? FirebaseFirestore.instance;
  
  /// Collection reference for tabs
  CollectionReference get _tabsCollection => 
      _firestore.collection('ai_tabs');
  
  /// Gets a tab for a video
  Future<TabTemplate?> getTabForVideo(Video video) async {
    try {
      print('🎸 Fetching tab for video: ${video.id}');
      
      // Query for tab with matching video_id
      final querySnapshot = await _tabsCollection
          .where('video_id', isEqualTo: video.id)
          .limit(1)
          .get();
      
      if (querySnapshot.docs.isNotEmpty) {
        print('✅ Found existing tab');
        final doc = querySnapshot.docs.first;
        final data = doc.data() as Map<String, dynamic>;
        
        print('📄 Raw tab data: $data'); // Debug print of entire data
        print('📄 Content structure: ${data['content']}'); // Debug content structure
        print('📄 Sections structure: ${data['content']['sections']}'); // Debug sections
        
        return TabTemplate(
          tabVersion: TabVersion(
            version: '1.0',
            revision: data['revision'] as int? ?? 1,
          ),
          songInfo: SongInfo(
            title: data['title'] as String? ?? video.title,
            artist: data['artist'] as String? ?? video.artist ?? 'Unknown Artist',
            tuning: (data['tuning'] as Map<String, dynamic>?)?.values.toList().cast<String>() ?? ['E', 'A', 'D', 'G', 'B', 'E'],
            difficulty: data['content']['difficulty'] as String? ?? 'intermediate',
          ),
          meta: TabMeta(
            tempo: data['content']['tempo'] as int? ?? 120,
            timeSignature: data['content']['timeSignature'] as String? ?? '4/4',
            key: data['content']['key'] as String? ?? 'C',
          ),
          content: TabContent(
            measures: _extractMeasures(data['content']),
          ),
        );
      }
      
      print('❌ No tab found for video: ${video.id}');
      return null;
      
    } catch (e, stackTrace) {
      print('❌ Error getting tab:');
      print('Error: $e');
      print('Stack trace: $stackTrace');
      rethrow;
    }
  }

  /// Helper method to extract measures from the nested array structure
  List<Measure> _extractMeasures(Map<String, dynamic> content) {
    try {
      print('📝 Extracting measures from content');
      print('📝 Content structure: $content');
      print('📝 Sections type: ${content['sections'].runtimeType}');
      
      final sections = content['sections'] as List<dynamic>;
      print('📝 First section: ${sections[0]}');
      
      final firstSection = sections[0] as Map<String, dynamic>;
      print('📝 Measures in first section: ${firstSection['measures']}');
      
      final measuresMap = firstSection['measures'] as Map<String, dynamic>;
      print('📝 Processing measures: $measuresMap');
      
      // Convert map to sorted list based on index
      final measuresList = measuresMap.entries.map((entry) {
        print('📝 Processing measure ${entry.key}: ${entry.value}');
        final measure = entry.value as Map<String, dynamic>;
        return Measure(
          index: measure['index'] as int? ?? 0,
          timeSignature: measure['timeSignature'] as String? ?? '4/4',
          strings: _extractStrings(measure['strings'] as Map<String, dynamic>),
        );
      }).toList()
        ..sort((a, b) => a.index.compareTo(b.index));
      
      return measuresList;
    } catch (e) {
      print('❌ Error extracting measures: $e');
      print('❌ Error location: ${StackTrace.current}');
      return [];
    }
  }

  /// Helper method to extract strings from the nested structure
  List<TabString> _extractStrings(Map<String, dynamic> strings) {
    try {
      print('📝 Extracting strings: $strings');
      return strings.entries.map((stringEntry) {
        final tabString = stringEntry.value as Map<String, dynamic>;
        final notes = tabString['notes'] as Map<String, dynamic>;
        
        return TabString(
          string: int.parse(stringEntry.key) + 1,
          notes: notes.entries.map((noteEntry) {
            final note = noteEntry.value as Map<String, dynamic>;
            return Note(
              fret: note['fret'] as int? ?? 0,
              duration: (note['duration'] as num?)?.toDouble() ?? 1.0,
              position: note['position'] as int? ?? 0,
              string: note['string'],
            );
          }).toList()
            ..sort((a, b) => a.position.compareTo(b.position)),
        );
      }).toList()
        ..sort((a, b) => a.string.compareTo(b.string));
    } catch (e) {
      print('❌ Error extracting strings: $e');
      print('Stack trace: ${StackTrace.current}');
      return [];
    }
  }
} 