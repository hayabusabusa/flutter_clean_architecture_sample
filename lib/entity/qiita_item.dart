import 'package:clean_architecture_sample/entity/entity.dart';
import 'package:equatable/equatable.dart';

import './user.dart';

class QiitaItem extends Equatable {
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

  @override
  List<Object> get props => [
    title,
    body,
    likes,
    user,
  ];

  static QiitaItem fromJson(Map<String, dynamic> json) {
    return QiitaItem(
      title: json['title'],
      body: json['body'],
      likes: json['likes_count'],
      user: User.fromJson(json['user']),
    );
  }

  static QiitaItem stub() {
    return QiitaItem(
      title: 'TITLE, AND TITLE OR TITLE',
      body: 'This is body. Multiple line content.\nNext line is here.\nAnd more.',
      likes: 240,
      user: User(name: 'USER', profileImageURL: ''),
    );
  }
}