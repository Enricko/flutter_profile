import 'dart:convert';

import "package:flutter/material.dart";
import 'package:flutter_profile/controller.dart';
import 'package:flutter_profile/model/media.dart';
import "package:responsive_ui/responsive_ui.dart";
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter_profile/firebase_options.dart';
import 'package:url_launcher/url_launcher.dart';

class HeaderProfile extends StatefulWidget {
  const HeaderProfile({super.key});

  @override
  State<HeaderProfile> createState() => _HeaderProfileState();
}
// class Media {
//   final String iconPath;
//   final String link;

//   Media(
//     this.iconPath,
//     this.link,
//   );
// }
// class Media {
//   String image, link;

//   Media({required this.image, required this.link});
//   factory Media.fromJSON(Map<dynamic, dynamic> media) => Media(image: media["image"], link: media["link"]);
// }


class _HeaderProfileState extends State<HeaderProfile> {
  // final List<Media> ListMedia = [
  //   Media(
  //     'assets/insta.png',
  //     'https://www.instagram.com/enricko_putra_h/?hl=id'
  //   ),
  //   Media(
  //     'assets/insta.png',
  //     'https://www.instagram.com/enricko_putra_h/?hl=id'
  //   ),
  // ];

  DatabaseReference db_media =
      FirebaseDatabase.instance.ref().child('medias');
      

  // Future medias = 

  // Future<List<Media>> medias = FirebaseDatabase.instance.ref().child('medias').onValue.asyncMap((medias) {
  //   return medias.documents.map((media) => Media.fromJSON(media.data)).toList();
  // }).single;
  // Map<String,dynamic>? datas;
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: 600,
      child: Center(
        child: Responsive(
          children: [
            if (screenWidth < 900) 
            Center(
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    "assets/profile.jpeg",
                    width: 200,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ) else 
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  "assets/profile.jpeg",
                  width: 200,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Div(
              divison: Division(
                colXS: 12,
                colS: 12,
                colM: 12,
                colL: 6,
                colXL: 6,
              ),
              child: Container(
                margin: screenWidth < 900 ? EdgeInsets.symmetric(horizontal: screenWidth / 10 * 3,vertical: 15) : EdgeInsets.only(left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hi There,",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700
                      ),
                    ),
                    Text("I'm Enricko",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w700
                      ),
                    ),
                    Text("Full Stack Developer with Huge Enthusiasm",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    
                    // for(final i in db_media.get())
                    // Text(datas?['link']),
                    FutureBuilder(
                      future: Controller.Media(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return Row(
                            children: [
                              for (var i in snapshot.data!.values) 
                                MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () async{
                                      final url = i['link'];
                                      final uri = Uri.parse(url);
                                      if (await canLaunchUrl(uri)) {
                                        await launchUrl(uri);
                                      } else {
                                        throw 'Could not launch $url';
                                      }
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(top: 10,right: 10),
                                      padding: EdgeInsets.all(5),
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 94, 94, 94),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.network(
                                          "${i['image']}",
                                          width: 30,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          );
                          // var productList = snapshot.data! as List;
                          // print(snapshot.data! as Map);
                          // for (var i in productList) {
                          //   print(i);
                          // }
                          // return Text(productList.length.toString());
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return CircularProgressIndicator();
                        }
                      }
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}