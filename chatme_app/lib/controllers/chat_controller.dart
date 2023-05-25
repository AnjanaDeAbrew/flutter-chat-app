import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dude/controllers/file_upload_controller.dart';
import 'package:dude/models/objects.dart';
import 'package:logger/logger.dart';

class ChatController {
  // Create a CollectionReference called conversations that references the firestore collection
  CollectionReference conversations =
      FirebaseFirestore.instance.collection('conversations');

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  //-create object from file upload class
  final FileUploadController _fileUploadController = FileUploadController();

  //----------retreive conversation stream
  Stream<QuerySnapshot> getUsers(String currentUserId) =>
      users.where('uid', isNotEqualTo: currentUserId).snapshots();

  // //----create converstaion in firestore
  Future<ConversationModel> createConersation(
      UserModel me, UserModel peeruser) async {
    //-check conversation exists
    ConversationModel? model = await checkConvExist(me.uid, peeruser.uid);

    if (model == null) {
      String docId = conversations.doc().id;

      await conversations
          .doc(docId)
          .set(
            {
              'id': docId,
              'users': [me.uid, peeruser.uid],
              'usersArray': [
                me.toJson(),
                peeruser.toJson()
              ], //---to filter conversations via stream
              'lastMessage': "started the conversation",
              'lastMessageTime': DateTime.now().toString(),
              'createdBy': me.uid,
              'createdAt': DateTime.now(),
              'messageType': "text",
            },
          )
          .then((value) => Logger().i("Conversation added"))
          .catchError((error) => Logger().e("Failed to merge data: $error"));

      DocumentSnapshot snapshot = await conversations.doc(docId).get();
      return ConversationModel.fromJson(
          snapshot.data() as Map<String, dynamic>);
    } else {
      return model;
    }
  }

  Future<ConversationModel?> checkConvExist(String myId, String peerId) async {
    try {
      ConversationModel? conModel;
      QuerySnapshot result = await conversations
          .where('users', arrayContainsAny: [myId, peerId]).get();

      for (var e in result.docs) {
        var model =
            ConversationModel.fromJson(e.data() as Map<String, dynamic>);

        if (model.users.contains(myId) && model.users.contains(peerId)) {
          Logger().w("the conversation is already exists");
          conModel = model;
        } else {
          Logger().w("the conversation is not exists");
          conModel = null;
        }
      }
      return conModel;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  //----------retreive conversation stream
  Stream<QuerySnapshot> getConversations(String currentUserId) => conversations
      .orderBy('createdAt', descending: true)
      .where('users', arrayContainsAny: [currentUserId]).snapshots();

  //-message sent fuction
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  Future<void> sendMessage(String conId, String senderName, String senderId,
      String reciveId, String message, String recivertoken, String type) async {
    String docId = messages.doc().id;
    try {
      await messages.doc(docId).set({
        "messageId": docId,
        "conId": conId,
        "senderName": senderName,
        "senderId": senderId,
        "reciveId": reciveId,
        "message": message,
        "messageTime": DateTime.now().toString(),
        "recivertoken": recivertoken,
        "createdAt": DateTime.now(),
        "messageType": type,
      });

      if (type == 'image') {
        await conversations.doc(conId).update({
          'messageType': "image",
        });
      }
      if (type == 'text') {
        await conversations.doc(conId).update({
          'messageType': "text",
        });
      }
      //----update the conversation lastmesage
      await conversations.doc(conId).update({
        'lastMessage': message,
        'lastMessageTime': DateTime.now().toString(),
        'createdAt': DateTime.now()
      });
    } catch (e) {
      Logger().e(e);
    }
  }

//---------upload picked image file to firebase storage
  Future<String> uploadAndUpdatePickedImage(
    File file,
  ) async {
    try {
      //------first upload and get the download link of he picked file
      String downloadUrl =
          await _fileUploadController.uploadFile(file, "messageImages");

      if (downloadUrl != "") {
        return downloadUrl;
      } else {
        Logger().e("download url is empty");
        return "";
      }
    } catch (e) {
      Logger().e(e);
      return "";
    }
  }

  //----------retreive message stream
  Stream<QuerySnapshot> getMessages(String conId) => messages
      .orderBy('createdAt', descending: false)
      .where('conId', isEqualTo: conId)
      .snapshots();

  //----------listen to peer user uid
  Stream<DocumentSnapshot> getPeerUserOnlineStatus(String uid) =>
      users.doc(uid).snapshots();

  Future<void> deleteBooking(String id) async {
    await messages.doc(id).delete();
  }
}
