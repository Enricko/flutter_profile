import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_easyloading/flutter_easyloading.dart";
import "package:flutter_profile/Admin/Pages/Project/Project.dart";
import "package:flutter_profile/Admin/Pages/media/mediaInsert.dart";

import "../Controller/auth.dart";
import "../model/media.dart";
import "Pages/Project/ProjectInsert.dart";
import "Pages/Project/ProjectUpdate.dart";
import 'Pages/media/media.dart';
import "Pages/media/mediaUpdate.dart";

class Admin extends StatefulWidget {
  const Admin({super.key, required this.page});
  final String page;

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  
  final pages = <String,dynamic>{
    'dashboard' : Container(),
    // Media
    'media' : MediaPage(),
    'mediaInsert' : MediaInsert(),
    'mediaUpdate' : MediaUpdate(),
    // Project
    'project' : ProjectPage(),
    'projectInsert' : ProjectInsert(),
    'projectUpdate' : ProjectUpdate(),
  };
  final formCreate = <String,dynamic>{
    'media' : '/admin/media/insert',
    'project' : '/admin/project/insert',
  };
  @override
  void initState() {
    Auth.userCheck(context);
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(7, 17, 26, 1),
        // automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: pages[widget.page],
      ),
      floatingActionButton: formCreate[widget.page] == null ? Container() 
      : FloatingActionButton(
        backgroundColor: Colors.indigo[900],
        child: Tooltip(
          message: "Add Data",
          child: Icon(
            Icons.create_outlined
          )
        ),
        onPressed: () {
          Navigator.pushNamed(context, formCreate[widget.page]);
        },
      ),
      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            children: [
              DrawerHeader(
                child: Image.asset(
                  'assets/eph2.png',
                  width: 50,
                  height: 50,
                  colorBlendMode: BlendMode.srcOver,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 15,top: 15,bottom: 10),
                child: Text(
                  "Dashboard",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14
                  ),
                ),
              ),
              ListTile(
                selectedColor: Colors.blueGrey,
                hoverColor: Colors.blueGrey,
                tileColor: widget.page.contains('dashboard') == true ? Colors.blueGrey : null,
                title: Container(
                  child: Row(
                    children: [
                      Icon(Icons.speed,size: 16,color: Colors.white),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Dashboard',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white
                        ),
                      )
                    ],
                  ),
                ),
                onTap: () => Navigator.pushNamed(context, '/admin'),
              ),
              Container(
                margin: EdgeInsets.only(left: 15,top: 15,bottom: 10),
                child: Text(
                  "Table",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14
                  ),
                ),
              ),
              ListTile(
                selectedColor: Colors.blueGrey,
                hoverColor: Colors.blueGrey,
                tileColor: widget.page.contains('media') == true ? Colors.blueGrey : null,
                title: Container(
                  child: Row(
                    children: [
                      Icon(Icons.speed,size: 16,color: Colors.white),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Media',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white
                        ),
                      )
                    ],
                  ),
                ),
                onTap: () => Navigator.pushNamed(context, '/admin/media'),
              ),
              ListTile(
                selectedColor: Colors.blueGrey,
                hoverColor: Colors.blueGrey,
                tileColor: widget.page.contains('project') == true ? Colors.blueGrey : null,
                title: Container(
                  child: Row(
                    children: [
                      Icon(Icons.speed,size: 16,color: Colors.white),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Project',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white
                        ),
                      )
                    ],
                  ),
                ),
                onTap: () => Navigator.pushNamed(context, '/admin/project'),
              ),
              Container(
                margin: EdgeInsets.only(left: 15,top: 15,bottom: 10),
                child: Text(
                  "Settings",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14
                  ),
                ),
              ),
              ListTile(
                selectedColor: Colors.blueGrey,
                hoverColor: Colors.blueGrey,
                title: Container(
                  child: Row(
                    children: [
                      Icon(Icons.power_settings_new,size: 16,color: Colors.white),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Logout',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white
                        ),
                      )
                    ],
                  ),
                ),
                onTap: () => _logout(context),
              ),
            ],
          ),
        ),
      ),
    );
    
  }
  void _logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text('Please Confirm'),
          content: const Text('Are you sure want to logout?'),
          actions: [
            // The "Yes" button
            TextButton(
              onPressed: () {
                Auth.logout(context);
              },
              child: const Text('Yes')
            ),
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
              },
              child: const Text('No')
            )
          ],
        );
      }
    );
  }
}