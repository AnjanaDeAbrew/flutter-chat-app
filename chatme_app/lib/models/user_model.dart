part of 'objects.dart';

@JsonSerializable()
class UserModel {
  String uid;
  String email;
  String name;
  String img;
  String lastSeen;
  bool isOnline;
  String token;

  UserModel(this.uid, this.email, this.name, this.img, this.lastSeen,
      this.isOnline, this.token);

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  //-------this named constructor will bind json data to our model
  // UserModel.fromJason(Map<String, dynamic> json)
  //     : uid = json['uid'],
  //       name = json['name'],
  //       email = json['email'],
  //       img = json['img'],
  //       lastSeen = json['lastSeen'],
  //       isOnline = json['isOnline'],
  //       token = json['token'];

  // Map<String, dynamic> toJson() => {
  //       'uid': uid,
  //       'name': name,
  //       'email': email,
  //       'img': img,
  //       'lastSeen': lastSeen,
  //       'isOnline': isOnline,
  //       'token': token,
  //     };
}
