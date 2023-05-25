part of 'objects.dart';

@JsonSerializable(explicitToJson: true)
class ConversationModel {
  ConversationModel(
    this.id,
    this.users,
    this.usersArray,
    this.lastMessage,
    this.lastMessageTime,
    this.createdBy,
    this.messageType,
  );
  String id;
  List<String> users;
  List<UserModel> usersArray;
  String lastMessage;
  String lastMessageTime;
  String createdBy;
  String messageType;

  factory ConversationModel.fromJson(Map<String, dynamic> json) =>
      _$ConversationModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationModelToJson(this);

  //-------this named constructor will bind json data to our model
  // ConversationModel.fromJason(Map<String, dynamic> json)
  //     : id = json['id'],
  //       users =
  //           (json['users'] as List<dynamic>).map((e) => e as String).toList(),
  //       usersArray = (json['usersArray'] as List<dynamic>)
  //           .map((e) => UserModel.fromJason(e as Map<String, dynamic>))
  //           .toList(),
  //       lastMessage = json['lastMessage'],
  //       lastMessageTime = json['lastMessageTime'],
  //       createdBy = json['createdBy'],
  //       messageType = json['messageType'];
}
