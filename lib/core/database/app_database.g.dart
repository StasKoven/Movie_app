// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CachedMoviesTable extends CachedMovies
    with TableInfo<$CachedMoviesTable, CachedMovy> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedMoviesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _overviewMeta =
      const VerificationMeta('overview');
  @override
  late final GeneratedColumn<String> overview = GeneratedColumn<String>(
      'overview', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _posterPathMeta =
      const VerificationMeta('posterPath');
  @override
  late final GeneratedColumn<String> posterPath = GeneratedColumn<String>(
      'poster_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _backdropPathMeta =
      const VerificationMeta('backdropPath');
  @override
  late final GeneratedColumn<String> backdropPath = GeneratedColumn<String>(
      'backdrop_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _voteAverageMeta =
      const VerificationMeta('voteAverage');
  @override
  late final GeneratedColumn<double> voteAverage = GeneratedColumn<double>(
      'vote_average', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _voteCountMeta =
      const VerificationMeta('voteCount');
  @override
  late final GeneratedColumn<int> voteCount = GeneratedColumn<int>(
      'vote_count', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _releaseDateMeta =
      const VerificationMeta('releaseDate');
  @override
  late final GeneratedColumn<String> releaseDate = GeneratedColumn<String>(
      'release_date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _adultMeta = const VerificationMeta('adult');
  @override
  late final GeneratedColumn<bool> adult = GeneratedColumn<bool>(
      'adult', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("adult" IN (0, 1))'));
  static const VerificationMeta _originalLanguageMeta =
      const VerificationMeta('originalLanguage');
  @override
  late final GeneratedColumn<String> originalLanguage = GeneratedColumn<String>(
      'original_language', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _popularityMeta =
      const VerificationMeta('popularity');
  @override
  late final GeneratedColumn<double> popularity = GeneratedColumn<double>(
      'popularity', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _genreIdsMeta =
      const VerificationMeta('genreIds');
  @override
  late final GeneratedColumn<String> genreIds = GeneratedColumn<String>(
      'genre_ids', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _cachedAtMeta =
      const VerificationMeta('cachedAt');
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
      'cached_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        overview,
        posterPath,
        backdropPath,
        voteAverage,
        voteCount,
        releaseDate,
        adult,
        originalLanguage,
        popularity,
        genreIds,
        category,
        cachedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_movies';
  @override
  VerificationContext validateIntegrity(Insertable<CachedMovy> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('overview')) {
      context.handle(_overviewMeta,
          overview.isAcceptableOrUnknown(data['overview']!, _overviewMeta));
    } else if (isInserting) {
      context.missing(_overviewMeta);
    }
    if (data.containsKey('poster_path')) {
      context.handle(
          _posterPathMeta,
          posterPath.isAcceptableOrUnknown(
              data['poster_path']!, _posterPathMeta));
    }
    if (data.containsKey('backdrop_path')) {
      context.handle(
          _backdropPathMeta,
          backdropPath.isAcceptableOrUnknown(
              data['backdrop_path']!, _backdropPathMeta));
    }
    if (data.containsKey('vote_average')) {
      context.handle(
          _voteAverageMeta,
          voteAverage.isAcceptableOrUnknown(
              data['vote_average']!, _voteAverageMeta));
    } else if (isInserting) {
      context.missing(_voteAverageMeta);
    }
    if (data.containsKey('vote_count')) {
      context.handle(_voteCountMeta,
          voteCount.isAcceptableOrUnknown(data['vote_count']!, _voteCountMeta));
    } else if (isInserting) {
      context.missing(_voteCountMeta);
    }
    if (data.containsKey('release_date')) {
      context.handle(
          _releaseDateMeta,
          releaseDate.isAcceptableOrUnknown(
              data['release_date']!, _releaseDateMeta));
    } else if (isInserting) {
      context.missing(_releaseDateMeta);
    }
    if (data.containsKey('adult')) {
      context.handle(
          _adultMeta, adult.isAcceptableOrUnknown(data['adult']!, _adultMeta));
    } else if (isInserting) {
      context.missing(_adultMeta);
    }
    if (data.containsKey('original_language')) {
      context.handle(
          _originalLanguageMeta,
          originalLanguage.isAcceptableOrUnknown(
              data['original_language']!, _originalLanguageMeta));
    } else if (isInserting) {
      context.missing(_originalLanguageMeta);
    }
    if (data.containsKey('popularity')) {
      context.handle(
          _popularityMeta,
          popularity.isAcceptableOrUnknown(
              data['popularity']!, _popularityMeta));
    } else if (isInserting) {
      context.missing(_popularityMeta);
    }
    if (data.containsKey('genre_ids')) {
      context.handle(_genreIdsMeta,
          genreIds.isAcceptableOrUnknown(data['genre_ids']!, _genreIdsMeta));
    } else if (isInserting) {
      context.missing(_genreIdsMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('cached_at')) {
      context.handle(_cachedAtMeta,
          cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta));
    } else if (isInserting) {
      context.missing(_cachedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CachedMovy map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedMovy(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      overview: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}overview'])!,
      posterPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}poster_path']),
      backdropPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}backdrop_path']),
      voteAverage: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}vote_average'])!,
      voteCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}vote_count'])!,
      releaseDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}release_date'])!,
      adult: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}adult'])!,
      originalLanguage: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}original_language'])!,
      popularity: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}popularity'])!,
      genreIds: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}genre_ids'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      cachedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}cached_at'])!,
    );
  }

  @override
  $CachedMoviesTable createAlias(String alias) {
    return $CachedMoviesTable(attachedDatabase, alias);
  }
}

class CachedMovy extends DataClass implements Insertable<CachedMovy> {
  final int id;
  final String title;
  final String overview;
  final String? posterPath;
  final String? backdropPath;
  final double voteAverage;
  final int voteCount;
  final String releaseDate;
  final bool adult;
  final String originalLanguage;
  final double popularity;
  final String genreIds;
  final String category;
  final DateTime cachedAt;
  const CachedMovy(
      {required this.id,
      required this.title,
      required this.overview,
      this.posterPath,
      this.backdropPath,
      required this.voteAverage,
      required this.voteCount,
      required this.releaseDate,
      required this.adult,
      required this.originalLanguage,
      required this.popularity,
      required this.genreIds,
      required this.category,
      required this.cachedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['overview'] = Variable<String>(overview);
    if (!nullToAbsent || posterPath != null) {
      map['poster_path'] = Variable<String>(posterPath);
    }
    if (!nullToAbsent || backdropPath != null) {
      map['backdrop_path'] = Variable<String>(backdropPath);
    }
    map['vote_average'] = Variable<double>(voteAverage);
    map['vote_count'] = Variable<int>(voteCount);
    map['release_date'] = Variable<String>(releaseDate);
    map['adult'] = Variable<bool>(adult);
    map['original_language'] = Variable<String>(originalLanguage);
    map['popularity'] = Variable<double>(popularity);
    map['genre_ids'] = Variable<String>(genreIds);
    map['category'] = Variable<String>(category);
    map['cached_at'] = Variable<DateTime>(cachedAt);
    return map;
  }

  CachedMoviesCompanion toCompanion(bool nullToAbsent) {
    return CachedMoviesCompanion(
      id: Value(id),
      title: Value(title),
      overview: Value(overview),
      posterPath: posterPath == null && nullToAbsent
          ? const Value.absent()
          : Value(posterPath),
      backdropPath: backdropPath == null && nullToAbsent
          ? const Value.absent()
          : Value(backdropPath),
      voteAverage: Value(voteAverage),
      voteCount: Value(voteCount),
      releaseDate: Value(releaseDate),
      adult: Value(adult),
      originalLanguage: Value(originalLanguage),
      popularity: Value(popularity),
      genreIds: Value(genreIds),
      category: Value(category),
      cachedAt: Value(cachedAt),
    );
  }

  factory CachedMovy.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedMovy(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      overview: serializer.fromJson<String>(json['overview']),
      posterPath: serializer.fromJson<String?>(json['posterPath']),
      backdropPath: serializer.fromJson<String?>(json['backdropPath']),
      voteAverage: serializer.fromJson<double>(json['voteAverage']),
      voteCount: serializer.fromJson<int>(json['voteCount']),
      releaseDate: serializer.fromJson<String>(json['releaseDate']),
      adult: serializer.fromJson<bool>(json['adult']),
      originalLanguage: serializer.fromJson<String>(json['originalLanguage']),
      popularity: serializer.fromJson<double>(json['popularity']),
      genreIds: serializer.fromJson<String>(json['genreIds']),
      category: serializer.fromJson<String>(json['category']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'overview': serializer.toJson<String>(overview),
      'posterPath': serializer.toJson<String?>(posterPath),
      'backdropPath': serializer.toJson<String?>(backdropPath),
      'voteAverage': serializer.toJson<double>(voteAverage),
      'voteCount': serializer.toJson<int>(voteCount),
      'releaseDate': serializer.toJson<String>(releaseDate),
      'adult': serializer.toJson<bool>(adult),
      'originalLanguage': serializer.toJson<String>(originalLanguage),
      'popularity': serializer.toJson<double>(popularity),
      'genreIds': serializer.toJson<String>(genreIds),
      'category': serializer.toJson<String>(category),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
    };
  }

  CachedMovy copyWith(
          {int? id,
          String? title,
          String? overview,
          Value<String?> posterPath = const Value.absent(),
          Value<String?> backdropPath = const Value.absent(),
          double? voteAverage,
          int? voteCount,
          String? releaseDate,
          bool? adult,
          String? originalLanguage,
          double? popularity,
          String? genreIds,
          String? category,
          DateTime? cachedAt}) =>
      CachedMovy(
        id: id ?? this.id,
        title: title ?? this.title,
        overview: overview ?? this.overview,
        posterPath: posterPath.present ? posterPath.value : this.posterPath,
        backdropPath:
            backdropPath.present ? backdropPath.value : this.backdropPath,
        voteAverage: voteAverage ?? this.voteAverage,
        voteCount: voteCount ?? this.voteCount,
        releaseDate: releaseDate ?? this.releaseDate,
        adult: adult ?? this.adult,
        originalLanguage: originalLanguage ?? this.originalLanguage,
        popularity: popularity ?? this.popularity,
        genreIds: genreIds ?? this.genreIds,
        category: category ?? this.category,
        cachedAt: cachedAt ?? this.cachedAt,
      );
  CachedMovy copyWithCompanion(CachedMoviesCompanion data) {
    return CachedMovy(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      overview: data.overview.present ? data.overview.value : this.overview,
      posterPath:
          data.posterPath.present ? data.posterPath.value : this.posterPath,
      backdropPath: data.backdropPath.present
          ? data.backdropPath.value
          : this.backdropPath,
      voteAverage:
          data.voteAverage.present ? data.voteAverage.value : this.voteAverage,
      voteCount: data.voteCount.present ? data.voteCount.value : this.voteCount,
      releaseDate:
          data.releaseDate.present ? data.releaseDate.value : this.releaseDate,
      adult: data.adult.present ? data.adult.value : this.adult,
      originalLanguage: data.originalLanguage.present
          ? data.originalLanguage.value
          : this.originalLanguage,
      popularity:
          data.popularity.present ? data.popularity.value : this.popularity,
      genreIds: data.genreIds.present ? data.genreIds.value : this.genreIds,
      category: data.category.present ? data.category.value : this.category,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedMovy(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('overview: $overview, ')
          ..write('posterPath: $posterPath, ')
          ..write('backdropPath: $backdropPath, ')
          ..write('voteAverage: $voteAverage, ')
          ..write('voteCount: $voteCount, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('adult: $adult, ')
          ..write('originalLanguage: $originalLanguage, ')
          ..write('popularity: $popularity, ')
          ..write('genreIds: $genreIds, ')
          ..write('category: $category, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      title,
      overview,
      posterPath,
      backdropPath,
      voteAverage,
      voteCount,
      releaseDate,
      adult,
      originalLanguage,
      popularity,
      genreIds,
      category,
      cachedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedMovy &&
          other.id == this.id &&
          other.title == this.title &&
          other.overview == this.overview &&
          other.posterPath == this.posterPath &&
          other.backdropPath == this.backdropPath &&
          other.voteAverage == this.voteAverage &&
          other.voteCount == this.voteCount &&
          other.releaseDate == this.releaseDate &&
          other.adult == this.adult &&
          other.originalLanguage == this.originalLanguage &&
          other.popularity == this.popularity &&
          other.genreIds == this.genreIds &&
          other.category == this.category &&
          other.cachedAt == this.cachedAt);
}

class CachedMoviesCompanion extends UpdateCompanion<CachedMovy> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> overview;
  final Value<String?> posterPath;
  final Value<String?> backdropPath;
  final Value<double> voteAverage;
  final Value<int> voteCount;
  final Value<String> releaseDate;
  final Value<bool> adult;
  final Value<String> originalLanguage;
  final Value<double> popularity;
  final Value<String> genreIds;
  final Value<String> category;
  final Value<DateTime> cachedAt;
  const CachedMoviesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.overview = const Value.absent(),
    this.posterPath = const Value.absent(),
    this.backdropPath = const Value.absent(),
    this.voteAverage = const Value.absent(),
    this.voteCount = const Value.absent(),
    this.releaseDate = const Value.absent(),
    this.adult = const Value.absent(),
    this.originalLanguage = const Value.absent(),
    this.popularity = const Value.absent(),
    this.genreIds = const Value.absent(),
    this.category = const Value.absent(),
    this.cachedAt = const Value.absent(),
  });
  CachedMoviesCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String overview,
    this.posterPath = const Value.absent(),
    this.backdropPath = const Value.absent(),
    required double voteAverage,
    required int voteCount,
    required String releaseDate,
    required bool adult,
    required String originalLanguage,
    required double popularity,
    required String genreIds,
    required String category,
    required DateTime cachedAt,
  })  : title = Value(title),
        overview = Value(overview),
        voteAverage = Value(voteAverage),
        voteCount = Value(voteCount),
        releaseDate = Value(releaseDate),
        adult = Value(adult),
        originalLanguage = Value(originalLanguage),
        popularity = Value(popularity),
        genreIds = Value(genreIds),
        category = Value(category),
        cachedAt = Value(cachedAt);
  static Insertable<CachedMovy> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? overview,
    Expression<String>? posterPath,
    Expression<String>? backdropPath,
    Expression<double>? voteAverage,
    Expression<int>? voteCount,
    Expression<String>? releaseDate,
    Expression<bool>? adult,
    Expression<String>? originalLanguage,
    Expression<double>? popularity,
    Expression<String>? genreIds,
    Expression<String>? category,
    Expression<DateTime>? cachedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (overview != null) 'overview': overview,
      if (posterPath != null) 'poster_path': posterPath,
      if (backdropPath != null) 'backdrop_path': backdropPath,
      if (voteAverage != null) 'vote_average': voteAverage,
      if (voteCount != null) 'vote_count': voteCount,
      if (releaseDate != null) 'release_date': releaseDate,
      if (adult != null) 'adult': adult,
      if (originalLanguage != null) 'original_language': originalLanguage,
      if (popularity != null) 'popularity': popularity,
      if (genreIds != null) 'genre_ids': genreIds,
      if (category != null) 'category': category,
      if (cachedAt != null) 'cached_at': cachedAt,
    });
  }

  CachedMoviesCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? overview,
      Value<String?>? posterPath,
      Value<String?>? backdropPath,
      Value<double>? voteAverage,
      Value<int>? voteCount,
      Value<String>? releaseDate,
      Value<bool>? adult,
      Value<String>? originalLanguage,
      Value<double>? popularity,
      Value<String>? genreIds,
      Value<String>? category,
      Value<DateTime>? cachedAt}) {
    return CachedMoviesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      overview: overview ?? this.overview,
      posterPath: posterPath ?? this.posterPath,
      backdropPath: backdropPath ?? this.backdropPath,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
      releaseDate: releaseDate ?? this.releaseDate,
      adult: adult ?? this.adult,
      originalLanguage: originalLanguage ?? this.originalLanguage,
      popularity: popularity ?? this.popularity,
      genreIds: genreIds ?? this.genreIds,
      category: category ?? this.category,
      cachedAt: cachedAt ?? this.cachedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (overview.present) {
      map['overview'] = Variable<String>(overview.value);
    }
    if (posterPath.present) {
      map['poster_path'] = Variable<String>(posterPath.value);
    }
    if (backdropPath.present) {
      map['backdrop_path'] = Variable<String>(backdropPath.value);
    }
    if (voteAverage.present) {
      map['vote_average'] = Variable<double>(voteAverage.value);
    }
    if (voteCount.present) {
      map['vote_count'] = Variable<int>(voteCount.value);
    }
    if (releaseDate.present) {
      map['release_date'] = Variable<String>(releaseDate.value);
    }
    if (adult.present) {
      map['adult'] = Variable<bool>(adult.value);
    }
    if (originalLanguage.present) {
      map['original_language'] = Variable<String>(originalLanguage.value);
    }
    if (popularity.present) {
      map['popularity'] = Variable<double>(popularity.value);
    }
    if (genreIds.present) {
      map['genre_ids'] = Variable<String>(genreIds.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedMoviesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('overview: $overview, ')
          ..write('posterPath: $posterPath, ')
          ..write('backdropPath: $backdropPath, ')
          ..write('voteAverage: $voteAverage, ')
          ..write('voteCount: $voteCount, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('adult: $adult, ')
          ..write('originalLanguage: $originalLanguage, ')
          ..write('popularity: $popularity, ')
          ..write('genreIds: $genreIds, ')
          ..write('category: $category, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CachedMoviesTable cachedMovies = $CachedMoviesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [cachedMovies];
}

typedef $$CachedMoviesTableCreateCompanionBuilder = CachedMoviesCompanion
    Function({
  Value<int> id,
  required String title,
  required String overview,
  Value<String?> posterPath,
  Value<String?> backdropPath,
  required double voteAverage,
  required int voteCount,
  required String releaseDate,
  required bool adult,
  required String originalLanguage,
  required double popularity,
  required String genreIds,
  required String category,
  required DateTime cachedAt,
});
typedef $$CachedMoviesTableUpdateCompanionBuilder = CachedMoviesCompanion
    Function({
  Value<int> id,
  Value<String> title,
  Value<String> overview,
  Value<String?> posterPath,
  Value<String?> backdropPath,
  Value<double> voteAverage,
  Value<int> voteCount,
  Value<String> releaseDate,
  Value<bool> adult,
  Value<String> originalLanguage,
  Value<double> popularity,
  Value<String> genreIds,
  Value<String> category,
  Value<DateTime> cachedAt,
});

class $$CachedMoviesTableFilterComposer
    extends Composer<_$AppDatabase, $CachedMoviesTable> {
  $$CachedMoviesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get overview => $composableBuilder(
      column: $table.overview, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get posterPath => $composableBuilder(
      column: $table.posterPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get backdropPath => $composableBuilder(
      column: $table.backdropPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get voteAverage => $composableBuilder(
      column: $table.voteAverage, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get voteCount => $composableBuilder(
      column: $table.voteCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get releaseDate => $composableBuilder(
      column: $table.releaseDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get adult => $composableBuilder(
      column: $table.adult, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get originalLanguage => $composableBuilder(
      column: $table.originalLanguage,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get popularity => $composableBuilder(
      column: $table.popularity, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get genreIds => $composableBuilder(
      column: $table.genreIds, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
      column: $table.cachedAt, builder: (column) => ColumnFilters(column));
}

class $$CachedMoviesTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedMoviesTable> {
  $$CachedMoviesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get overview => $composableBuilder(
      column: $table.overview, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get posterPath => $composableBuilder(
      column: $table.posterPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get backdropPath => $composableBuilder(
      column: $table.backdropPath,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get voteAverage => $composableBuilder(
      column: $table.voteAverage, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get voteCount => $composableBuilder(
      column: $table.voteCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get releaseDate => $composableBuilder(
      column: $table.releaseDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get adult => $composableBuilder(
      column: $table.adult, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get originalLanguage => $composableBuilder(
      column: $table.originalLanguage,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get popularity => $composableBuilder(
      column: $table.popularity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get genreIds => $composableBuilder(
      column: $table.genreIds, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
      column: $table.cachedAt, builder: (column) => ColumnOrderings(column));
}

class $$CachedMoviesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedMoviesTable> {
  $$CachedMoviesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get overview =>
      $composableBuilder(column: $table.overview, builder: (column) => column);

  GeneratedColumn<String> get posterPath => $composableBuilder(
      column: $table.posterPath, builder: (column) => column);

  GeneratedColumn<String> get backdropPath => $composableBuilder(
      column: $table.backdropPath, builder: (column) => column);

  GeneratedColumn<double> get voteAverage => $composableBuilder(
      column: $table.voteAverage, builder: (column) => column);

  GeneratedColumn<int> get voteCount =>
      $composableBuilder(column: $table.voteCount, builder: (column) => column);

  GeneratedColumn<String> get releaseDate => $composableBuilder(
      column: $table.releaseDate, builder: (column) => column);

  GeneratedColumn<bool> get adult =>
      $composableBuilder(column: $table.adult, builder: (column) => column);

  GeneratedColumn<String> get originalLanguage => $composableBuilder(
      column: $table.originalLanguage, builder: (column) => column);

  GeneratedColumn<double> get popularity => $composableBuilder(
      column: $table.popularity, builder: (column) => column);

  GeneratedColumn<String> get genreIds =>
      $composableBuilder(column: $table.genreIds, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);
}

class $$CachedMoviesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CachedMoviesTable,
    CachedMovy,
    $$CachedMoviesTableFilterComposer,
    $$CachedMoviesTableOrderingComposer,
    $$CachedMoviesTableAnnotationComposer,
    $$CachedMoviesTableCreateCompanionBuilder,
    $$CachedMoviesTableUpdateCompanionBuilder,
    (CachedMovy, BaseReferences<_$AppDatabase, $CachedMoviesTable, CachedMovy>),
    CachedMovy,
    PrefetchHooks Function()> {
  $$CachedMoviesTableTableManager(_$AppDatabase db, $CachedMoviesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedMoviesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedMoviesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedMoviesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> overview = const Value.absent(),
            Value<String?> posterPath = const Value.absent(),
            Value<String?> backdropPath = const Value.absent(),
            Value<double> voteAverage = const Value.absent(),
            Value<int> voteCount = const Value.absent(),
            Value<String> releaseDate = const Value.absent(),
            Value<bool> adult = const Value.absent(),
            Value<String> originalLanguage = const Value.absent(),
            Value<double> popularity = const Value.absent(),
            Value<String> genreIds = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<DateTime> cachedAt = const Value.absent(),
          }) =>
              CachedMoviesCompanion(
            id: id,
            title: title,
            overview: overview,
            posterPath: posterPath,
            backdropPath: backdropPath,
            voteAverage: voteAverage,
            voteCount: voteCount,
            releaseDate: releaseDate,
            adult: adult,
            originalLanguage: originalLanguage,
            popularity: popularity,
            genreIds: genreIds,
            category: category,
            cachedAt: cachedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String title,
            required String overview,
            Value<String?> posterPath = const Value.absent(),
            Value<String?> backdropPath = const Value.absent(),
            required double voteAverage,
            required int voteCount,
            required String releaseDate,
            required bool adult,
            required String originalLanguage,
            required double popularity,
            required String genreIds,
            required String category,
            required DateTime cachedAt,
          }) =>
              CachedMoviesCompanion.insert(
            id: id,
            title: title,
            overview: overview,
            posterPath: posterPath,
            backdropPath: backdropPath,
            voteAverage: voteAverage,
            voteCount: voteCount,
            releaseDate: releaseDate,
            adult: adult,
            originalLanguage: originalLanguage,
            popularity: popularity,
            genreIds: genreIds,
            category: category,
            cachedAt: cachedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CachedMoviesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CachedMoviesTable,
    CachedMovy,
    $$CachedMoviesTableFilterComposer,
    $$CachedMoviesTableOrderingComposer,
    $$CachedMoviesTableAnnotationComposer,
    $$CachedMoviesTableCreateCompanionBuilder,
    $$CachedMoviesTableUpdateCompanionBuilder,
    (CachedMovy, BaseReferences<_$AppDatabase, $CachedMoviesTable, CachedMovy>),
    CachedMovy,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CachedMoviesTableTableManager get cachedMovies =>
      $$CachedMoviesTableTableManager(_db, _db.cachedMovies);
}
