import "package:firebase_database/firebase_database.dart";
import "package:firebase_database/ui/firebase_animated_list.dart";
import "package:flutter/material.dart";
import "package:responsive_ui/responsive_ui.dart";
import "package:shimmer/shimmer.dart";
import "package:url_launcher/url_launcher.dart";

import "../../Controller/controller.dart";

class MediaPage extends StatefulWidget {
  const MediaPage({super.key});

  @override
  State<MediaPage> createState() => _MediaPageState();
}

class _MediaPageState extends State<MediaPage> {
  DatabaseReference db_media =
      FirebaseDatabase.instance.ref().child('medias');
  var shim = true;
    
  media() async{
    List productList = [];
    final snapshot = await FirebaseDatabase.instance.ref().child('medias').get();
    productList = [];
    if (snapshot.exists) {
      productList.add(snapshot.value);
      // products = (snapshot.value);
    } else {
      print('No Data Available');
    }
    return productList;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Controller.Media();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: FutureBuilder(
        future: Controller.Media(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            shim = false;
            var media = snapshot.data!.entries.toList();
            return Responsive(
              children: [
                for (int i = 0;i<media.length;i++) 
                Div(
                  divison: Division(
                    colXL: 3,
                    colL: 4,
                    colM: 6,
                    colS: 12,
                    colXS: 12,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (_) => UpdateRecord(
                      //       Media_Key: Media['key'],
                      //     ),
                      //   ),
                      // );
                      // null;
                      print(media[i].key);
                    },
                    child: Container(
                      height: 100,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          tileColor: Colors.indigo[100],
                          trailing: Column(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red[900],
                                ),
                                onPressed: () {
                                  delete(context,media[i].key,db_media);
                                },
                              ),
                            ],
                          ),
                          leading: CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 94, 94, 94),
                            backgroundImage: NetworkImage(
                              media[i].value['image'],
                            ),
                          ),
                          title: SingleChildScrollView(
                            child: Container(
                              height: 70,
                              child: Text(
                                media[i].value['link'],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          // subtitle: Text(
                          //   Media['number'],
                          //   style: TextStyle(
                          //     fontSize: 25,
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Shimmer.fromColors(
              baseColor: Colors.grey,
              highlightColor: Colors.grey.shade100,
              enabled: shim,
              child: Responsive(
                children: [
                  for (int i = 0;i<30;i++) 
                  Div(
                    divison: Division(
                      colXL: 3,
                      colL: 4,
                      colM: 6,
                      colS: 12,
                      colXS: 12,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        null;
                      },
                      child: Container(
                        height: 100,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            tileColor: Colors.indigo[100],
                            trailing: Column(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red[900],
                                  ),
                                  onPressed: () {
                                    // delete(context,media[i].key,db_media);
                                  },
                                ),
                              ],
                            ),
                            leading: CircleAvatar(
                              backgroundColor: Color.fromARGB(255, 94, 94, 94),
                              // backgroundImage: NetworkImage(
                              //   // media[i].value['image'],
                              //   ""
                              // ),
                            ),
                            title: SingleChildScrollView(
                              child: Container(
                                height: 70,
                                child: Text(
                                  "==========================================",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            // subtitle: Text(
                            //   Media['number'],
                            //   style: TextStyle(
                            //     fontSize: 25,
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            // ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        }
      ),
    );
  }
  void delete(BuildContext context,String uid,DatabaseReference db_Ref) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text('Please Confirm'),
          content: const Text('Are you sure want to delete?'),
          actions: [
            // The "Yes" button
            TextButton(
              onPressed: () {
                // Auth.logout(context);
                db_Ref.child(uid).remove();
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