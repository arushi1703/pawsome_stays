import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pawsome_stays/consts.dart';

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

  Future<String?> signup(String email, String password, String name, String phoneno, String address) async{
    try{
      final credential= await _firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      if (credential.user != null){
        _user= credential.user;
        final Map<String, dynamic> userData = {
          'name': name,
          'phoneno': phoneno,
          'email': email,
          'password': password,
          'address': address,
        };
        final response = await http.post(
          Uri.parse(backend_url+'api/petowner/add'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(userData),
        );
        print(backend_url+'api/petowner/add');
        if (response.statusCode == 201) {
          final responseData = json.decode(response.body);
          print(responseData['_id']);
          return responseData['_id'];
        } else {
          print('Error: ${response.body}');
        }
      }
    }catch(e){
      print(e);
    }
    return null;
  }


  Future<bool> logout() async{
    try{
      await _firebaseAuth.signOut();
      return true;
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