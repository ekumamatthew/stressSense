class CommentData {
  final String title;
  final String body;
  final DateTime timestamp;

  CommentData({
    required this.title,
    required this.body,
    required this.timestamp,
  });

  factory CommentData.fromJson(Map<String, dynamic> json) {
    return CommentData(
      title: json['message'] as String? ?? 'Default comment',
      body: json['name'] as String? ?? 'Supervisor name',
      timestamp: json.containsKey('createdAt')
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
