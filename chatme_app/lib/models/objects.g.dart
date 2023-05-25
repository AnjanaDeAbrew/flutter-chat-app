// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'objects.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConversationModel _$ConversationModelFromJson(Map<String, dynamic> json) =>
    ConversationModel(
      json['id'] as String,
      (json['users'] as List<dynamic>).map((e) => e as String).toList(),
      (json['usersArray'] as List<dynamic>)
          .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['lastMessage'] as String,
      json['lastMessageTime'] as String,
      json['createdBy'] as String,
      json['messageType'] as String,
    );

Map<String, dynamic> _$ConversationModelToJson(ConversationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'users': instance.users,
      'usersArray': instance.usersArray.map((e) => e.toJson()).toList(),
      'lastMessage': instance.lastMessage,
      'lastMessageTime': instance.lastMessageTime,
      'createdBy': instance.createdBy,
      'messageType': instance.messageType,
    };

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) => MessageModel(
      json['conId'] as String,
      json['senderName'] as String,
      json['senderId'] as String,
      json['reciveId'] as String,
      json['message'] as String,
      json['messageTime'] as String,
      json['messageType'] as String,
      json['messageId'] as String,
    );

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      'messageId': instance.messageId,
      'conId': instance.conId,
      'senderName': instance.senderName,
      'senderId': instance.senderId,
      'reciveId': instance.reciveId,
      'message': instance.message,
      'messageTime': instance.messageTime,
      'messageType': instance.messageType,
    };

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      json['uid'] as String,
      json['email'] as String,
      json['name'] as String,
      json['img'] as String,
      json['lastSeen'] as String,
      json['isOnline'] as bool,
      json['token'] as String,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'name': instance.name,
      'img': instance.img,
      'lastSeen': instance.lastSeen,
      'isOnline': instance.isOnline,
      'token': instance.token,
    };
