import 'package:dude/controllers/auth_contoller.dart';
import 'package:dude/screens/main/main_screen.dart';
import 'package:dude/screens/main/startup/main_startup.dart';
import 'package:dude/utils/util_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../models/objects.dart';

class AuthProvider extends ChangeNotifier {
  //-----------google auth

  final AuthController _authController = AuthController();

  //------store firebase user
  User? _firebaseUser;

  //-getter for firebase user
  User? get firebaseUser => _firebaseUser;

//-google signin
  Future<void> googleAuth() async {
    try {
      final userCredential = await _authController.signInWithGoogle();

      if (userCredential != null) {
        Logger().w(userCredential.user);
        //-setting created firebase user details
        _firebaseUser = userCredential.user;
        notifyListeners();
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  //-logout google user
  Future<void> logOut() async {
    try {
      //--updating the user offline status to false before logout
      _authController.updateOnlineStates(_firebaseUser!.uid, false);
      await _authController.logout();
    } catch (e) {
      Logger().e(e);
    }
  }

  //------initialize the user and listen to the auth state
  Future<void> initializeUser(BuildContext context) async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        //------------If the user objecct is null ---- that means the user is signed out or not exists
        Logger().i("User is currently signed out!");
        _firebaseUser = user;
        notifyListeners();

        UtilFunctions.navigateTo(context, const StartUp());
      } else {
        //------------If the user objecct is not null ---- that means the auth state is logged in
        //------------so redirect the user to home
        Logger().i("User is signed in!");
        _firebaseUser = user;
        notifyListeners();
        await startFetchUserData(user.uid).then((value) {
          //-update the current user online state and last seen
          updateOnlineStates(true);
          UtilFunctions.navigateTo(context, const MainScreen());
        });
      }
    });
  }

  UserModel? _userModel;

  UserModel? get userModel => _userModel;

  Future<void> startFetchUserData(String uid) async {
    try {
      await _authController.fetchUserData(uid).then((value) {
        //----check if fetched result is not null
        if (value != null) {
          _userModel = value;
          notifyListeners();
        }
      });
    } catch (e) {
      Logger().e(e);
    }
  }

  //-update the current user online state and last seen
  void updateOnlineStates(bool val) {
    try {
      _authController.updateOnlineStates(_firebaseUser!.uid, val);
    } catch (e) {
      Logger().e(e);
    }
  }

  void setDeviceToken(String token) {
    _userModel!.token = token;
    notifyListeners();
  }
}
