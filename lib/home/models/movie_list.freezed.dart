// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'movie_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MovieList _$MovieListFromJson(Map<String, dynamic> json) {
  return _MovieList.fromJson(json);
}

/// @nodoc
mixin _$MovieList {
  bool get private => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get listID => throw _privateConstructorUsedError;
  List<String> get ids => throw _privateConstructorUsedError;
  String get by => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MovieListCopyWith<MovieList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MovieListCopyWith<$Res> {
  factory $MovieListCopyWith(MovieList value, $Res Function(MovieList) then) =
      _$MovieListCopyWithImpl<$Res, MovieList>;
  @useResult
  $Res call(
      {bool private, String name, String? listID, List<String> ids, String by});
}

/// @nodoc
class _$MovieListCopyWithImpl<$Res, $Val extends MovieList>
    implements $MovieListCopyWith<$Res> {
  _$MovieListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? private = null,
    Object? name = null,
    Object? listID = freezed,
    Object? ids = null,
    Object? by = null,
  }) {
    return _then(_value.copyWith(
      private: null == private
          ? _value.private
          : private // ignore: cast_nullable_to_non_nullable
              as bool,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      listID: freezed == listID
          ? _value.listID
          : listID // ignore: cast_nullable_to_non_nullable
              as String?,
      ids: null == ids
          ? _value.ids
          : ids // ignore: cast_nullable_to_non_nullable
              as List<String>,
      by: null == by
          ? _value.by
          : by // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MovieListCopyWith<$Res> implements $MovieListCopyWith<$Res> {
  factory _$$_MovieListCopyWith(
          _$_MovieList value, $Res Function(_$_MovieList) then) =
      __$$_MovieListCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool private, String name, String? listID, List<String> ids, String by});
}

/// @nodoc
class __$$_MovieListCopyWithImpl<$Res>
    extends _$MovieListCopyWithImpl<$Res, _$_MovieList>
    implements _$$_MovieListCopyWith<$Res> {
  __$$_MovieListCopyWithImpl(
      _$_MovieList _value, $Res Function(_$_MovieList) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? private = null,
    Object? name = null,
    Object? listID = freezed,
    Object? ids = null,
    Object? by = null,
  }) {
    return _then(_$_MovieList(
      private: null == private
          ? _value.private
          : private // ignore: cast_nullable_to_non_nullable
              as bool,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      listID: freezed == listID
          ? _value.listID
          : listID // ignore: cast_nullable_to_non_nullable
              as String?,
      ids: null == ids
          ? _value._ids
          : ids // ignore: cast_nullable_to_non_nullable
              as List<String>,
      by: null == by
          ? _value.by
          : by // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MovieList implements _MovieList {
  const _$_MovieList(
      {required this.private,
      required this.name,
      this.listID,
      required final List<String> ids,
      required this.by})
      : _ids = ids;

  factory _$_MovieList.fromJson(Map<String, dynamic> json) =>
      _$$_MovieListFromJson(json);

  @override
  final bool private;
  @override
  final String name;
  @override
  final String? listID;
  final List<String> _ids;
  @override
  List<String> get ids {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ids);
  }

  @override
  final String by;

  @override
  String toString() {
    return 'MovieList(private: $private, name: $name, listID: $listID, ids: $ids, by: $by)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MovieList &&
            (identical(other.private, private) || other.private == private) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.listID, listID) || other.listID == listID) &&
            const DeepCollectionEquality().equals(other._ids, _ids) &&
            (identical(other.by, by) || other.by == by));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, private, name, listID,
      const DeepCollectionEquality().hash(_ids), by);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MovieListCopyWith<_$_MovieList> get copyWith =>
      __$$_MovieListCopyWithImpl<_$_MovieList>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MovieListToJson(
      this,
    );
  }
}

abstract class _MovieList implements MovieList {
  const factory _MovieList(
      {required final bool private,
      required final String name,
      final String? listID,
      required final List<String> ids,
      required final String by}) = _$_MovieList;

  factory _MovieList.fromJson(Map<String, dynamic> json) =
      _$_MovieList.fromJson;

  @override
  bool get private;
  @override
  String get name;
  @override
  String? get listID;
  @override
  List<String> get ids;
  @override
  String get by;
  @override
  @JsonKey(ignore: true)
  _$$_MovieListCopyWith<_$_MovieList> get copyWith =>
      throw _privateConstructorUsedError;
}
