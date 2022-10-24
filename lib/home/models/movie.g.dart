// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Movie _$$_MovieFromJson(Map<String, dynamic> json) => _$_Movie(
      title: json['Title'] as String,
      year: json['Year'] as String,
      released: json['Released'] as String?,
      genre: json['Genre'] as String?,
      poster: json['Poster'] as String,
      runtime: json['Runtime'] as String?,
      imdbID: json['imdbID'] as String?,
    );

Map<String, dynamic> _$$_MovieToJson(_$_Movie instance) => <String, dynamic>{
      'Title': instance.title,
      'Year': instance.year,
      'Released': instance.released,
      'Genre': instance.genre,
      'Poster': instance.poster,
      'Runtime': instance.runtime,
      'imdbID': instance.imdbID,
    };
