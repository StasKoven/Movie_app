import 'package:drift/drift.dart';

/// Table for caching movie data from API
class CachedMovies extends Table {
  IntColumn get id => integer()();
  TextColumn get title => text()();
  TextColumn get overview => text()();
  TextColumn get posterPath => text().nullable()();
  TextColumn get backdropPath => text().nullable()();
  RealColumn get voteAverage => real()();
  IntColumn get voteCount => integer()();
  TextColumn get releaseDate => text()();
  BoolColumn get adult => boolean()();
  TextColumn get originalLanguage => text()();
  RealColumn get popularity => real()();
  TextColumn get genreIds => text()(); // JSON string array
  TextColumn get category => text()(); // 'popular', 'top_rated', 'upcoming'
  DateTimeColumn get cachedAt => dateTime()();
  
  @override
  Set<Column> get primaryKey => {id};
}
