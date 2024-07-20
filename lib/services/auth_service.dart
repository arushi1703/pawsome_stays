import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService{
  final FirebaseAuth _firebaseAuth= FirebaseAuth.instance;

  User? _user;
  User? get user{ //getter function
    return _user;
  }

  AuthService(){
    _firebaseAuth.authStateChanges().listen(authStateChangesStreamListener); //attaching a listener
  }

  Future<bool> login (String email, String password) async{
    try{
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      if (credential.user != null){
        _user = credential.user;
        return true;
      }
    }catch(e){
      print(e);
    }
    return false;
  }

  //everytime a state change happens for the authenticated user
  void authStateChangesStreamListener(User? user){
    if (user!=null){
      _user=user;
    }else{
      _user = null;
    }
  }
}