import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/video_model.dart';
import '../../data/repositories/movie_repository_impl.dart';

@lazySingleton
class GetMovieVideos implements UseCase<VideoListResponse, int> {
  final MovieRepository repository;

  GetMovieVideos(this.repository);

  @override
  Future<Either<Failure, VideoListResponse>> call(int movieId) async {
    return await repository.getMovieVideos(movieId);
  }
}
