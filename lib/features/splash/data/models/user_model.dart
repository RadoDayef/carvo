class UserModel {
  String uid, image, email, lastName, firstName;

  UserModel({required this.uid, required this.image, required this.email, required this.lastName, required this.firstName});

  Map<String, dynamic> toJson() {
    return {"uid": uid, "image": image, "email": email, "lastName": lastName, "firstName": firstName};
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json["uid"],
      email: json["email"],
      lastName: json["lastName"],
      firstName: json["firstName"],
      image: json["image"] ?? "https://cdn-icons-png.flaticon.com/512/9187/9187604.png",
    );
  }
}
