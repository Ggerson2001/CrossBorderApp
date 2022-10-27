class ModelUser {
  final String uuid;
  String email;
  String password;
  String name;
  String major;
  String imageUrl;

  ModelUser({
    this.uuid,
    this.email,
    this.imageUrl,
    this.major,
    this.name,
    this.password,
  });

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "email": email,
        "password": password,
        "name": name,
        "imageUrl": imageUrl,
      };

  factory ModelUser.fromJson(Map<String, dynamic> json) {
    return ModelUser(
      email: json["email"],
      imageUrl: json["imageUrl"],
      major: json["major"],
      name: json["name"],
      password: json["password"],
      uuid: json["uuid"],
    );
  }
}
