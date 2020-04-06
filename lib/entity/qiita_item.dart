import './user.dart';

class QiitaItem {
  final String title;
  final String body;
  final int likes;
  final User user;

  QiitaItem({
    this.title,
    this.body,
    this.likes,
    this.user
  });

  static QiitaItem fromJson(Map<String, dynamic> json) {
    return QiitaItem(
      title: json['title'],
      body: json['body'],
      likes: json['likes_count'],
      user: User.fromJson(json['user']),
    );
  }
}