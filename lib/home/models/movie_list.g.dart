// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MovieList _$$_MovieListFromJson(Map<String, dynamic> json) => _$_MovieList(
      private: json['private'] as bool,
      name: json['name'] as String,
      listID: json['listID'] as String?,
      ids: (json['ids'] as List<dynamic>).map((e) => e as String).toList(),
      by: json['by'] as String,
    );

Map<String, dynamic> _$$_MovieListToJson(_$_MovieList instance) =>
    <String, dynamic>{
      'private': instance.private,
      'name': instance.name,
      'listID': instance.listID,
      'ids': instance.ids,
      'by': instance.by,
    };
