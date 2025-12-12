import 'package:hive/hive.dart';

part 'favorite_movie.g.dart';

@HiveType(typeId: 0)
class FavoriteMovie extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String? posterPath;

  @HiveField(3)
  final double voteAverage;

  @HiveField(4)
  final String releaseDate;

  @HiveField(5)
  final DateTime addedAt;

  FavoriteMovie({
    required this.id,
    required this.title,
    this.posterPath,
    required this.voteAverage,
    required this.releaseDate,
    required this.addedAt,
  });

  String get posterUrl => posterPath != null
      ? 'https://image.tmdb.org/t/p/w500$posterPath'
      : '';
}
