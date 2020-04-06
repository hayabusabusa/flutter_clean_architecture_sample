class User {
  final String name;
  final String profileImageURL;

  User({
    this.name,
    this.profileImageURL
  });

  static User fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      profileImageURL: json['profile_image_url'],
    );
  }
}