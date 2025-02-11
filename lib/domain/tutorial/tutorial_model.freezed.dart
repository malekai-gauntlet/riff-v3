// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tutorial_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GuitarNote _$GuitarNoteFromJson(Map<String, dynamic> json) {
  return _GuitarNote.fromJson(json);
}

/// @nodoc
mixin _$GuitarNote {
  String get url => throw _privateConstructorUsedError;
  String? get rating => throw _privateConstructorUsedError;
  String? get difficulty => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;

  /// Serializes this GuitarNote to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GuitarNote
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GuitarNoteCopyWith<GuitarNote> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GuitarNoteCopyWith<$Res> {
  factory $GuitarNoteCopyWith(
          GuitarNote value, $Res Function(GuitarNote) then) =
      _$GuitarNoteCopyWithImpl<$Res, GuitarNote>;
  @useResult
  $Res call(
      {String url,
      String? rating,
      String? difficulty,
      String type,
      String? title});
}

/// @nodoc
class _$GuitarNoteCopyWithImpl<$Res, $Val extends GuitarNote>
    implements $GuitarNoteCopyWith<$Res> {
  _$GuitarNoteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GuitarNote
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? rating = freezed,
    Object? difficulty = freezed,
    Object? type = null,
    Object? title = freezed,
  }) {
    return _then(_value.copyWith(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as String?,
      difficulty: freezed == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GuitarNoteImplCopyWith<$Res>
    implements $GuitarNoteCopyWith<$Res> {
  factory _$$GuitarNoteImplCopyWith(
          _$GuitarNoteImpl value, $Res Function(_$GuitarNoteImpl) then) =
      __$$GuitarNoteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String url,
      String? rating,
      String? difficulty,
      String type,
      String? title});
}

/// @nodoc
class __$$GuitarNoteImplCopyWithImpl<$Res>
    extends _$GuitarNoteCopyWithImpl<$Res, _$GuitarNoteImpl>
    implements _$$GuitarNoteImplCopyWith<$Res> {
  __$$GuitarNoteImplCopyWithImpl(
      _$GuitarNoteImpl _value, $Res Function(_$GuitarNoteImpl) _then)
      : super(_value, _then);

  /// Create a copy of GuitarNote
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? rating = freezed,
    Object? difficulty = freezed,
    Object? type = null,
    Object? title = freezed,
  }) {
    return _then(_$GuitarNoteImpl(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as String?,
      difficulty: freezed == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GuitarNoteImpl implements _GuitarNote {
  const _$GuitarNoteImpl(
      {required this.url,
      this.rating,
      this.difficulty,
      required this.type,
      this.title});

  factory _$GuitarNoteImpl.fromJson(Map<String, dynamic> json) =>
      _$$GuitarNoteImplFromJson(json);

  @override
  final String url;
  @override
  final String? rating;
  @override
  final String? difficulty;
  @override
  final String type;
  @override
  final String? title;

  @override
  String toString() {
    return 'GuitarNote(url: $url, rating: $rating, difficulty: $difficulty, type: $type, title: $title)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GuitarNoteImpl &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, url, rating, difficulty, type, title);

  /// Create a copy of GuitarNote
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GuitarNoteImplCopyWith<_$GuitarNoteImpl> get copyWith =>
      __$$GuitarNoteImplCopyWithImpl<_$GuitarNoteImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GuitarNoteImplToJson(
      this,
    );
  }
}

abstract class _GuitarNote implements GuitarNote {
  const factory _GuitarNote(
      {required final String url,
      final String? rating,
      final String? difficulty,
      required final String type,
      final String? title}) = _$GuitarNoteImpl;

  factory _GuitarNote.fromJson(Map<String, dynamic> json) =
      _$GuitarNoteImpl.fromJson;

  @override
  String get url;
  @override
  String? get rating;
  @override
  String? get difficulty;
  @override
  String get type;
  @override
  String? get title;

  /// Create a copy of GuitarNote
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GuitarNoteImplCopyWith<_$GuitarNoteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Tutorial _$TutorialFromJson(Map<String, dynamic> json) {
  return _Tutorial.fromJson(json);
}

/// @nodoc
mixin _$Tutorial {
  String get youtubeId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get channelName => throw _privateConstructorUsedError;
  String get viewCount => throw _privateConstructorUsedError;
  String get duration => throw _privateConstructorUsedError;
  String get thumbnailUrl => throw _privateConstructorUsedError;
  bool get isBestMatch => throw _privateConstructorUsedError;
  @JsonKey(name: 'tabs')
  List<GuitarNote> get guitarNotes => throw _privateConstructorUsedError;

  /// Serializes this Tutorial to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Tutorial
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TutorialCopyWith<Tutorial> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TutorialCopyWith<$Res> {
  factory $TutorialCopyWith(Tutorial value, $Res Function(Tutorial) then) =
      _$TutorialCopyWithImpl<$Res, Tutorial>;
  @useResult
  $Res call(
      {String youtubeId,
      String title,
      String channelName,
      String viewCount,
      String duration,
      String thumbnailUrl,
      bool isBestMatch,
      @JsonKey(name: 'tabs') List<GuitarNote> guitarNotes});
}

/// @nodoc
class _$TutorialCopyWithImpl<$Res, $Val extends Tutorial>
    implements $TutorialCopyWith<$Res> {
  _$TutorialCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Tutorial
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? youtubeId = null,
    Object? title = null,
    Object? channelName = null,
    Object? viewCount = null,
    Object? duration = null,
    Object? thumbnailUrl = null,
    Object? isBestMatch = null,
    Object? guitarNotes = null,
  }) {
    return _then(_value.copyWith(
      youtubeId: null == youtubeId
          ? _value.youtubeId
          : youtubeId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      channelName: null == channelName
          ? _value.channelName
          : channelName // ignore: cast_nullable_to_non_nullable
              as String,
      viewCount: null == viewCount
          ? _value.viewCount
          : viewCount // ignore: cast_nullable_to_non_nullable
              as String,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnailUrl: null == thumbnailUrl
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String,
      isBestMatch: null == isBestMatch
          ? _value.isBestMatch
          : isBestMatch // ignore: cast_nullable_to_non_nullable
              as bool,
      guitarNotes: null == guitarNotes
          ? _value.guitarNotes
          : guitarNotes // ignore: cast_nullable_to_non_nullable
              as List<GuitarNote>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TutorialImplCopyWith<$Res>
    implements $TutorialCopyWith<$Res> {
  factory _$$TutorialImplCopyWith(
          _$TutorialImpl value, $Res Function(_$TutorialImpl) then) =
      __$$TutorialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String youtubeId,
      String title,
      String channelName,
      String viewCount,
      String duration,
      String thumbnailUrl,
      bool isBestMatch,
      @JsonKey(name: 'tabs') List<GuitarNote> guitarNotes});
}

/// @nodoc
class __$$TutorialImplCopyWithImpl<$Res>
    extends _$TutorialCopyWithImpl<$Res, _$TutorialImpl>
    implements _$$TutorialImplCopyWith<$Res> {
  __$$TutorialImplCopyWithImpl(
      _$TutorialImpl _value, $Res Function(_$TutorialImpl) _then)
      : super(_value, _then);

  /// Create a copy of Tutorial
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? youtubeId = null,
    Object? title = null,
    Object? channelName = null,
    Object? viewCount = null,
    Object? duration = null,
    Object? thumbnailUrl = null,
    Object? isBestMatch = null,
    Object? guitarNotes = null,
  }) {
    return _then(_$TutorialImpl(
      youtubeId: null == youtubeId
          ? _value.youtubeId
          : youtubeId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      channelName: null == channelName
          ? _value.channelName
          : channelName // ignore: cast_nullable_to_non_nullable
              as String,
      viewCount: null == viewCount
          ? _value.viewCount
          : viewCount // ignore: cast_nullable_to_non_nullable
              as String,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnailUrl: null == thumbnailUrl
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String,
      isBestMatch: null == isBestMatch
          ? _value.isBestMatch
          : isBestMatch // ignore: cast_nullable_to_non_nullable
              as bool,
      guitarNotes: null == guitarNotes
          ? _value._guitarNotes
          : guitarNotes // ignore: cast_nullable_to_non_nullable
              as List<GuitarNote>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TutorialImpl implements _Tutorial {
  const _$TutorialImpl(
      {required this.youtubeId,
      required this.title,
      required this.channelName,
      required this.viewCount,
      required this.duration,
      required this.thumbnailUrl,
      this.isBestMatch = false,
      @JsonKey(name: 'tabs') final List<GuitarNote> guitarNotes = const []})
      : _guitarNotes = guitarNotes;

  factory _$TutorialImpl.fromJson(Map<String, dynamic> json) =>
      _$$TutorialImplFromJson(json);

  @override
  final String youtubeId;
  @override
  final String title;
  @override
  final String channelName;
  @override
  final String viewCount;
  @override
  final String duration;
  @override
  final String thumbnailUrl;
  @override
  @JsonKey()
  final bool isBestMatch;
  final List<GuitarNote> _guitarNotes;
  @override
  @JsonKey(name: 'tabs')
  List<GuitarNote> get guitarNotes {
    if (_guitarNotes is EqualUnmodifiableListView) return _guitarNotes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_guitarNotes);
  }

  @override
  String toString() {
    return 'Tutorial(youtubeId: $youtubeId, title: $title, channelName: $channelName, viewCount: $viewCount, duration: $duration, thumbnailUrl: $thumbnailUrl, isBestMatch: $isBestMatch, guitarNotes: $guitarNotes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TutorialImpl &&
            (identical(other.youtubeId, youtubeId) ||
                other.youtubeId == youtubeId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.channelName, channelName) ||
                other.channelName == channelName) &&
            (identical(other.viewCount, viewCount) ||
                other.viewCount == viewCount) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl) &&
            (identical(other.isBestMatch, isBestMatch) ||
                other.isBestMatch == isBestMatch) &&
            const DeepCollectionEquality()
                .equals(other._guitarNotes, _guitarNotes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      youtubeId,
      title,
      channelName,
      viewCount,
      duration,
      thumbnailUrl,
      isBestMatch,
      const DeepCollectionEquality().hash(_guitarNotes));

  /// Create a copy of Tutorial
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TutorialImplCopyWith<_$TutorialImpl> get copyWith =>
      __$$TutorialImplCopyWithImpl<_$TutorialImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TutorialImplToJson(
      this,
    );
  }
}

abstract class _Tutorial implements Tutorial {
  const factory _Tutorial(
          {required final String youtubeId,
          required final String title,
          required final String channelName,
          required final String viewCount,
          required final String duration,
          required final String thumbnailUrl,
          final bool isBestMatch,
          @JsonKey(name: 'tabs') final List<GuitarNote> guitarNotes}) =
      _$TutorialImpl;

  factory _Tutorial.fromJson(Map<String, dynamic> json) =
      _$TutorialImpl.fromJson;

  @override
  String get youtubeId;
  @override
  String get title;
  @override
  String get channelName;
  @override
  String get viewCount;
  @override
  String get duration;
  @override
  String get thumbnailUrl;
  @override
  bool get isBestMatch;
  @override
  @JsonKey(name: 'tabs')
  List<GuitarNote> get guitarNotes;

  /// Create a copy of Tutorial
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TutorialImplCopyWith<_$TutorialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
