import 'package:flutter/material.dart';

class FooterProfile extends StatefulWidget {
  const FooterProfile({super.key});

  @override
  State<FooterProfile> createState() => _FooterProfileState();
}

class _FooterProfileState extends State<FooterProfile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      child: Center(
        child: Text(
          "Copyright © 2023 - All right reserved by Enricko",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w800
          ),
        ),
      ),
    );
  }
}