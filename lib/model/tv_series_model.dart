import 'dart:convert';

class TvSeriesModel {
  int page;
  List<Result> results;
  int totalPages;
  int totalResults;

  TvSeriesModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  TvSeriesModel copyWith({
    int? page,
    List<Result>? results,
    int? totalPages,
    int? totalResults,
  }) =>
      TvSeriesModel(
        page: page ?? this.page,
        results: results ?? this.results,
        totalPages: totalPages ?? this.totalPages,
        totalResults: totalResults ?? this.totalResults,
      );

  factory TvSeriesModel.fromRawJson(String str) => TvSeriesModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TvSeriesModel.fromJson(Map<String, dynamic> json) => TvSeriesModel(
    page: json["page"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}

class Result {
  String backdropPath;
  DateTime firstAirDate;
  List<int> genreIds;
  int id;
  String name;
  List<OriginCountry> originCountry;
  OriginalLanguage originalLanguage;
  String originalName;
  String overview;
  double popularity;
  String posterPath;
  double voteAverage;
  int voteCount;

  Result({
    required this.backdropPath,
    required this.firstAirDate,
    required this.genreIds,
    required this.id,
    required this.name,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
  });

  Result copyWith({
    String? backdropPath,
    DateTime? firstAirDate,
    List<int>? genreIds,
    int? id,
    String? name,
    List<OriginCountry>? originCountry,
    OriginalLanguage? originalLanguage,
    String? originalName,
    String? overview,
    double? popularity,
    String? posterPath,
    double? voteAverage,
    int? voteCount,
  }) =>
      Result(
        backdropPath: backdropPath ?? this.backdropPath,
        firstAirDate: firstAirDate ?? this.firstAirDate,
        genreIds: genreIds ?? this.genreIds,
        id: id ?? this.id,
        name: name ?? this.name,
        originCountry: originCountry ?? this.originCountry,
        originalLanguage: originalLanguage ?? this.originalLanguage,
        originalName: originalName ?? this.originalName,
        overview: overview ?? this.overview,
        popularity: popularity ?? this.popularity,
        posterPath: posterPath ?? this.posterPath,
        voteAverage: voteAverage ?? this.voteAverage,
        voteCount: voteCount ?? this.voteCount,
      );

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    backdropPath: json["backdrop_path"],
    firstAirDate: DateTime.parse(json["first_air_date"]),
    genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
    id: json["id"],
    name: json["name"],
    originCountry: List<OriginCountry>.from(json["origin_country"].map((x) => originCountryValues.map[x]!)),
    originalLanguage: originalLanguageValues.map[json["original_language"]]!,
    originalName: json["original_name"],
    overview: json["overview"],
    popularity: json["popularity"]?.toDouble(),
    posterPath: json["poster_path"],
    voteAverage: json["vote_average"]?.toDouble(),
    voteCount: json["vote_count"],
  );

  Map<String, dynamic> toJson() => {
    "backdrop_path": backdropPath,
    "first_air_date": "${firstAirDate.year.toString().padLeft(4, '0')}-${firstAirDate.month.toString().padLeft(2, '0')}-${firstAirDate.day.toString().padLeft(2, '0')}",
    "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
    "id": id,
    "name": name,
    "origin_country": List<dynamic>.from(originCountry.map((x) => originCountryValues.reverse[x])),
    "original_language": originalLanguageValues.reverse[originalLanguage],
    "original_name": originalName,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}

enum OriginCountry {
  CA,
  JP,
  KR,
  US
}

final originCountryValues = EnumValues({
  "CA": OriginCountry.CA,
  "JP": OriginCountry.JP,
  "KR": OriginCountry.KR,
  "US": OriginCountry.US
});

enum OriginalLanguage {
  EN,
  JA,
  KO
}

final originalLanguageValues = EnumValues({
  "en": OriginalLanguage.EN,
  "ja": OriginalLanguage.JA,
  "ko": OriginalLanguage.KO
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
