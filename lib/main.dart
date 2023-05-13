import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_profile/Admin/home.dart';
import 'package:flutter_profile/Admin/login.dart';
import 'package:flutter_profile/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final routes = <String, WidgetBuilder>{
      // Front Pages
      '/': (context) => Home(),

      // Admin Pages
      '/login': (context) => Login(),
      '/admin': (context) => AdminHome(),
    };
    return MaterialApp(
      title: 'Enricko Profile',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: Theme.of(context).copyWith(
        platform: TargetPlatform.android,
        scaffoldBackgroundColor: Color.fromRGBO(7, 17, 26, 1),
        primaryColor: Color.fromRGBO(21, 181, 114, 1),
        canvasColor: Color.fromRGBO(7, 17, 26, 1),
        textTheme: GoogleFonts.latoTextTheme(),
      ),
      builder: EasyLoading.init(),
      // home: Home(),
      initialRoute: '/',
      routes: routes,
    );
  }
}

// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_database/ui/firebase_animated_list.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_profile/firebase_options.dart';

// import 'insert.dart';
// import 'update.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'realtime CRUD',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Home(),
//     );
//   }
// }

// class Home extends StatefulWidget {
//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   @override
//   Widget build(BuildContext context) {
//     DatabaseReference db_Ref =
//         FirebaseDatabase.instance.ref().child('contacts');
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.indigo[900],
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (_) => ccreate(),
//             ),
//           );
//         },
//         child: Icon(
//           Icons.add,
//         ),
//       ),
//       appBar: AppBar(
//         title: Text(
//           'Contacts',
//           style: TextStyle(
//             fontSize: 30,
//           ),
//         ),
//         backgroundColor: Colors.indigo[900],
//       ),
//       body: FirebaseAnimatedList(
//         query: db_Ref,
//         shrinkWrap: true,
//         itemBuilder: (context, snapshot, animation, index) {
//           Map Contact = snapshot.value as Map;
//           Contact['key'] = snapshot.key;
//           return GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => UpdateRecord(
//                     Contact_Key: Contact['key'],
//                   ),
//                 ),
//               );
//               // print(Contact['key']);
//             },
//             child: Container(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: ListTile(
//                   shape: RoundedRectangleBorder(
//                     side: BorderSide(
//                       color: Colors.white,
//                     ),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   tileColor: Colors.indigo[100],
//                   trailing: IconButton(
//                     icon: Icon(
//                       Icons.delete,
//                       color: Colors.red[900],
//                     ),
//                     onPressed: () {
//                       db_Ref.child(Contact['key']).remove();
//                     },
//                   ),
//                   leading: CircleAvatar(
//                     backgroundImage: NetworkImage(
//                       Contact['url'],
//                     ),
//                   ),
//                   title: Text(
//                     Contact['name'],
//                     style: TextStyle(
//                       fontSize: 25,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   subtitle: Text(
//                     Contact['number'],
//                     style: TextStyle(
//                       fontSize: 25,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
