// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tutorial_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GuitarNoteImpl _$$GuitarNoteImplFromJson(Map<String, dynamic> json) =>
    _$GuitarNoteImpl(
      url: json['url'] as String,
      rating: json['rating'] as String?,
      difficulty: json['difficulty'] as String?,
      type: json['type'] as String,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$$GuitarNoteImplToJson(_$GuitarNoteImpl instance) =>
    <String, dynamic>{
      'url': instance.url,
      'rating': instance.rating,
      'difficulty': instance.difficulty,
      'type': instance.type,
      'title': instance.title,
    };

_$TutorialImpl _$$TutorialImplFromJson(Map<String, dynamic> json) =>
    _$TutorialImpl(
      youtubeId: json['youtubeId'] as String,
      title: json['title'] as String,
      channelName: json['channelName'] as String,
      viewCount: json['viewCount'] as String,
      duration: json['duration'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
      isBestMatch: json['isBestMatch'] as bool? ?? false,
      guitarNotes: (json['tabs'] as List<dynamic>?)
              ?.map((e) => GuitarNote.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$TutorialImplToJson(_$TutorialImpl instance) =>
    <String, dynamic>{
      'youtubeId': instance.youtubeId,
      'title': instance.title,
      'channelName': instance.channelName,
      'viewCount': instance.viewCount,
      'duration': instance.duration,
      'thumbnailUrl': instance.thumbnailUrl,
      'isBestMatch': instance.isBestMatch,
      'tabs': instance.guitarNotes,
    };
