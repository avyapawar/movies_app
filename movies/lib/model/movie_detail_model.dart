class MovieDetailModel {
  final bool? adult;
  final String? backdropPath;
  final int? budget;
  final List<Genre>? genres;
  final String? homepage;
  final int? id;
  final String? imdbId;
  final String? originalLanguage;
  final String?originalTitle;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final List<ProductionCompany>? productionCompanies;
  final List<ProductionCountry>? productionCountries;
  final DateTime? releaseDate;
  final int? revenue;
  final int? runtime;
  final List<SpokenLanguage>? spokenLanguages;
  final String? status;
  final String? tagline;
  final String? title;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;

  MovieDetailModel({
    required this.adult,
    required this.backdropPath,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });
factory MovieDetailModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailModel(
      adult: json['adult'] ?? false,
      backdropPath: json['backdrop_path'] ?? '',
      budget: json['budget'] ?? 0,
      genres: _parseGenres(json['genres']),
      homepage: json['homepage'] ?? '',
      id: json['id'] ?? 0,
      imdbId: json['imdb_id'] ?? '',
      originalLanguage: json['original_language'] ?? '',
      originalTitle: json['original_title'] ?? '',
      overview: json['overview'] ?? '',
      popularity: json['popularity'] ?? 0.0,
      posterPath: json['poster_path'] ?? '',
      productionCompanies: _parseProductionCompanies(json['production_companies']),
      productionCountries: _parseProductionCountries(json['production_countries']),
      releaseDate: DateTime.tryParse(json['release_date'] ?? '') ?? DateTime(2000),
      revenue: json['revenue'] ?? 0,
      runtime: json['runtime'] ?? 0,
      spokenLanguages: _parseSpokenLanguages(json['spoken_languages']),
      status: json['status'] ?? '',
      tagline: json['tagline'] ?? '',
      title: json['title'] ?? '',
      video: json['video'] ?? false,
      voteAverage: json['vote_average'] ?? 0.0,
      voteCount: json['vote_count'] ?? 0,
    );
  }

  static List<Genre> _parseGenres(List<dynamic> json) {
    return json
        .map((genre) => Genre(
              id: genre['id'] ?? 0,
              name: genre['name'] ?? '',
            ))
        .toList();
  }

  static List<ProductionCompany> _parseProductionCompanies(List<dynamic> json) {
    return json
        .map((company) => ProductionCompany(
              id: company['id'] ?? 0,
              logoPath: company['logo_path'] ?? '',
              name: company['name'] ?? '',
              originCountry: company['origin_country'] ?? '',
            ))
        .toList();
  }

  static List<ProductionCountry> _parseProductionCountries(List<dynamic> json) {
    return json
        .map((country) => ProductionCountry(
              iso_3166_1: country['iso_3166_1'] ?? '',
              name: country['name'] ?? '',
            ))
        .toList();
  }

  static List<SpokenLanguage> _parseSpokenLanguages(List<dynamic> json) {
    return json
        .map((language) => SpokenLanguage(
              englishName: language['english_name'] ?? '',
              iso_639_1: language['iso_639_1'] ?? '',
              name: language['name'] ?? '',
            ))
        .toList();
  }
}



class Genre {
  final int id;
  final String name;

  Genre({required this.id, required this.name});
}

class ProductionCompany {
  final int id;
  final String? logoPath;
  final String name;
  final String originCountry;

  ProductionCompany({
    required this.id,
    required this.logoPath,
    required this.name,
    required this.originCountry,
  });
}

class ProductionCountry {
  final String iso_3166_1;
  final String name;

  ProductionCountry({required this.iso_3166_1, required this.name});
}

class SpokenLanguage {
  final String englishName;
  final String iso_639_1;
  final String name;

  SpokenLanguage({
    required this.englishName,
    required this.iso_639_1,
    required this.name,
  });
}