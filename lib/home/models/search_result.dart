// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:omdb_movies_app/home/home.dart';
part 'search_result.g.dart';
part 'search_result.freezed.dart';

@freezed
class SearchResult with _$SearchResult {
  const factory SearchResult({
    @Default([]) @JsonKey(name: 'Search') List<Movie> movies,
  }) = _SearchResult;
  factory SearchResult.fromJson(Map<String, Object?> json) =>
      _$SearchResultFromJson(json);
}
