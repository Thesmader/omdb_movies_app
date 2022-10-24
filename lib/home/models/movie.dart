// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie.freezed.dart';
part 'movie.g.dart';

@freezed
class Movie with _$Movie {
  @JsonSerializable(fieldRename: FieldRename.pascal)
  const factory Movie({
    required String title,
    required String year,
    String? released,
    String? genre,
    required String poster,
    String? runtime,
    @JsonKey(name: 'imdbID') String? imdbID,
  }) = _Movie;

  factory Movie.fromJson(Map<String, Object?> json) => _$MovieFromJson(json);
}
