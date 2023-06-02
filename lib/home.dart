import "package:firebase_database/firebase_database.dart";
import "package:firebase_ui_database/firebase_ui_database.dart";
import "package:flutter/material.dart";
import "package:flutter_profile/layouts/Project.dart";

import "layouts/Footer.dart";
import "layouts/header.dart";
import "layouts/about.dart";

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  // @override
  // void initState() {
  //   WidgetsBinding.instance.addObserver(this);
  //   super.initState();
  // }
  // @override
  // void dispose() {
  //   WidgetsBinding.instance.removeObserver(this);
  //   super.dispose();
  // }
  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   print('state = $state');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/eph2.png',
          width: 50,
          height: 50,
          colorBlendMode: BlendMode.srcOver,
        ),
        backgroundColor: Color.fromRGBO(7, 17, 26, 1),
      automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              child: Theme(
                data: Theme.of(context).copyWith(
                  cardColor: Color.fromARGB(255, 54, 60, 66),
                  dividerColor: Color.fromARGB(137, 34, 34, 34),
                  textTheme: TextTheme(
                    titleLarge: TextStyle(color: Colors.white),
                    titleMedium: TextStyle(color: Colors.white),
                    titleSmall: TextStyle(color: Colors.white),
                    bodyLarge: TextStyle(color: Colors.white),
                    bodyMedium: TextStyle(color: Colors.white),
                    bodySmall: TextStyle(color: Colors.white),
                  ),
                ),
                child: Column(
                  children: [
                    HeaderProfile(),
                    Divider(
                      color: Colors.white30,
                      height: 10,
                    ),
                    AboutProfile(),
                    Divider(
                      color: Colors.white30,
                      height: 10,
                    ),
                    ProjectProfile(),
                    Divider(
                      color: Colors.white30,
                      height: 10,
                    ),
                    FooterProfile(),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 10,
            top: 5,
            child: Row(
              children: [
                Container(
                  width: 90,
                  padding: EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(color: Colors.white),
                  child: Text(
                    'width:${MediaQuery.sizeOf(context).width}',
                    // 'Total Visitor',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ),
                FirebaseDatabaseQueryBuilder(
                  query: FirebaseDatabase.instance.ref().child('general'), 
                  builder: (BuildContext context, FirebaseQueryBuilderSnapshot snapshot, Widget? child) { 
                    if(snapshot.hasData){
                      var data = snapshot.docs;
                      List<Widget> listWidget = [];
                      final val = data[1].value;
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 3),
                        constraints: BoxConstraints(
                          minWidth: 10
                        ),
                        decoration: BoxDecoration(color: Colors.blueAccent),
                        child: Text(
                          '${val}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                      );
                    }
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 3),
                      constraints: BoxConstraints(
                        minWidth: 10
                      ),
                      decoration: BoxDecoration(color: Colors.blueAccent),
                      child: Text(
                        '0',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    );
                  },
                ),
              ],
            )
          ),
        ],
      ),
    );
  }
}