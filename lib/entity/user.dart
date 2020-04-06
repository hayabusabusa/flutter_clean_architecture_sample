import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String name;
  final String profileImageURL;

  User({
    this.name,
    this.profileImageURL
  });

  @override
  List<Object> get props => [
    name,
    profileImageURL,
  ];

  static User fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      profileImageURL: json['profile_image_url'],
    );
  }
}