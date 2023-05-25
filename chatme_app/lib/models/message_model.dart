part of 'objects.dart';

@JsonSerializable()
class MessageModel {
  MessageModel(
    this.conId,
    this.senderName,
    this.senderId,
    this.reciveId,
    this.message,
    this.messageTime,
    this.messageType,
    this.messageId,
  );
  String messageId;
  String conId;
  String senderName;
  String senderId;
  String reciveId;
  String message;
  String messageTime;
  String messageType;

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);

  //-------this named constructor will bind json data to our model
  // MessageModel.fromJason(Map<String, dynamic> json)
  //     : conId = json['conId'],
  //       senderName = json['senderName'],
  //       senderId = json['senderId'],
  //       reciveId = json['reciveId'],
  //       message = json['message'],
  //       messageTime = json['messageTime'],
  //       messageType = json['messageType'];
}
