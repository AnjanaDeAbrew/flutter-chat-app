const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.sendNotification = functions.firestore
    .document("messages/{docId}")
    .onCreate((snap, context) => {
      // Get an object representing the document
      // e.g. {'name': 'Marie', 'age': 66}
      const newValue = snap.data();
      console.log(newValue);

      // reciver device token
      const token = newValue.recivertoken;

      // declaring the notification payload
      const payload = {
        notification: {
          title: newValue.senderName,
          body: newValue.message,
        },
        data: {
          conId: newValue.conId,
        },
      };

      admin.messaging().sendToDevice(token, payload).then((response) =>
        console.log(response)).catch((error)=>
        console.log(error));
    });
