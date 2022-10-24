import 'package:freezed_annotation/freezed_annotation.dart';
part 'movie_list.g.dart';
part 'movie_list.freezed.dart';

@freezed
class MovieList with _$MovieList {
  const factory MovieList({
    required bool private,
    required String name,
    String? listID,
    required List<String> ids,
    required String by,
  }) = _MovieList;

  factory MovieList.fromJson(Map<String, Object?> json) =>
      _$MovieListFromJson(json);
}
