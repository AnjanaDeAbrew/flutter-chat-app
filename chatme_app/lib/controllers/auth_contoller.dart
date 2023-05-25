import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dude/models/objects.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

class AuthController {
  final FirebaseAuth auth = FirebaseAuth.instance;

//-----triger signin with google function

  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      final response =
          await FirebaseAuth.instance.signInWithCredential(credential);

      //-check if the is successfully created in the firebase
      if (response.user != null) {
        //----if yes, saving the additional data in cloud firestore
        await saveUserData(UserModel(
            response.user!.uid,
            response.user!.email!,
            response.user!.displayName!,
            response.user!.photoURL!,
            DateTime.now().toString(),
            true,
            ""));
        return response;
      } else {
        //---if some errors occurres return null
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  //---trigger logging out
  Future<void> logout() async {
    await GoogleSignIn().disconnect();
    FirebaseAuth.instance.signOut();
  }

  // Create a CollectionReference called users that references the firestore collection
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  //----save extra user data in firestore
  Future<void> saveUserData(UserModel userModel) {
    return users
        .doc(userModel.uid)
        .set(
          {
            'uid': userModel.uid,
            'email': userModel.email,
            'name': userModel.name,
            'img': userModel.img,
            'lastSeen': userModel.lastSeen,
            'isOnline': userModel.isOnline,
            'token': userModel.token,
          },
        )
        .then((value) => Logger().i("Successfully added"))
        .catchError((error) => Logger().e("Failed to merge data: $error"));
  }

  //---fetch userdata from cloudfirestore
  Future<UserModel?> fetchUserData(String uid) async {
    try {
      //----------------firebase query that find and fetch user data according to the uid
      DocumentSnapshot documentSnapshot = await users.doc(uid).get();
      Logger().i(documentSnapshot.data());

      //---mapping fetched data user data into usermodel
      UserModel model =
          UserModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);

      return model;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  //-update the current user online state and last seen
  Future<void> updateOnlineStates(String uid, bool isOnline) async {
    await users
        .doc(uid)
        .update({
          "isOnline": isOnline,
          "lastSeen": DateTime.now().toString(),
        })
        .then((value) => Logger().i("Online Status updated"))
        .catchError((error) => Logger().e("Failed to update : $error"));
  }
}
