class ResumeModel {
  final String id;
  final String userId;
  final String fileUrl;
  final DateTime? createdAt;

  ResumeModel({
    required this.id,
    required this.userId,
    required this.fileUrl,
    this.createdAt,
  });

  factory ResumeModel.fromJson(Map<String, dynamic> json) {
    return ResumeModel(
      id: json['id'],
      userId: json['user_id'],
      fileUrl: json['file_url'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }
}
