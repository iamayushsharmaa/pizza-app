
class PostData{
  final int userId;
  final int id;
  final String title;
  final String body;

  PostData({required this.userId, required this.id, required this.title, required this.body});

  factory PostData.fromJson(Map<String, dynamic> json) => PostData(
    userId: json["userId"],
    id: json["id"],
    title: json["title"],
    body: json["body"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "id": id,
    "title": title,
    "body": body,
  };
}f