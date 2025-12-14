import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'cached_movies_table.dart';

part 'app_database.g.dart';

/// Main database class using Drift
@singleton
@DriftDatabase(tables: [CachedMovies])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  /// Get all cached movies for a specific category
  Future<List<CachedMovy>> getCachedMoviesByCategory(String category) {
    return (select(cachedMovies)
          ..where((tbl) => tbl.category.equals(category))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.cachedAt)]))
        .get();
  }

  /// Cache a movie
  Future<int> cacheMovie(CachedMoviesCompanion movie) {
    return into(cachedMovies).insert(
      movie,
      mode: InsertMode.replace,
    );
  }

  /// Cache multiple movies
  Future<void> cacheMovies(List<CachedMoviesCompanion> movies) async {
    await batch((batch) {
      batch.insertAll(
        cachedMovies,
        movies,
        mode: InsertMode.replace,
      );
    });
  }

  /// Delete cached movies older than specified duration
  Future<int> deleteCachedMoviesOlderThan(Duration duration) {
    final cutoffDate = DateTime.now().subtract(duration);
    return (delete(cachedMovies)
          ..where((tbl) => tbl.cachedAt.isSmallerThanValue(cutoffDate)))
        .go();
  }

  /// Clear all cached movies for a category
  Future<int> clearCategoryCache(String category) {
    return (delete(cachedMovies)..where((tbl) => tbl.category.equals(category)))
        .go();
  }

  /// Check if cache is fresh (less than 1 hour old)
  Future<bool> isCacheFresh(String category) async {
    final oneHourAgo = DateTime.now().subtract(const Duration(hours: 1));
    final count = await (select(cachedMovies)
          ..where((tbl) =>
              tbl.category.equals(category) &
              tbl.cachedAt.isBiggerThanValue(oneHourAgo)))
        .get()
        .then((movies) => movies.length);
    return count > 0;
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'movie_discovery.db'));
    return NativeDatabase(file);
  });
}
