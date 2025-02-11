// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Video _$VideoFromJson(Map<String, dynamic> json) {
  return _Video.fromJson(json);
}

/// @nodoc
mixin _$Video {
  String get id => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String? get thumbnailUrl => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get creatorId => throw _privateConstructorUsedError;
  String? get artist => throw _privateConstructorUsedError;
  int get viewCount => throw _privateConstructorUsedError;
  int get likeCount => throw _privateConstructorUsedError;
  int get playCount => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  List<String> get savedByUsers => throw _privateConstructorUsedError;
  List<String> get likedByUsers => throw _privateConstructorUsedError;
  List<Tutorial> get tutorials => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Video to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Video
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VideoCopyWith<Video> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoCopyWith<$Res> {
  factory $VideoCopyWith(Video value, $Res Function(Video) then) =
      _$VideoCopyWithImpl<$Res, Video>;
  @useResult
  $Res call(
      {String id,
      String url,
      String? thumbnailUrl,
      String title,
      String description,
      String creatorId,
      String? artist,
      int viewCount,
      int likeCount,
      int playCount,
      List<String> tags,
      List<String> savedByUsers,
      List<String> likedByUsers,
      List<Tutorial> tutorials,
      DateTime createdAt});
}

/// @nodoc
class _$VideoCopyWithImpl<$Res, $Val extends Video>
    implements $VideoCopyWith<$Res> {
  _$VideoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Video
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? url = null,
    Object? thumbnailUrl = freezed,
    Object? title = null,
    Object? description = null,
    Object? creatorId = null,
    Object? artist = freezed,
    Object? viewCount = null,
    Object? likeCount = null,
    Object? playCount = null,
    Object? tags = null,
    Object? savedByUsers = null,
    Object? likedByUsers = null,
    Object? tutorials = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnailUrl: freezed == thumbnailUrl
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      creatorId: null == creatorId
          ? _value.creatorId
          : creatorId // ignore: cast_nullable_to_non_nullable
              as String,
      artist: freezed == artist
          ? _value.artist
          : artist // ignore: cast_nullable_to_non_nullable
              as String?,
      viewCount: null == viewCount
          ? _value.viewCount
          : viewCount // ignore: cast_nullable_to_non_nullable
              as int,
      likeCount: null == likeCount
          ? _value.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int,
      playCount: null == playCount
          ? _value.playCount
          : playCount // ignore: cast_nullable_to_non_nullable
              as int,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      savedByUsers: null == savedByUsers
          ? _value.savedByUsers
          : savedByUsers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      likedByUsers: null == likedByUsers
          ? _value.likedByUsers
          : likedByUsers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      tutorials: null == tutorials
          ? _value.tutorials
          : tutorials // ignore: cast_nullable_to_non_nullable
              as List<Tutorial>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VideoImplCopyWith<$Res> implements $VideoCopyWith<$Res> {
  factory _$$VideoImplCopyWith(
          _$VideoImpl value, $Res Function(_$VideoImpl) then) =
      __$$VideoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String url,
      String? thumbnailUrl,
      String title,
      String description,
      String creatorId,
      String? artist,
      int viewCount,
      int likeCount,
      int playCount,
      List<String> tags,
      List<String> savedByUsers,
      List<String> likedByUsers,
      List<Tutorial> tutorials,
      DateTime createdAt});
}

/// @nodoc
class __$$VideoImplCopyWithImpl<$Res>
    extends _$VideoCopyWithImpl<$Res, _$VideoImpl>
    implements _$$VideoImplCopyWith<$Res> {
  __$$VideoImplCopyWithImpl(
      _$VideoImpl _value, $Res Function(_$VideoImpl) _then)
      : super(_value, _then);

  /// Create a copy of Video
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? url = null,
    Object? thumbnailUrl = freezed,
    Object? title = null,
    Object? description = null,
    Object? creatorId = null,
    Object? artist = freezed,
    Object? viewCount = null,
    Object? likeCount = null,
    Object? playCount = null,
    Object? tags = null,
    Object? savedByUsers = null,
    Object? likedByUsers = null,
    Object? tutorials = null,
    Object? createdAt = null,
  }) {
    return _then(_$VideoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnailUrl: freezed == thumbnailUrl
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      creatorId: null == creatorId
          ? _value.creatorId
          : creatorId // ignore: cast_nullable_to_non_nullable
              as String,
      artist: freezed == artist
          ? _value.artist
          : artist // ignore: cast_nullable_to_non_nullable
              as String?,
      viewCount: null == viewCount
          ? _value.viewCount
          : viewCount // ignore: cast_nullable_to_non_nullable
              as int,
      likeCount: null == likeCount
          ? _value.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int,
      playCount: null == playCount
          ? _value.playCount
          : playCount // ignore: cast_nullable_to_non_nullable
              as int,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      savedByUsers: null == savedByUsers
          ? _value._savedByUsers
          : savedByUsers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      likedByUsers: null == likedByUsers
          ? _value._likedByUsers
          : likedByUsers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      tutorials: null == tutorials
          ? _value._tutorials
          : tutorials // ignore: cast_nullable_to_non_nullable
              as List<Tutorial>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VideoImpl implements _Video {
  const _$VideoImpl(
      {required this.id,
      required this.url,
      this.thumbnailUrl,
      required this.title,
      required this.description,
      required this.creatorId,
      this.artist,
      this.viewCount = 0,
      this.likeCount = 0,
      this.playCount = 0,
      final List<String> tags = const [],
      final List<String> savedByUsers = const [],
      final List<String> likedByUsers = const [],
      final List<Tutorial> tutorials = const [],
      required this.createdAt})
      : _tags = tags,
        _savedByUsers = savedByUsers,
        _likedByUsers = likedByUsers,
        _tutorials = tutorials;

  factory _$VideoImpl.fromJson(Map<String, dynamic> json) =>
      _$$VideoImplFromJson(json);

  @override
  final String id;
  @override
  final String url;
  @override
  final String? thumbnailUrl;
  @override
  final String title;
  @override
  final String description;
  @override
  final String creatorId;
  @override
  final String? artist;
  @override
  @JsonKey()
  final int viewCount;
  @override
  @JsonKey()
  final int likeCount;
  @override
  @JsonKey()
  final int playCount;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  final List<String> _savedByUsers;
  @override
  @JsonKey()
  List<String> get savedByUsers {
    if (_savedByUsers is EqualUnmodifiableListView) return _savedByUsers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_savedByUsers);
  }

  final List<String> _likedByUsers;
  @override
  @JsonKey()
  List<String> get likedByUsers {
    if (_likedByUsers is EqualUnmodifiableListView) return _likedByUsers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_likedByUsers);
  }

  final List<Tutorial> _tutorials;
  @override
  @JsonKey()
  List<Tutorial> get tutorials {
    if (_tutorials is EqualUnmodifiableListView) return _tutorials;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tutorials);
  }

  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'Video(id: $id, url: $url, thumbnailUrl: $thumbnailUrl, title: $title, description: $description, creatorId: $creatorId, artist: $artist, viewCount: $viewCount, likeCount: $likeCount, playCount: $playCount, tags: $tags, savedByUsers: $savedByUsers, likedByUsers: $likedByUsers, tutorials: $tutorials, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VideoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.creatorId, creatorId) ||
                other.creatorId == creatorId) &&
            (identical(other.artist, artist) || other.artist == artist) &&
            (identical(other.viewCount, viewCount) ||
                other.viewCount == viewCount) &&
            (identical(other.likeCount, likeCount) ||
                other.likeCount == likeCount) &&
            (identical(other.playCount, playCount) ||
                other.playCount == playCount) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            const DeepCollectionEquality()
                .equals(other._savedByUsers, _savedByUsers) &&
            const DeepCollectionEquality()
                .equals(other._likedByUsers, _likedByUsers) &&
            const DeepCollectionEquality()
                .equals(other._tutorials, _tutorials) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      url,
      thumbnailUrl,
      title,
      description,
      creatorId,
      artist,
      viewCount,
      likeCount,
      playCount,
      const DeepCollectionEquality().hash(_tags),
      const DeepCollectionEquality().hash(_savedByUsers),
      const DeepCollectionEquality().hash(_likedByUsers),
      const DeepCollectionEquality().hash(_tutorials),
      createdAt);

  /// Create a copy of Video
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VideoImplCopyWith<_$VideoImpl> get copyWith =>
      __$$VideoImplCopyWithImpl<_$VideoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VideoImplToJson(
      this,
    );
  }
}

abstract class _Video implements Video {
  const factory _Video(
      {required final String id,
      required final String url,
      final String? thumbnailUrl,
      required final String title,
      required final String description,
      required final String creatorId,
      final String? artist,
      final int viewCount,
      final int likeCount,
      final int playCount,
      final List<String> tags,
      final List<String> savedByUsers,
      final List<String> likedByUsers,
      final List<Tutorial> tutorials,
      required final DateTime createdAt}) = _$VideoImpl;

  factory _Video.fromJson(Map<String, dynamic> json) = _$VideoImpl.fromJson;

  @override
  String get id;
  @override
  String get url;
  @override
  String? get thumbnailUrl;
  @override
  String get title;
  @override
  String get description;
  @override
  String get creatorId;
  @override
  String? get artist;
  @override
  int get viewCount;
  @override
  int get likeCount;
  @override
  int get playCount;
  @override
  List<String> get tags;
  @override
  List<String> get savedByUsers;
  @override
  List<String> get likedByUsers;
  @override
  List<Tutorial> get tutorials;
  @override
  DateTime get createdAt;

  /// Create a copy of Video
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VideoImplCopyWith<_$VideoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
