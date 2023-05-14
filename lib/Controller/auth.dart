import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Auth{

  static login(Map<String,String> data)async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: data['email']!,
        password: data['password']!
      );
      EasyLoading.showSuccess('Welcome Back',dismissOnTap: true);
    }on Exception catch (e){
      print(e);
      EasyLoading.showError('Email or Password incorrect',dismissOnTap: true);
    }
  }
  static userCheck(BuildContext context){
    if (FirebaseAuth.instance.currentUser == null) {
      WidgetsBinding.instance.addPostFrameCallback((_){
        Navigator.of(context).pushReplacementNamed("/login");
      });
      EasyLoading.showError('You dont have access to that page',dismissOnTap: true);
      return;
      // enricko.putra028@gmail.com
    }
  }
}