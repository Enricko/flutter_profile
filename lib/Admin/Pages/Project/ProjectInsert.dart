import "dart:io";

import "package:firebase_database/firebase_database.dart";
import "package:firebase_storage/firebase_storage.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_easyloading/flutter_easyloading.dart";
import "package:image_picker/image_picker.dart";
import "package:random_string/random_string.dart";

class ProjectInsert extends StatefulWidget {
  const ProjectInsert({super.key});

  @override
  State<ProjectInsert> createState() => _ProjectInsertState();
}

class _ProjectInsertState extends State<ProjectInsert> {
  TextEditingController titleCon = TextEditingController();
  TextEditingController descriptionCon = TextEditingController();
  TextEditingController linkCon = TextEditingController();
  
  File? file;
  ImagePicker image = ImagePicker();
  Uint8List webImage = Uint8List(8);
  var url;
  DatabaseReference? dbRef;

  bool load = false;
  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('Projects');
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

  insertData() async {
    try {
      var metadata = SettableMetadata(
        contentType: "image/jpeg",
      );
      var imagefile = FirebaseStorage.instance
          .ref()
          .child("Projects")
          .child("${randomAlpha(10)}-${DateTime.now()}.png");
        
      UploadTask task = imagefile.putData(webImage);
      if (!kIsWeb) {
        UploadTask task = imagefile.putFile(file!);
      }
      TaskSnapshot snapshot = await task;
      url = await snapshot.ref.getDownloadURL();
      setState(() {
        url = url;
      });
      if (url != null) {
        Map<String, String> Project = {
          'title': titleCon.text,
          'description': descriptionCon.text,
          'link': linkCon.text,
          'thumbnail': url,
        };

        dbRef!.push().set(Project).whenComplete(() {
          EasyLoading.showSuccess('Data has been insert',dismissOnTap: true);
          Navigator.pushReplacementNamed(context,'/admin/project');
          load = false;
          return;
        });
        setState(() {
          load = false;
        });
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    if(load){
      EasyLoading.show(status: 'loading...');
    }
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 25,vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/admin/project');
                },
                child: Text(
                  "< Back",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Form Insert Project",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
                color: Colors.white
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Container(
                height: 200,
                width: 200,
                child: file == null
                    ? Tooltip(
                      message: "Upload Image",
                      child: IconButton(
                          icon: Icon(
                            Icons.add_a_photo,
                            size: 90,
                            color: Color.fromARGB(255, 179, 179, 179),
                          ),
                          onPressed: () {
                            getImage();
                          },
                        ),
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
              controller: titleCon,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              style: TextStyle(
                color: Colors.white
              ),
              decoration: InputDecoration(
                hintText: "Your title",
                labelText: "Your title",
                hintStyle: TextStyle(
                  color: Colors.white
                ),
                labelStyle: TextStyle(
                  color: Colors.white
                ),
                prefixIcon: Padding(
                  padding:  EdgeInsets.all(10),
                  child: Icon(Icons.title),
                ),
                prefixIconColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 3,color: Colors.white),
                  borderRadius: BorderRadius.circular(30),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 3,color: Colors.white),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: descriptionCon,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              minLines: 1,
              maxLines: 10,
              style: TextStyle(
                color: Colors.white
              ),
              decoration: InputDecoration(
                hintText: "Your Description",
                labelText: "Your Description",
                hintStyle: TextStyle(
                  color: Colors.white
                ),
                labelStyle: TextStyle(
                  color: Colors.white
                ),
                prefixIcon: Padding(
                  padding:  EdgeInsets.all(10),
                  child: Icon(Icons.description),
                ),
                prefixIconColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 3,color: Colors.white),
                  borderRadius: BorderRadius.circular(30),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 3,color: Colors.white),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: linkCon,
              keyboardType: TextInputType.url,
              textInputAction: TextInputAction.next,
              style: TextStyle(
                color: Colors.white
              ),
              decoration: InputDecoration(
                hintText: "Your link",
                labelText: "Your link",
                hintStyle: TextStyle(
                  color: Colors.white
                ),
                labelStyle: TextStyle(
                  color: Colors.white
                ),
                prefixIcon: Padding(
                  padding:  EdgeInsets.all(10),
                  child: Icon(Icons.link),
                ),
                prefixIconColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 3,color: Colors.white),
                  borderRadius: BorderRadius.circular(30),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 3,color: Colors.white),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 125,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    
                    if (file != null && linkCon.text != "") {
                      insertData();
                      setState(() {
                        load = true;
                      });
                    }else{
                      EasyLoading.showError('Please insert all form',dismissOnTap: true);
                    }
                  },
                  child: Text(
                    "Submit",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700
                    ),
                  )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}