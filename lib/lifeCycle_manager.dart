import 'dart:html';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LifeCycleManager extends StatefulWidget {
  final Widget child;
  LifeCycleManager({Key? key, required this.child}) : super(key: key);
  _LifeCycleManagerState createState() => _LifeCycleManagerState();
}
class _LifeCycleManagerState extends State<LifeCycleManager>
    with WidgetsBindingObserver {

  DatabaseReference? dbRef;
  @override
  void initState() {
    if (kIsWeb) {
      window.addEventListener('focus', onFocus);
      window.addEventListener('blur', onBlur);
    } else {
      WidgetsBinding.instance.addObserver(this);
    }

    dbRef = FirebaseDatabase.instance.ref().child('general');
    super.initState();
  }
  @override
  void dispose() {
    if (kIsWeb) {
      window.removeEventListener('focus', onFocus);
      window.removeEventListener('blur', onBlur);
    } else {
      WidgetsBinding.instance!.removeObserver(this);
    }
    super.dispose();
  }

  void onFocus(Event e) {
    didChangeAppLifecycleState(AppLifecycleState.resumed);
  }

  void onBlur(Event e) {
    didChangeAppLifecycleState(AppLifecycleState.paused);
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) async{
  //   switch (state) {
  //     case AppLifecycleState.resumed:
  //       print('app resumed');
  //       checkOnline('resume');
  //       break;
  //     case AppLifecycleState.inactive:
  //       print('app inactive');
  //       checkOnline('pause');
  //       break;
  //     case AppLifecycleState.paused:
  //       print('app paused');
  //       checkOnline('pause');
  //       break;
  //     case AppLifecycleState.detached:
  //       print('app detached');
  //       break;
  //   }
  // }
  
  // void checkOnline(String stat) async{
  //   if (stat == 'resume') {
  //     await FirebaseDatabase.instance
  //         .ref().child('general')
  //         .update({'membersOnline': ServerValue.increment(1)}
  //     );
  //   } else if(stat == 'pause') {
  //     await FirebaseDatabase.instance
  //         .ref().child('general')
  //         .update({'membersOnline': ServerValue.increment(-1)}
  //     );
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.child,
    );
  }
}