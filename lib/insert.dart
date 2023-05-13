import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'main.dart';

class ccreate extends StatefulWidget {
  @override
  State<ccreate> createState() => ccreateState();
}

class ccreateState extends State<ccreate> {
  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();
  File? file;
  ImagePicker image = ImagePicker();
  Uint8List webImage = Uint8List(8);
  var url;
  DatabaseReference? dbRef;
  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('medias');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Contacts',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        backgroundColor: Colors.indigo[900],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                  height: 200,
                  width: 200,
                  child: file == null
                      ? IconButton(
                          icon: Icon(
                            Icons.add_a_photo,
                            size: 90,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          onPressed: () {
                            getImage();
                          },
                        )
                      : MaterialButton(
                          height: 100,
                          child: kIsWeb ? Image.memory(webImage!,fit: BoxFit.fill,)
                              : Image.file(file!,fit: BoxFit.fill,),
                          onPressed: () {
                            getImage();
                          },
                        )),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: name,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Name',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: number,
              // keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Number',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              height: 40,
              onPressed: () {
                // getImage();

                if (file != null) {
                  uploadFile();
                }
              },
              child: Text(
                "Add",
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 20,
                ),
              ),
              color: Colors.indigo[900],
            ),
          ],
        ),
      ),
    );
  }

  getImage() async {
    XFile? img = await image.pickImage(source: ImageSource.gallery);
    var f = await img!.readAsBytes();
    setState(() {
      webImage = f;
      file = File(img!.path);
    });

    // print(file);
  }

  uploadFile() async {
    try {
      print('asdasd');
      print(file!);
      var metadata = SettableMetadata(
        contentType: "image/jpeg",
      );
      var imagefile = FirebaseStorage.instance
          .ref()
          .child("medias")
          .child("${name.text}-${DateTime.now()}.png");
        
      UploadTask task = imagefile.putData(webImage);
      if (!kIsWeb) {
        UploadTask task = imagefile.putFile(file!);
      }
      TaskSnapshot snapshot = await task;
      url = await snapshot.ref.getDownloadURL();
      setState(() {
        url = url;
      });
      print(url);
      if (url != null) {
        Map<String, String> Contact = {
          'link': number.text,
          'image': url,
        };

        dbRef!.push().set(Contact).whenComplete(() {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => Home(),
            ),
          );
        });
      }
    } on Exception catch (e) {
      print(e);
    }
  }
}
