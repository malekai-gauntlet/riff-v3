// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tab_template.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TabTemplate _$TabTemplateFromJson(Map<String, dynamic> json) {
  return _TabTemplate.fromJson(json);
}

/// @nodoc
mixin _$TabTemplate {
  TabVersion get tabVersion => throw _privateConstructorUsedError;
  SongInfo get songInfo => throw _privateConstructorUsedError;
  TabMeta get meta => throw _privateConstructorUsedError;
  TabContent get content => throw _privateConstructorUsedError;

  /// Serializes this TabTemplate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TabTemplate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TabTemplateCopyWith<TabTemplate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TabTemplateCopyWith<$Res> {
  factory $TabTemplateCopyWith(
          TabTemplate value, $Res Function(TabTemplate) then) =
      _$TabTemplateCopyWithImpl<$Res, TabTemplate>;
  @useResult
  $Res call(
      {TabVersion tabVersion,
      SongInfo songInfo,
      TabMeta meta,
      TabContent content});

  $TabVersionCopyWith<$Res> get tabVersion;
  $SongInfoCopyWith<$Res> get songInfo;
  $TabMetaCopyWith<$Res> get meta;
  $TabContentCopyWith<$Res> get content;
}

/// @nodoc
class _$TabTemplateCopyWithImpl<$Res, $Val extends TabTemplate>
    implements $TabTemplateCopyWith<$Res> {
  _$TabTemplateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TabTemplate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tabVersion = null,
    Object? songInfo = null,
    Object? meta = null,
    Object? content = null,
  }) {
    return _then(_value.copyWith(
      tabVersion: null == tabVersion
          ? _value.tabVersion
          : tabVersion // ignore: cast_nullable_to_non_nullable
              as TabVersion,
      songInfo: null == songInfo
          ? _value.songInfo
          : songInfo // ignore: cast_nullable_to_non_nullable
              as SongInfo,
      meta: null == meta
          ? _value.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as TabMeta,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as TabContent,
    ) as $Val);
  }

  /// Create a copy of TabTemplate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TabVersionCopyWith<$Res> get tabVersion {
    return $TabVersionCopyWith<$Res>(_value.tabVersion, (value) {
      return _then(_value.copyWith(tabVersion: value) as $Val);
    });
  }

  /// Create a copy of TabTemplate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SongInfoCopyWith<$Res> get songInfo {
    return $SongInfoCopyWith<$Res>(_value.songInfo, (value) {
      return _then(_value.copyWith(songInfo: value) as $Val);
    });
  }

  /// Create a copy of TabTemplate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TabMetaCopyWith<$Res> get meta {
    return $TabMetaCopyWith<$Res>(_value.meta, (value) {
      return _then(_value.copyWith(meta: value) as $Val);
    });
  }

  /// Create a copy of TabTemplate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TabContentCopyWith<$Res> get content {
    return $TabContentCopyWith<$Res>(_value.content, (value) {
      return _then(_value.copyWith(content: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TabTemplateImplCopyWith<$Res>
    implements $TabTemplateCopyWith<$Res> {
  factory _$$TabTemplateImplCopyWith(
          _$TabTemplateImpl value, $Res Function(_$TabTemplateImpl) then) =
      __$$TabTemplateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TabVersion tabVersion,
      SongInfo songInfo,
      TabMeta meta,
      TabContent content});

  @override
  $TabVersionCopyWith<$Res> get tabVersion;
  @override
  $SongInfoCopyWith<$Res> get songInfo;
  @override
  $TabMetaCopyWith<$Res> get meta;
  @override
  $TabContentCopyWith<$Res> get content;
}

/// @nodoc
class __$$TabTemplateImplCopyWithImpl<$Res>
    extends _$TabTemplateCopyWithImpl<$Res, _$TabTemplateImpl>
    implements _$$TabTemplateImplCopyWith<$Res> {
  __$$TabTemplateImplCopyWithImpl(
      _$TabTemplateImpl _value, $Res Function(_$TabTemplateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TabTemplate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tabVersion = null,
    Object? songInfo = null,
    Object? meta = null,
    Object? content = null,
  }) {
    return _then(_$TabTemplateImpl(
      tabVersion: null == tabVersion
          ? _value.tabVersion
          : tabVersion // ignore: cast_nullable_to_non_nullable
              as TabVersion,
      songInfo: null == songInfo
          ? _value.songInfo
          : songInfo // ignore: cast_nullable_to_non_nullable
              as SongInfo,
      meta: null == meta
          ? _value.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as TabMeta,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as TabContent,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TabTemplateImpl with DiagnosticableTreeMixin implements _TabTemplate {
  const _$TabTemplateImpl(
      {required this.tabVersion,
      required this.songInfo,
      required this.meta,
      required this.content});

  factory _$TabTemplateImpl.fromJson(Map<String, dynamic> json) =>
      _$$TabTemplateImplFromJson(json);

  @override
  final TabVersion tabVersion;
  @override
  final SongInfo songInfo;
  @override
  final TabMeta meta;
  @override
  final TabContent content;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TabTemplate(tabVersion: $tabVersion, songInfo: $songInfo, meta: $meta, content: $content)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TabTemplate'))
      ..add(DiagnosticsProperty('tabVersion', tabVersion))
      ..add(DiagnosticsProperty('songInfo', songInfo))
      ..add(DiagnosticsProperty('meta', meta))
      ..add(DiagnosticsProperty('content', content));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TabTemplateImpl &&
            (identical(other.tabVersion, tabVersion) ||
                other.tabVersion == tabVersion) &&
            (identical(other.songInfo, songInfo) ||
                other.songInfo == songInfo) &&
            (identical(other.meta, meta) || other.meta == meta) &&
            (identical(other.content, content) || other.content == content));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, tabVersion, songInfo, meta, content);

  /// Create a copy of TabTemplate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TabTemplateImplCopyWith<_$TabTemplateImpl> get copyWith =>
      __$$TabTemplateImplCopyWithImpl<_$TabTemplateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TabTemplateImplToJson(
      this,
    );
  }
}

abstract class _TabTemplate implements TabTemplate {
  const factory _TabTemplate(
      {required final TabVersion tabVersion,
      required final SongInfo songInfo,
      required final TabMeta meta,
      required final TabContent content}) = _$TabTemplateImpl;

  factory _TabTemplate.fromJson(Map<String, dynamic> json) =
      _$TabTemplateImpl.fromJson;

  @override
  TabVersion get tabVersion;
  @override
  SongInfo get songInfo;
  @override
  TabMeta get meta;
  @override
  TabContent get content;

  /// Create a copy of TabTemplate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TabTemplateImplCopyWith<_$TabTemplateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TabVersion _$TabVersionFromJson(Map<String, dynamic> json) {
  return _TabVersion.fromJson(json);
}

/// @nodoc
mixin _$TabVersion {
  String get version => throw _privateConstructorUsedError;
  int get revision => throw _privateConstructorUsedError;

  /// Serializes this TabVersion to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TabVersion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TabVersionCopyWith<TabVersion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TabVersionCopyWith<$Res> {
  factory $TabVersionCopyWith(
          TabVersion value, $Res Function(TabVersion) then) =
      _$TabVersionCopyWithImpl<$Res, TabVersion>;
  @useResult
  $Res call({String version, int revision});
}

/// @nodoc
class _$TabVersionCopyWithImpl<$Res, $Val extends TabVersion>
    implements $TabVersionCopyWith<$Res> {
  _$TabVersionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TabVersion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? version = null,
    Object? revision = null,
  }) {
    return _then(_value.copyWith(
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      revision: null == revision
          ? _value.revision
          : revision // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TabVersionImplCopyWith<$Res>
    implements $TabVersionCopyWith<$Res> {
  factory _$$TabVersionImplCopyWith(
          _$TabVersionImpl value, $Res Function(_$TabVersionImpl) then) =
      __$$TabVersionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String version, int revision});
}

/// @nodoc
class __$$TabVersionImplCopyWithImpl<$Res>
    extends _$TabVersionCopyWithImpl<$Res, _$TabVersionImpl>
    implements _$$TabVersionImplCopyWith<$Res> {
  __$$TabVersionImplCopyWithImpl(
      _$TabVersionImpl _value, $Res Function(_$TabVersionImpl) _then)
      : super(_value, _then);

  /// Create a copy of TabVersion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? version = null,
    Object? revision = null,
  }) {
    return _then(_$TabVersionImpl(
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      revision: null == revision
          ? _value.revision
          : revision // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TabVersionImpl with DiagnosticableTreeMixin implements _TabVersion {
  const _$TabVersionImpl({this.version = '1.0', this.revision = 1});

  factory _$TabVersionImpl.fromJson(Map<String, dynamic> json) =>
      _$$TabVersionImplFromJson(json);

  @override
  @JsonKey()
  final String version;
  @override
  @JsonKey()
  final int revision;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TabVersion(version: $version, revision: $revision)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TabVersion'))
      ..add(DiagnosticsProperty('version', version))
      ..add(DiagnosticsProperty('revision', revision));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TabVersionImpl &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.revision, revision) ||
                other.revision == revision));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, version, revision);

  /// Create a copy of TabVersion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TabVersionImplCopyWith<_$TabVersionImpl> get copyWith =>
      __$$TabVersionImplCopyWithImpl<_$TabVersionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TabVersionImplToJson(
      this,
    );
  }
}

abstract class _TabVersion implements TabVersion {
  const factory _TabVersion({final String version, final int revision}) =
      _$TabVersionImpl;

  factory _TabVersion.fromJson(Map<String, dynamic> json) =
      _$TabVersionImpl.fromJson;

  @override
  String get version;
  @override
  int get revision;

  /// Create a copy of TabVersion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TabVersionImplCopyWith<_$TabVersionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SongInfo _$SongInfoFromJson(Map<String, dynamic> json) {
  return _SongInfo.fromJson(json);
}

/// @nodoc
mixin _$SongInfo {
  String get title => throw _privateConstructorUsedError;
  String get artist => throw _privateConstructorUsedError;
  List<String> get tuning => throw _privateConstructorUsedError;
  int get capo => throw _privateConstructorUsedError;
  String get difficulty => throw _privateConstructorUsedError;

  /// Serializes this SongInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SongInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SongInfoCopyWith<SongInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SongInfoCopyWith<$Res> {
  factory $SongInfoCopyWith(SongInfo value, $Res Function(SongInfo) then) =
      _$SongInfoCopyWithImpl<$Res, SongInfo>;
  @useResult
  $Res call(
      {String title,
      String artist,
      List<String> tuning,
      int capo,
      String difficulty});
}

/// @nodoc
class _$SongInfoCopyWithImpl<$Res, $Val extends SongInfo>
    implements $SongInfoCopyWith<$Res> {
  _$SongInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SongInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? artist = null,
    Object? tuning = null,
    Object? capo = null,
    Object? difficulty = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      artist: null == artist
          ? _value.artist
          : artist // ignore: cast_nullable_to_non_nullable
              as String,
      tuning: null == tuning
          ? _value.tuning
          : tuning // ignore: cast_nullable_to_non_nullable
              as List<String>,
      capo: null == capo
          ? _value.capo
          : capo // ignore: cast_nullable_to_non_nullable
              as int,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SongInfoImplCopyWith<$Res>
    implements $SongInfoCopyWith<$Res> {
  factory _$$SongInfoImplCopyWith(
          _$SongInfoImpl value, $Res Function(_$SongInfoImpl) then) =
      __$$SongInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String artist,
      List<String> tuning,
      int capo,
      String difficulty});
}

/// @nodoc
class __$$SongInfoImplCopyWithImpl<$Res>
    extends _$SongInfoCopyWithImpl<$Res, _$SongInfoImpl>
    implements _$$SongInfoImplCopyWith<$Res> {
  __$$SongInfoImplCopyWithImpl(
      _$SongInfoImpl _value, $Res Function(_$SongInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of SongInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? artist = null,
    Object? tuning = null,
    Object? capo = null,
    Object? difficulty = null,
  }) {
    return _then(_$SongInfoImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      artist: null == artist
          ? _value.artist
          : artist // ignore: cast_nullable_to_non_nullable
              as String,
      tuning: null == tuning
          ? _value._tuning
          : tuning // ignore: cast_nullable_to_non_nullable
              as List<String>,
      capo: null == capo
          ? _value.capo
          : capo // ignore: cast_nullable_to_non_nullable
              as int,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SongInfoImpl with DiagnosticableTreeMixin implements _SongInfo {
  const _$SongInfoImpl(
      {required this.title,
      required this.artist,
      final List<String> tuning = const ['E', 'A', 'D', 'G', 'B', 'E'],
      this.capo = 0,
      this.difficulty = 'beginner'})
      : _tuning = tuning;

  factory _$SongInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$SongInfoImplFromJson(json);

  @override
  final String title;
  @override
  final String artist;
  final List<String> _tuning;
  @override
  @JsonKey()
  List<String> get tuning {
    if (_tuning is EqualUnmodifiableListView) return _tuning;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tuning);
  }

  @override
  @JsonKey()
  final int capo;
  @override
  @JsonKey()
  final String difficulty;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SongInfo(title: $title, artist: $artist, tuning: $tuning, capo: $capo, difficulty: $difficulty)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SongInfo'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('artist', artist))
      ..add(DiagnosticsProperty('tuning', tuning))
      ..add(DiagnosticsProperty('capo', capo))
      ..add(DiagnosticsProperty('difficulty', difficulty));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SongInfoImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.artist, artist) || other.artist == artist) &&
            const DeepCollectionEquality().equals(other._tuning, _tuning) &&
            (identical(other.capo, capo) || other.capo == capo) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, artist,
      const DeepCollectionEquality().hash(_tuning), capo, difficulty);

  /// Create a copy of SongInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SongInfoImplCopyWith<_$SongInfoImpl> get copyWith =>
      __$$SongInfoImplCopyWithImpl<_$SongInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SongInfoImplToJson(
      this,
    );
  }
}

abstract class _SongInfo implements SongInfo {
  const factory _SongInfo(
      {required final String title,
      required final String artist,
      final List<String> tuning,
      final int capo,
      final String difficulty}) = _$SongInfoImpl;

  factory _SongInfo.fromJson(Map<String, dynamic> json) =
      _$SongInfoImpl.fromJson;

  @override
  String get title;
  @override
  String get artist;
  @override
  List<String> get tuning;
  @override
  int get capo;
  @override
  String get difficulty;

  /// Create a copy of SongInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SongInfoImplCopyWith<_$SongInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TabMeta _$TabMetaFromJson(Map<String, dynamic> json) {
  return _TabMeta.fromJson(json);
}

/// @nodoc
mixin _$TabMeta {
  int get tempo => throw _privateConstructorUsedError;
  String get timeSignature => throw _privateConstructorUsedError;
  String get key => throw _privateConstructorUsedError;

  /// Serializes this TabMeta to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TabMeta
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TabMetaCopyWith<TabMeta> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TabMetaCopyWith<$Res> {
  factory $TabMetaCopyWith(TabMeta value, $Res Function(TabMeta) then) =
      _$TabMetaCopyWithImpl<$Res, TabMeta>;
  @useResult
  $Res call({int tempo, String timeSignature, String key});
}

/// @nodoc
class _$TabMetaCopyWithImpl<$Res, $Val extends TabMeta>
    implements $TabMetaCopyWith<$Res> {
  _$TabMetaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TabMeta
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tempo = null,
    Object? timeSignature = null,
    Object? key = null,
  }) {
    return _then(_value.copyWith(
      tempo: null == tempo
          ? _value.tempo
          : tempo // ignore: cast_nullable_to_non_nullable
              as int,
      timeSignature: null == timeSignature
          ? _value.timeSignature
          : timeSignature // ignore: cast_nullable_to_non_nullable
              as String,
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TabMetaImplCopyWith<$Res> implements $TabMetaCopyWith<$Res> {
  factory _$$TabMetaImplCopyWith(
          _$TabMetaImpl value, $Res Function(_$TabMetaImpl) then) =
      __$$TabMetaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int tempo, String timeSignature, String key});
}

/// @nodoc
class __$$TabMetaImplCopyWithImpl<$Res>
    extends _$TabMetaCopyWithImpl<$Res, _$TabMetaImpl>
    implements _$$TabMetaImplCopyWith<$Res> {
  __$$TabMetaImplCopyWithImpl(
      _$TabMetaImpl _value, $Res Function(_$TabMetaImpl) _then)
      : super(_value, _then);

  /// Create a copy of TabMeta
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tempo = null,
    Object? timeSignature = null,
    Object? key = null,
  }) {
    return _then(_$TabMetaImpl(
      tempo: null == tempo
          ? _value.tempo
          : tempo // ignore: cast_nullable_to_non_nullable
              as int,
      timeSignature: null == timeSignature
          ? _value.timeSignature
          : timeSignature // ignore: cast_nullable_to_non_nullable
              as String,
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TabMetaImpl with DiagnosticableTreeMixin implements _TabMeta {
  const _$TabMetaImpl(
      {this.tempo = 120, this.timeSignature = '4/4', this.key = 'C'});

  factory _$TabMetaImpl.fromJson(Map<String, dynamic> json) =>
      _$$TabMetaImplFromJson(json);

  @override
  @JsonKey()
  final int tempo;
  @override
  @JsonKey()
  final String timeSignature;
  @override
  @JsonKey()
  final String key;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TabMeta(tempo: $tempo, timeSignature: $timeSignature, key: $key)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TabMeta'))
      ..add(DiagnosticsProperty('tempo', tempo))
      ..add(DiagnosticsProperty('timeSignature', timeSignature))
      ..add(DiagnosticsProperty('key', key));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TabMetaImpl &&
            (identical(other.tempo, tempo) || other.tempo == tempo) &&
            (identical(other.timeSignature, timeSignature) ||
                other.timeSignature == timeSignature) &&
            (identical(other.key, key) || other.key == key));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, tempo, timeSignature, key);

  /// Create a copy of TabMeta
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TabMetaImplCopyWith<_$TabMetaImpl> get copyWith =>
      __$$TabMetaImplCopyWithImpl<_$TabMetaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TabMetaImplToJson(
      this,
    );
  }
}

abstract class _TabMeta implements TabMeta {
  const factory _TabMeta(
      {final int tempo,
      final String timeSignature,
      final String key}) = _$TabMetaImpl;

  factory _TabMeta.fromJson(Map<String, dynamic> json) = _$TabMetaImpl.fromJson;

  @override
  int get tempo;
  @override
  String get timeSignature;
  @override
  String get key;

  /// Create a copy of TabMeta
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TabMetaImplCopyWith<_$TabMetaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TabContent _$TabContentFromJson(Map<String, dynamic> json) {
  return _TabContent.fromJson(json);
}

/// @nodoc
mixin _$TabContent {
  List<Measure> get measures => throw _privateConstructorUsedError;

  /// Serializes this TabContent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TabContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TabContentCopyWith<TabContent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TabContentCopyWith<$Res> {
  factory $TabContentCopyWith(
          TabContent value, $Res Function(TabContent) then) =
      _$TabContentCopyWithImpl<$Res, TabContent>;
  @useResult
  $Res call({List<Measure> measures});
}

/// @nodoc
class _$TabContentCopyWithImpl<$Res, $Val extends TabContent>
    implements $TabContentCopyWith<$Res> {
  _$TabContentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TabContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? measures = null,
  }) {
    return _then(_value.copyWith(
      measures: null == measures
          ? _value.measures
          : measures // ignore: cast_nullable_to_non_nullable
              as List<Measure>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TabContentImplCopyWith<$Res>
    implements $TabContentCopyWith<$Res> {
  factory _$$TabContentImplCopyWith(
          _$TabContentImpl value, $Res Function(_$TabContentImpl) then) =
      __$$TabContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Measure> measures});
}

/// @nodoc
class __$$TabContentImplCopyWithImpl<$Res>
    extends _$TabContentCopyWithImpl<$Res, _$TabContentImpl>
    implements _$$TabContentImplCopyWith<$Res> {
  __$$TabContentImplCopyWithImpl(
      _$TabContentImpl _value, $Res Function(_$TabContentImpl) _then)
      : super(_value, _then);

  /// Create a copy of TabContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? measures = null,
  }) {
    return _then(_$TabContentImpl(
      measures: null == measures
          ? _value._measures
          : measures // ignore: cast_nullable_to_non_nullable
              as List<Measure>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TabContentImpl with DiagnosticableTreeMixin implements _TabContent {
  const _$TabContentImpl({required final List<Measure> measures})
      : _measures = measures;

  factory _$TabContentImpl.fromJson(Map<String, dynamic> json) =>
      _$$TabContentImplFromJson(json);

  final List<Measure> _measures;
  @override
  List<Measure> get measures {
    if (_measures is EqualUnmodifiableListView) return _measures;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_measures);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TabContent(measures: $measures)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TabContent'))
      ..add(DiagnosticsProperty('measures', measures));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TabContentImpl &&
            const DeepCollectionEquality().equals(other._measures, _measures));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_measures));

  /// Create a copy of TabContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TabContentImplCopyWith<_$TabContentImpl> get copyWith =>
      __$$TabContentImplCopyWithImpl<_$TabContentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TabContentImplToJson(
      this,
    );
  }
}

abstract class _TabContent implements TabContent {
  const factory _TabContent({required final List<Measure> measures}) =
      _$TabContentImpl;

  factory _TabContent.fromJson(Map<String, dynamic> json) =
      _$TabContentImpl.fromJson;

  @override
  List<Measure> get measures;

  /// Create a copy of TabContent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TabContentImplCopyWith<_$TabContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Measure _$MeasureFromJson(Map<String, dynamic> json) {
  return _Measure.fromJson(json);
}

/// @nodoc
mixin _$Measure {
  int get index => throw _privateConstructorUsedError;
  String get timeSignature => throw _privateConstructorUsedError;
  List<TabString> get strings => throw _privateConstructorUsedError;

  /// Serializes this Measure to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Measure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MeasureCopyWith<Measure> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MeasureCopyWith<$Res> {
  factory $MeasureCopyWith(Measure value, $Res Function(Measure) then) =
      _$MeasureCopyWithImpl<$Res, Measure>;
  @useResult
  $Res call({int index, String timeSignature, List<TabString> strings});
}

/// @nodoc
class _$MeasureCopyWithImpl<$Res, $Val extends Measure>
    implements $MeasureCopyWith<$Res> {
  _$MeasureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Measure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
    Object? timeSignature = null,
    Object? strings = null,
  }) {
    return _then(_value.copyWith(
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      timeSignature: null == timeSignature
          ? _value.timeSignature
          : timeSignature // ignore: cast_nullable_to_non_nullable
              as String,
      strings: null == strings
          ? _value.strings
          : strings // ignore: cast_nullable_to_non_nullable
              as List<TabString>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MeasureImplCopyWith<$Res> implements $MeasureCopyWith<$Res> {
  factory _$$MeasureImplCopyWith(
          _$MeasureImpl value, $Res Function(_$MeasureImpl) then) =
      __$$MeasureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int index, String timeSignature, List<TabString> strings});
}

/// @nodoc
class __$$MeasureImplCopyWithImpl<$Res>
    extends _$MeasureCopyWithImpl<$Res, _$MeasureImpl>
    implements _$$MeasureImplCopyWith<$Res> {
  __$$MeasureImplCopyWithImpl(
      _$MeasureImpl _value, $Res Function(_$MeasureImpl) _then)
      : super(_value, _then);

  /// Create a copy of Measure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
    Object? timeSignature = null,
    Object? strings = null,
  }) {
    return _then(_$MeasureImpl(
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      timeSignature: null == timeSignature
          ? _value.timeSignature
          : timeSignature // ignore: cast_nullable_to_non_nullable
              as String,
      strings: null == strings
          ? _value._strings
          : strings // ignore: cast_nullable_to_non_nullable
              as List<TabString>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MeasureImpl with DiagnosticableTreeMixin implements _Measure {
  const _$MeasureImpl(
      {required this.index,
      this.timeSignature = '4/4',
      required final List<TabString> strings})
      : _strings = strings;

  factory _$MeasureImpl.fromJson(Map<String, dynamic> json) =>
      _$$MeasureImplFromJson(json);

  @override
  final int index;
  @override
  @JsonKey()
  final String timeSignature;
  final List<TabString> _strings;
  @override
  List<TabString> get strings {
    if (_strings is EqualUnmodifiableListView) return _strings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_strings);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Measure(index: $index, timeSignature: $timeSignature, strings: $strings)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Measure'))
      ..add(DiagnosticsProperty('index', index))
      ..add(DiagnosticsProperty('timeSignature', timeSignature))
      ..add(DiagnosticsProperty('strings', strings));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MeasureImpl &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.timeSignature, timeSignature) ||
                other.timeSignature == timeSignature) &&
            const DeepCollectionEquality().equals(other._strings, _strings));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, index, timeSignature,
      const DeepCollectionEquality().hash(_strings));

  /// Create a copy of Measure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MeasureImplCopyWith<_$MeasureImpl> get copyWith =>
      __$$MeasureImplCopyWithImpl<_$MeasureImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MeasureImplToJson(
      this,
    );
  }
}

abstract class _Measure implements Measure {
  const factory _Measure(
      {required final int index,
      final String timeSignature,
      required final List<TabString> strings}) = _$MeasureImpl;

  factory _Measure.fromJson(Map<String, dynamic> json) = _$MeasureImpl.fromJson;

  @override
  int get index;
  @override
  String get timeSignature;
  @override
  List<TabString> get strings;

  /// Create a copy of Measure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MeasureImplCopyWith<_$MeasureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TabString _$TabStringFromJson(Map<String, dynamic> json) {
  return _TabString.fromJson(json);
}

/// @nodoc
mixin _$TabString {
  int get string => throw _privateConstructorUsedError;
  List<Note> get notes => throw _privateConstructorUsedError;

  /// Serializes this TabString to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TabString
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TabStringCopyWith<TabString> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TabStringCopyWith<$Res> {
  factory $TabStringCopyWith(TabString value, $Res Function(TabString) then) =
      _$TabStringCopyWithImpl<$Res, TabString>;
  @useResult
  $Res call({int string, List<Note> notes});
}

/// @nodoc
class _$TabStringCopyWithImpl<$Res, $Val extends TabString>
    implements $TabStringCopyWith<$Res> {
  _$TabStringCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TabString
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? string = null,
    Object? notes = null,
  }) {
    return _then(_value.copyWith(
      string: null == string
          ? _value.string
          : string // ignore: cast_nullable_to_non_nullable
              as int,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as List<Note>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TabStringImplCopyWith<$Res>
    implements $TabStringCopyWith<$Res> {
  factory _$$TabStringImplCopyWith(
          _$TabStringImpl value, $Res Function(_$TabStringImpl) then) =
      __$$TabStringImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int string, List<Note> notes});
}

/// @nodoc
class __$$TabStringImplCopyWithImpl<$Res>
    extends _$TabStringCopyWithImpl<$Res, _$TabStringImpl>
    implements _$$TabStringImplCopyWith<$Res> {
  __$$TabStringImplCopyWithImpl(
      _$TabStringImpl _value, $Res Function(_$TabStringImpl) _then)
      : super(_value, _then);

  /// Create a copy of TabString
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? string = null,
    Object? notes = null,
  }) {
    return _then(_$TabStringImpl(
      string: null == string
          ? _value.string
          : string // ignore: cast_nullable_to_non_nullable
              as int,
      notes: null == notes
          ? _value._notes
          : notes // ignore: cast_nullable_to_non_nullable
              as List<Note>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TabStringImpl with DiagnosticableTreeMixin implements _TabString {
  const _$TabStringImpl({required this.string, required final List<Note> notes})
      : _notes = notes;

  factory _$TabStringImpl.fromJson(Map<String, dynamic> json) =>
      _$$TabStringImplFromJson(json);

  @override
  final int string;
  final List<Note> _notes;
  @override
  List<Note> get notes {
    if (_notes is EqualUnmodifiableListView) return _notes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_notes);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TabString(string: $string, notes: $notes)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TabString'))
      ..add(DiagnosticsProperty('string', string))
      ..add(DiagnosticsProperty('notes', notes));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TabStringImpl &&
            (identical(other.string, string) || other.string == string) &&
            const DeepCollectionEquality().equals(other._notes, _notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, string, const DeepCollectionEquality().hash(_notes));

  /// Create a copy of TabString
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TabStringImplCopyWith<_$TabStringImpl> get copyWith =>
      __$$TabStringImplCopyWithImpl<_$TabStringImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TabStringImplToJson(
      this,
    );
  }
}

abstract class _TabString implements TabString {
  const factory _TabString(
      {required final int string,
      required final List<Note> notes}) = _$TabStringImpl;

  factory _TabString.fromJson(Map<String, dynamic> json) =
      _$TabStringImpl.fromJson;

  @override
  int get string;
  @override
  List<Note> get notes;

  /// Create a copy of TabString
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TabStringImplCopyWith<_$TabStringImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Note _$NoteFromJson(Map<String, dynamic> json) {
  return _Note.fromJson(json);
}

/// @nodoc
mixin _$Note {
  int get fret => throw _privateConstructorUsedError;
  double get duration => throw _privateConstructorUsedError;
  int get position => throw _privateConstructorUsedError;
  String? get technique => throw _privateConstructorUsedError;

  /// Serializes this Note to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Note
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NoteCopyWith<Note> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NoteCopyWith<$Res> {
  factory $NoteCopyWith(Note value, $Res Function(Note) then) =
      _$NoteCopyWithImpl<$Res, Note>;
  @useResult
  $Res call({int fret, double duration, int position, String? technique});
}

/// @nodoc
class _$NoteCopyWithImpl<$Res, $Val extends Note>
    implements $NoteCopyWith<$Res> {
  _$NoteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Note
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fret = null,
    Object? duration = null,
    Object? position = null,
    Object? technique = freezed,
  }) {
    return _then(_value.copyWith(
      fret: null == fret
          ? _value.fret
          : fret // ignore: cast_nullable_to_non_nullable
              as int,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as double,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
      technique: freezed == technique
          ? _value.technique
          : technique // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NoteImplCopyWith<$Res> implements $NoteCopyWith<$Res> {
  factory _$$NoteImplCopyWith(
          _$NoteImpl value, $Res Function(_$NoteImpl) then) =
      __$$NoteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int fret, double duration, int position, String? technique});
}

/// @nodoc
class __$$NoteImplCopyWithImpl<$Res>
    extends _$NoteCopyWithImpl<$Res, _$NoteImpl>
    implements _$$NoteImplCopyWith<$Res> {
  __$$NoteImplCopyWithImpl(_$NoteImpl _value, $Res Function(_$NoteImpl) _then)
      : super(_value, _then);

  /// Create a copy of Note
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fret = null,
    Object? duration = null,
    Object? position = null,
    Object? technique = freezed,
  }) {
    return _then(_$NoteImpl(
      fret: null == fret
          ? _value.fret
          : fret // ignore: cast_nullable_to_non_nullable
              as int,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as double,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
      technique: freezed == technique
          ? _value.technique
          : technique // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NoteImpl with DiagnosticableTreeMixin implements _Note {
  const _$NoteImpl(
      {required this.fret,
      required this.duration,
      required this.position,
      this.technique});

  factory _$NoteImpl.fromJson(Map<String, dynamic> json) =>
      _$$NoteImplFromJson(json);

  @override
  final int fret;
  @override
  final double duration;
  @override
  final int position;
  @override
  final String? technique;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Note(fret: $fret, duration: $duration, position: $position, technique: $technique)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Note'))
      ..add(DiagnosticsProperty('fret', fret))
      ..add(DiagnosticsProperty('duration', duration))
      ..add(DiagnosticsProperty('position', position))
      ..add(DiagnosticsProperty('technique', technique));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NoteImpl &&
            (identical(other.fret, fret) || other.fret == fret) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.technique, technique) ||
                other.technique == technique));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, fret, duration, position, technique);

  /// Create a copy of Note
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NoteImplCopyWith<_$NoteImpl> get copyWith =>
      __$$NoteImplCopyWithImpl<_$NoteImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NoteImplToJson(
      this,
    );
  }
}

abstract class _Note implements Note {
  const factory _Note(
      {required final int fret,
      required final double duration,
      required final int position,
      final String? technique}) = _$NoteImpl;

  factory _Note.fromJson(Map<String, dynamic> json) = _$NoteImpl.fromJson;

  @override
  int get fret;
  @override
  double get duration;
  @override
  int get position;
  @override
  String? get technique;

  /// Create a copy of Note
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NoteImplCopyWith<_$NoteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
