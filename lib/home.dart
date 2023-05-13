import "package:flutter/material.dart";

import "layouts/header.dart";

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
          child: Column(
            children: [
              HeaderProfile(),
            ],
          ),
        ),
      ),
    );
  }
}