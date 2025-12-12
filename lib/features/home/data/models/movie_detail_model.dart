import 'package:equatable/equatable.dart';

class MovieDetailModel extends Equatable {
  final int id;
  final String title;
  final String? posterPath;
  final String? backdropPath;
  final String overview;
  final double voteAverage;
  final int voteCount;
  final String releaseDate;
  final List<Genre> genres;
  final int runtime;
  final String status;
  final String? tagline;
  final int budget;
  final int revenue;
  final List<ProductionCompany> productionCompanies;
  final List<ProductionCountry> productionCountries;
  final List<SpokenLanguage> spokenLanguages;

  const MovieDetailModel({
    required this.id,
    required this.title,
    this.posterPath,
    this.backdropPath,
    required this.overview,
    required this.voteAverage,
    required this.voteCount,
    required this.releaseDate,
    required this.genres,
    required this.runtime,
    required this.status,
    this.tagline,
    required this.budget,
    required this.revenue,
    required this.productionCompanies,
    required this.productionCountries,
    required this.spokenLanguages,
  });

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      overview: json['overview'] ?? '',
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      voteCount: json['vote_count'] ?? 0,
      releaseDate: json['release_date'] ?? '',
      genres: (json['genres'] as List?)
              ?.map((genre) => Genre.fromJson(genre))
              .toList() ??
          [],
      runtime: json['runtime'] ?? 0,
      status: json['status'] ?? '',
      tagline: json['tagline'],
      budget: json['budget'] ?? 0,
      revenue: json['revenue'] ?? 0,
      productionCompanies: (json['production_companies'] as List?)
              ?.map((company) => ProductionCompany.fromJson(company))
              .toList() ??
          [],
      productionCountries: (json['production_countries'] as List?)
              ?.map((country) => ProductionCountry.fromJson(country))
              .toList() ??
          [],
      spokenLanguages: (json['spoken_languages'] as List?)
              ?.map((lang) => SpokenLanguage.fromJson(lang))
              .toList() ??
          [],
    );
  }

  String get posterUrl => posterPath != null
      ? 'https://image.tmdb.org/t/p/w500$posterPath'
      : '';

  String get backdropUrl => backdropPath != null
      ? 'https://image.tmdb.org/t/p/original$backdropPath'
      : '';

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'poster_path': posterPath,
      'backdrop_path': backdropPath,
      'overview': overview,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'release_date': releaseDate,
      'genres': genres.map((g) => {'id': g.id, 'name': g.name}).toList(),
      'runtime': runtime,
      'status': status,
      'tagline': tagline,
      'budget': budget,
      'revenue': revenue,
      'production_companies': productionCompanies,
      'production_countries': productionCountries,
      'spoken_languages': spokenLanguages,
    };
  }

  @override
  List<Object?> get props => [
        id,
        title,
        posterPath,
        backdropPath,
        overview,
        voteAverage,
        voteCount,
        releaseDate,
        genres,
        runtime,
        status,
        tagline,
        budget,
        revenue,
      ];
}

class Genre extends Equatable {
  final int id;
  final String name;

  const Genre({required this.id, required this.name});

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }

  @override
  List<Object?> get props => [id, name];
}

class ProductionCompany extends Equatable {
  final int id;
  final String name;
  final String? logoPath;
  final String originCountry;

  const ProductionCompany({
    required this.id,
    required this.name,
    this.logoPath,
    required this.originCountry,
  });

  factory ProductionCompany.fromJson(Map<String, dynamic> json) {
    return ProductionCompany(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      logoPath: json['logo_path'],
      originCountry: json['origin_country'] ?? '',
    );
  }

  @override
  List<Object?> get props => [id, name, logoPath, originCountry];
}

class ProductionCountry extends Equatable {
  final String iso31661;
  final String name;

  const ProductionCountry({
    required this.iso31661,
    required this.name,
  });

  factory ProductionCountry.fromJson(Map<String, dynamic> json) {
    return ProductionCountry(
      iso31661: json['iso_3166_1'] ?? '',
      name: json['name'] ?? '',
    );
  }

  @override
  List<Object?> get props => [iso31661, name];
}

class SpokenLanguage extends Equatable {
  final String iso6391;
  final String name;
  final String englishName;

  const SpokenLanguage({
    required this.iso6391,
    required this.name,
    required this.englishName,
  });

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) {
    return SpokenLanguage(
      iso6391: json['iso_639_1'] ?? '',
      name: json['name'] ?? '',
      englishName: json['english_name'] ?? '',
    );
  }

  @override
  List<Object?> get props => [iso6391, name, englishName];
}
