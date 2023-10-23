class CommentModel {
  final String id;
  final String comment;
  final String postId;
  final String userId;
  final String typeJobs;
  final DateTime createdAt;
  final DateTime updatedAt;

  CommentModel({
    required this.id,
    required this.comment,
    required this.postId,
    required this.userId,
    required this.typeJobs,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      comment: json['comment'],
      postId: json['post_id'],
      userId: json['user_id'],
      typeJobs: json['type_jobs'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
