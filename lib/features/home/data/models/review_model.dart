import 'package:equatable/equatable.dart';

class ReviewModel extends Equatable {
  final String id;
  final String author;
  final String content;
  final String createdAt;
  final String url;
  final AuthorDetails authorDetails;

  const ReviewModel({
    required this.id,
    required this.author,
    required this.content,
    required this.createdAt,
    required this.url,
    required this.authorDetails,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] ?? '',
      author: json['author'] ?? '',
      content: json['content'] ?? '',
      createdAt: json['created_at'] ?? '',
      url: json['url'] ?? '',
      authorDetails: AuthorDetails.fromJson(json['author_details'] ?? {}),
    );
  }

  @override
  List<Object?> get props => [id, author, content, createdAt, url, authorDetails];
}

class AuthorDetails extends Equatable {
  final String name;
  final String username;
  final String? avatarPath;
  final double? rating;

  const AuthorDetails({
    required this.name,
    required this.username,
    this.avatarPath,
    this.rating,
  });

  factory AuthorDetails.fromJson(Map<String, dynamic> json) {
    return AuthorDetails(
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      avatarPath: json['avatar_path'],
      rating: json['rating']?.toDouble(),
    );
  }

  @override
  List<Object?> get props => [name, username, avatarPath, rating];
}

class ReviewListResponse extends Equatable {
  final int id;
  final int page;
  final List<ReviewModel> results;
  final int totalPages;
  final int totalResults;

  const ReviewListResponse({
    required this.id,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory ReviewListResponse.fromJson(Map<String, dynamic> json) {
    return ReviewListResponse(
      id: json['id'] ?? 0,
      page: json['page'] ?? 1,
      results: (json['results'] as List?)
              ?.map((review) => ReviewModel.fromJson(review))
              .toList() ??
          [],
      totalPages: json['total_pages'] ?? 0,
      totalResults: json['total_results'] ?? 0,
    );
  }

  @override
  List<Object?> get props => [id, page, results, totalPages, totalResults];
}
