import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Auth{

  static login(Map<String,String> data,BuildContext context)async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: data['email']!,
        password: data['password']!
      );
      EasyLoading.showSuccess('Welcome Back',dismissOnTap: true);
      Navigator.of(context).pushReplacementNamed("/admin");
    }on Exception catch (e){
      print(e);
      EasyLoading.showError('Email or Password incorrect',dismissOnTap: true);
    }
  }
  static logout(BuildContext context)async{
    if (FirebaseAuth.instance.currentUser == null) {
      WidgetsBinding.instance.addPostFrameCallback((_){
        Navigator.of(context).pushReplacementNamed("/login");
      });
      EasyLoading.showSuccess('You already logout',dismissOnTap: true);
      return;
      // enricko.putra028@gmail.com
    }else{
      await FirebaseAuth.instance.signOut();
      WidgetsBinding.instance.addPostFrameCallback((_){
        Navigator.of(context).pushReplacementNamed("/login");
      });
      EasyLoading.showSuccess('You have been logout',dismissOnTap: true);
      return;
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