// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tab_template.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TabTemplateImpl _$$TabTemplateImplFromJson(Map<String, dynamic> json) =>
    _$TabTemplateImpl(
      tabVersion:
          TabVersion.fromJson(json['tabVersion'] as Map<String, dynamic>),
      songInfo: SongInfo.fromJson(json['songInfo'] as Map<String, dynamic>),
      meta: TabMeta.fromJson(json['meta'] as Map<String, dynamic>),
      content: TabContent.fromJson(json['content'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$TabTemplateImplToJson(_$TabTemplateImpl instance) =>
    <String, dynamic>{
      'tabVersion': instance.tabVersion,
      'songInfo': instance.songInfo,
      'meta': instance.meta,
      'content': instance.content,
    };

_$TabVersionImpl _$$TabVersionImplFromJson(Map<String, dynamic> json) =>
    _$TabVersionImpl(
      version: json['version'] as String? ?? '1.0',
      revision: (json['revision'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$$TabVersionImplToJson(_$TabVersionImpl instance) =>
    <String, dynamic>{
      'version': instance.version,
      'revision': instance.revision,
    };

_$SongInfoImpl _$$SongInfoImplFromJson(Map<String, dynamic> json) =>
    _$SongInfoImpl(
      title: json['title'] as String,
      artist: json['artist'] as String,
      tuning: (json['tuning'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const ['E', 'A', 'D', 'G', 'B', 'E'],
      capo: (json['capo'] as num?)?.toInt() ?? 0,
      difficulty: json['difficulty'] as String? ?? 'beginner',
    );

Map<String, dynamic> _$$SongInfoImplToJson(_$SongInfoImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'artist': instance.artist,
      'tuning': instance.tuning,
      'capo': instance.capo,
      'difficulty': instance.difficulty,
    };

_$TabMetaImpl _$$TabMetaImplFromJson(Map<String, dynamic> json) =>
    _$TabMetaImpl(
      tempo: (json['tempo'] as num?)?.toInt() ?? 120,
      timeSignature: json['timeSignature'] as String? ?? '4/4',
      key: json['key'] as String? ?? 'C',
    );

Map<String, dynamic> _$$TabMetaImplToJson(_$TabMetaImpl instance) =>
    <String, dynamic>{
      'tempo': instance.tempo,
      'timeSignature': instance.timeSignature,
      'key': instance.key,
    };

_$TabContentImpl _$$TabContentImplFromJson(Map<String, dynamic> json) =>
    _$TabContentImpl(
      measures: (json['measures'] as List<dynamic>)
          .map((e) => Measure.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$TabContentImplToJson(_$TabContentImpl instance) =>
    <String, dynamic>{
      'measures': instance.measures,
    };

_$MeasureImpl _$$MeasureImplFromJson(Map<String, dynamic> json) =>
    _$MeasureImpl(
      index: (json['index'] as num).toInt(),
      timeSignature: json['timeSignature'] as String? ?? '4/4',
      strings: (json['strings'] as List<dynamic>)
          .map((e) => TabString.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$MeasureImplToJson(_$MeasureImpl instance) =>
    <String, dynamic>{
      'index': instance.index,
      'timeSignature': instance.timeSignature,
      'strings': instance.strings,
    };

_$TabStringImpl _$$TabStringImplFromJson(Map<String, dynamic> json) =>
    _$TabStringImpl(
      string: (json['string'] as num).toInt(),
      notes: (json['notes'] as List<dynamic>)
          .map((e) => Note.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$TabStringImplToJson(_$TabStringImpl instance) =>
    <String, dynamic>{
      'string': instance.string,
      'notes': instance.notes,
    };

_$NoteImpl _$$NoteImplFromJson(Map<String, dynamic> json) => _$NoteImpl(
      fret: (json['fret'] as num).toInt(),
      duration: (json['duration'] as num).toDouble(),
      position: (json['position'] as num).toInt(),
      technique: json['technique'] as String?,
    );

Map<String, dynamic> _$$NoteImplToJson(_$NoteImpl instance) =>
    <String, dynamic>{
      'fret': instance.fret,
      'duration': instance.duration,
      'position': instance.position,
      'technique': instance.technique,
    };
