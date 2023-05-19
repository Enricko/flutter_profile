import "package:flutter/material.dart";

import "layouts/header.dart";
import "layouts/about.dart";

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
      body: SingleChildScrollView(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}