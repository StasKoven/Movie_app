import 'package:equatable/equatable.dart';

class VideoModel extends Equatable {
  final String id;
  final String key;
  final String name;
  final String site;
  final int size;
  final String type;

  const VideoModel({
    required this.id,
    required this.key,
    required this.name,
    required this.site,
    required this.size,
    required this.type,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['id'] ?? '',
      key: json['key'] ?? '',
      name: json['name'] ?? '',
      site: json['site'] ?? '',
      size: json['size'] ?? 0,
      type: json['type'] ?? '',
    );
  }

  String get youtubeUrl => 'https://www.youtube.com/watch?v=$key';
  String get youtubeThumbnail => 'https://img.youtube.com/vi/$key/maxresdefault.jpg';

  @override
  List<Object?> get props => [id, key, name, site, size, type];
}

class VideoListResponse extends Equatable {
  final int id;
  final List<VideoModel> results;

  const VideoListResponse({
    required this.id,
    required this.results,
  });

  factory VideoListResponse.fromJson(Map<String, dynamic> json) {
    return VideoListResponse(
      id: json['id'] ?? 0,
      results: (json['results'] as List?)
              ?.map((video) => VideoModel.fromJson(video))
              .toList() ??
          [],
    );
  }

  @override
  List<Object?> get props => [id, results];
}
