// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VideoImpl _$$VideoImplFromJson(Map<String, dynamic> json) => _$VideoImpl(
      id: json['id'] as String,
      url: json['url'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      title: json['title'] as String,
      description: json['description'] as String,
      creatorId: json['creatorId'] as String,
      artist: json['artist'] as String?,
      viewCount: (json['viewCount'] as num?)?.toInt() ?? 0,
      likeCount: (json['likeCount'] as num?)?.toInt() ?? 0,
      playCount: (json['playCount'] as num?)?.toInt() ?? 0,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      savedByUsers: (json['savedByUsers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      likedByUsers: (json['likedByUsers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      tutorials: (json['tutorials'] as List<dynamic>?)
              ?.map((e) => Tutorial.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$VideoImplToJson(_$VideoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'thumbnailUrl': instance.thumbnailUrl,
      'title': instance.title,
      'description': instance.description,
      'creatorId': instance.creatorId,
      'artist': instance.artist,
      'viewCount': instance.viewCount,
      'likeCount': instance.likeCount,
      'playCount': instance.playCount,
      'tags': instance.tags,
      'savedByUsers': instance.savedByUsers,
      'likedByUsers': instance.likedByUsers,
      'tutorials': instance.tutorials,
      'createdAt': instance.createdAt.toIso8601String(),
    };
