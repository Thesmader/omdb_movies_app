// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
part 'app_user.g.dart';
part 'app_user.freezed.dart';

@freezed
class AppUser with _$AppUser {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory AppUser({
    @Default([]) List<String> privateLists,
    @Default([]) List<String> publicLists,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
}
