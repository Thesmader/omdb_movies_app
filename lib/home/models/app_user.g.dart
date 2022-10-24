// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AppUser _$$_AppUserFromJson(Map<String, dynamic> json) => _$_AppUser(
      privateLists: (json['private_lists'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      publicLists: (json['public_lists'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_AppUserToJson(_$_AppUser instance) =>
    <String, dynamic>{
      'private_lists': instance.privateLists,
      'public_lists': instance.publicLists,
    };
