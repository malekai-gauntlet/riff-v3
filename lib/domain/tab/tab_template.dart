import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'tab_template.freezed.dart';
part 'tab_template.g.dart';

/// Represents a guitar tab in Ultimate Guitar compatible format
@freezed
class TabTemplate with _$TabTemplate {
  const factory TabTemplate({
    required TabVersion tabVersion,
    required SongInfo songInfo,
    required TabMeta meta,
    required TabContent content,
  }) = _TabTemplate;

  factory TabTemplate.fromJson(Map<String, dynamic> json) =>
      _$TabTemplateFromJson(json);
}

/// Version information for the tab
@freezed
class TabVersion with _$TabVersion {
  const factory TabVersion({
    @Default('1.0') String version,
    @Default(1) int revision,
  }) = _TabVersion;

  factory TabVersion.fromJson(Map<String, dynamic> json) =>
      _$TabVersionFromJson(json);
}

/// Song metadata information
@freezed
class SongInfo with _$SongInfo {
  const factory SongInfo({
    required String title,
    required String artist,
    @Default(['E', 'A', 'D', 'G', 'B', 'E']) List<String> tuning,
    @Default(0) int capo,
    @Default('beginner') String difficulty,
  }) = _SongInfo;

  factory SongInfo.fromJson(Map<String, dynamic> json) =>
      _$SongInfoFromJson(json);
}

/// Musical metadata for the tab
@freezed
class TabMeta with _$TabMeta {
  const factory TabMeta({
    @Default(120) int tempo,
    @Default('4/4') String timeSignature,
    @Default('C') String key,
  }) = _TabMeta;

  factory TabMeta.fromJson(Map<String, dynamic> json) =>
      _$TabMetaFromJson(json);
}

/// Main content container for the tab
@freezed
class TabContent with _$TabContent {
  const factory TabContent({
    required List<Measure> measures,
  }) = _TabContent;

  factory TabContent.fromJson(Map<String, dynamic> json) =>
      _$TabContentFromJson(json);
}

/// Represents a single measure in the tab
@freezed
class Measure with _$Measure {
  const factory Measure({
    required int index,
    @Default('4/4') String timeSignature,
    required List<TabString> strings,
  }) = _Measure;

  factory Measure.fromJson(Map<String, dynamic> json) =>
      _$MeasureFromJson(json);
}

/// Represents a single guitar string in a measure
@freezed
class TabString with _$TabString {
  const factory TabString({
    required int string,
    required List<Note> notes,
  }) = _TabString;

  factory TabString.fromJson(Map<String, dynamic> json) =>
      _$TabStringFromJson(json);
}

/// Represents a single note in the tab
@freezed
class Note with _$Note {
  const factory Note({
    required int fret,
    required double duration,
    required int position,
    String? technique,
  }) = _Note;

  factory Note.fromJson(Map<String, dynamic> json) =>
      _$NoteFromJson(json);
}

/// Example usage and helper methods
class TabTemplateHelper {
  /// Creates a basic template for a single-note melody
  static TabTemplate createBasicTemplate({
    required String title,
    required String artist,
  }) {
    return TabTemplate(
      tabVersion: const TabVersion(),
      songInfo: SongInfo(
        title: title,
        artist: artist,
      ),
      meta: const TabMeta(),
      content: TabContent(
        measures: [
          Measure(
            index: 0,
            strings: [
              TabString(
                string: 1,
                notes: [
                  const Note(
                    fret: 0,
                    duration: 1,
                    position: 0,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Adds a note to the template
  static TabTemplate addNote({
    required TabTemplate template,
    required int measureIndex,
    required int string,
    required int fret,
    required double duration,
    required int position,
    String? technique,
  }) {
    // Find or create measure
    final measures = List<Measure>.from(template.content.measures);
    while (measures.length <= measureIndex) {
      measures.add(
        Measure(
          index: measures.length,
          strings: [],
        ),
      );
    }

    // Find or create string
    final measure = measures[measureIndex];
    final strings = List<TabString>.from(measure.strings);
    final stringIndex = strings.indexWhere((s) => s.string == string);
    
    if (stringIndex == -1) {
      strings.add(
        TabString(
          string: string,
          notes: [
            Note(
              fret: fret,
              duration: duration,
              position: position,
              technique: technique,
            ),
          ],
        ),
      );
    } else {
      final tabString = strings[stringIndex];
      final notes = List<Note>.from(tabString.notes)
        ..add(
          Note(
            fret: fret,
            duration: duration,
            position: position,
            technique: technique,
          ),
        );
      strings[stringIndex] = tabString.copyWith(notes: notes);
    }

    measures[measureIndex] = measure.copyWith(strings: strings);

    return template.copyWith(
      content: template.content.copyWith(measures: measures),
    );
  }
} 