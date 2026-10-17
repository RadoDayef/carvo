class CarModel {
  String uid, brand, model, image, ownerUid, description;

  CarModel({required this.uid, required this.brand, required this.model, required this.image, required this.ownerUid, required this.description});

  Map<String, dynamic> toJson() {
    return {"uid": uid, "brand": brand, "model": model, "image": image, "ownerUid": ownerUid, "description": description};
  }

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(uid: json["uid"], brand: json["brand"], model: json["model"], image: json["image"], ownerUid: json["ownerUid"], description: json["description"]);
  }
}
