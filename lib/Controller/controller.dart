import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../model/media.dart';

class Controller{
  
  static Media() async{
    Map? d;
    final snapshot = await FirebaseDatabase.instance.ref().child('medias').get();
    if (snapshot.exists) {
      d = snapshot.value as Map;
    } else {
      print('No Data Available');
    }
    return d;
  }
}