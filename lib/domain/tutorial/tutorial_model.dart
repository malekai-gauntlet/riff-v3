import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'tutorial_model.freezed.dart';
part 'tutorial_model.g.dart';

// Model for guitar tabs from Ultimate Guitar
@freezed
class GuitarNote with _$GuitarNote {
  const factory GuitarNote({
    required String url,
    String? rating,
    String? difficulty,
    required String type,
    String? title,
  }) = _GuitarNote;

  factory GuitarNote.fromJson(Map<String, dynamic> json) => _$GuitarNoteFromJson(json);

  factory GuitarNote.fromFirestore(Map<String, dynamic> data) {
    return GuitarNote.fromJson({
      'url': data['url'] ?? '',
      'rating': data['rating'],
      'difficulty': data['difficulty'],
      'type': data['type'] ?? 'chords',
      'title': data['title'],
    });
  }
}

@freezed
class Tutorial with _$Tutorial {
  const factory Tutorial({
    required String youtubeId,
    required String title,
    required String channelName,
    required String viewCount,
    required String duration,
    required String thumbnailUrl,
    @Default(false) bool isBestMatch,
    @JsonKey(name: 'tabs') @Default([]) List<GuitarNote> guitarNotes,
  }) = _Tutorial;

  factory Tutorial.fromJson(Map<String, dynamic> json) => _$TutorialFromJson(json);

  factory Tutorial.fromFirestore(Map<String, dynamic> data) {
    // Handle tabs data from Firebase
    List<GuitarNote> guitarNotesData = [];
    if (data.containsKey('tabs') && data['tabs'] != null) {
      try {
        guitarNotesData = (data['tabs'] as List<dynamic>).map((noteData) {
          if (noteData is Map<String, dynamic>) {
            return GuitarNote.fromFirestore(noteData);
          }
          return noteData as GuitarNote;
        }).toList();
      } catch (e) {
        print('Error parsing guitar notes: $e');
        guitarNotesData = [];
      }
    }

    final tutorialJson = {
      'youtubeId': data['youtubeId'] ?? '',
      'title': data['title'] ?? '',
      'channelName': data['channelName'] ?? '',
      'viewCount': data['viewCount'] ?? '0',
      'duration': data['duration'] ?? '0:00',
      'thumbnailUrl': data['thumbnailUrl'] ?? '',
      'isBestMatch': data['isBestMatch'] ?? false,
      'tabs': guitarNotesData.map((guitarNote) => guitarNote.toJson()).toList(),
    };

    return Tutorial.fromJson(tutorialJson);
  }
} 