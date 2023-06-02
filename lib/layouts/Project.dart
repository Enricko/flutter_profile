import "package:buttons_tabbar/buttons_tabbar.dart";
import "package:firebase_database/firebase_database.dart";
import "package:firebase_ui_database/firebase_ui_database.dart";
import "package:flutter/material.dart";
import "package:responsive_ui/responsive_ui.dart";
import "package:url_launcher/url_launcher.dart";

class ProjectProfile extends StatefulWidget {
  const ProjectProfile({super.key});

  @override
  State<ProjectProfile> createState() => _ProjectProfileState();
}

class _ProjectProfileState extends State<ProjectProfile> with SingleTickerProviderStateMixin {

  Future<void> _modalDetail(BuildContext context, Object? key)async{
    final query = FirebaseDatabase.instance.ref().child('Projects').child("$key").onValue.listen((event) async {
      final data = event.snapshot.value as Map<String,dynamic>;
      await showDialog(
        context:context,
        barrierDismissible: true,
        barrierColor: Colors.black54,
        builder: (BuildContext context) { 
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Color.fromARGB(255, 68, 68, 68),
            content: Builder(builder: (context){
              return Card(
                elevation: 0,
                color: Colors.transparent,
                child: Container(
                  width: MediaQuery.sizeOf(context).width * .7,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .7,
                          height: 150,
                          child: Center(
                            child: Image.network(
                              "${data['thumbnail']}",
                              width: 300,
                              height: 150,
                              
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.white30,
                          height: 10,
                        ),
                        SizedBox(
                          // width: MediaQuery.sizeOf(context).width * .7,
                          child: Column(
                            children: [
                              Text(
                                "${data['title']}",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "${data['description']}",
                                // overflow: TextOverflow.ellipsis,
                                // maxLines: 4,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      final url = data['link'];
                                      final uri = Uri.parse(url.toString());
                                      if (await canLaunchUrl(uri)) {
                                        await launchUrl(
                                          uri,
                                          mode: LaunchMode.externalApplication,
                                        );
                                      } else {
                                        throw 'Could not launch $url';
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.blue[600],
                                        borderRadius: BorderRadius.circular(5)
                                      ),
                                      padding: EdgeInsets.all(3),
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            WidgetSpan(child: Container(margin: EdgeInsets.only(right: 2), child: Icon(Icons.link))),
                                            WidgetSpan(
                                              alignment: PlaceholderAlignment.middle,
                                              child: Text("Go to link")
                                            )
                                          ]
                                        )
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          );
        }
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 500,
      ),
      margin: EdgeInsets.symmetric(vertical: 15,horizontal: 25),
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            ButtonsTabBar(
              backgroundColor: Colors.blue[600],
              unselectedBackgroundColor: Colors.white,
              labelStyle:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 18),
		          unselectedLabelStyle: TextStyle(
                color: Colors.blue[600], fontWeight: FontWeight.bold,fontSize: 18),
              borderWidth: 1,
              unselectedBorderColor: const Color.fromARGB(255, 30, 136, 229),
              radius: 100,
              contentPadding: EdgeInsets.symmetric(horizontal: 30,vertical: 5),
              tabs: [
                Tab(
                  text: "Flutter",
                ),
                Tab(
                  text: "Laravel",
                ),
              ],
            ),
            
            Container(
              width: MediaQuery.sizeOf(context).width,
              height: 550,
              child: TabBarView(
                children: [
                    // Flutter
                    SingleChildScrollView(
                      child: FirebaseDatabaseQueryBuilder(
                        query: FirebaseDatabase.instance.ref().child('Projects'),
                        builder: (BuildContext context, FirebaseQueryBuilderSnapshot snapshot, Widget? child) { 
                          int cekData = 0;
                          if (snapshot.hasData) {
                            var data = snapshot.docs;
                            List<Widget> listWidget = [];
                            for (var i = 0;i < data.length;i++) {
                              final val = data[i].value as Map<Object?,Object?>;
                              val['key'] = data[i].key;
                              if(val['category'] == 'flutter'){
                                cekData++;
                                listWidget.add(
                                  Div(
                                    divison: Division(
                                      colXL: 3,
                                      colL: 4,
                                      colM: 6,
                                      colS: 12,
                                      colXS: 12
                                    ),
                                    child: Container(
                                      margin: EdgeInsets.all(5),
                                      child: Card(
                                        elevation: 0,
                                        color: Colors.white12,
                                        child: Container(
                                          margin: EdgeInsets.all(20),
                                          width: 300,
                                          height: 350,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                width: 300,
                                                height: 150,
                                                child: Center(
                                                  child: Image.network(
                                                    "${val['thumbnail']}",
                                                    width: 300,
                                                    height: 150,
                                                    
                                                  ),
                                                ),
                                              ),
                                              Divider(
                                                color: Colors.white30,
                                                height: 10,
                                              ),
                                              SizedBox(
                                                width: 300,
                                                height: 120,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${val['title']}",
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                        color: Colors.white70,
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.w800
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      "${val['description']}",
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 4,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w700
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () async {
                                                      final url = val['link'];
                                                      final uri = Uri.parse(url.toString());
                                                      if (await canLaunchUrl(uri)) {
                                                        await launchUrl(
                                                          uri,
                                                          mode: LaunchMode.externalApplication,
                                                        );
                                                      } else {
                                                        throw 'Could not launch $url';
                                                      }
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.blue[600],
                                                        borderRadius: BorderRadius.circular(5)
                                                      ),
                                                      padding: EdgeInsets.all(3),
                                                      child: RichText(
                                                        text: TextSpan(
                                                          children: [
                                                            WidgetSpan(child: Container(margin: EdgeInsets.only(right: 2), child: Icon(Icons.link))),
                                                            WidgetSpan(
                                                              alignment: PlaceholderAlignment.middle,
                                                              child: Text("Go to link")
                                                            )
                                                          ]
                                                        )
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      _modalDetail(context,val['key']);
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.white24,
                                                        borderRadius: BorderRadius.circular(5)
                                                      ),
                                                      padding: EdgeInsets.all(3),
                                                      child: RichText(
                                                        text: TextSpan(
                                                          children: [
                                                            WidgetSpan(child: Container(margin: EdgeInsets.only(right: 2), child: Icon(Icons.zoom_in))),
                                                            WidgetSpan(
                                                              alignment: PlaceholderAlignment.middle,
                                                              child: Text("See Detail")
                                                            )
                                                          ]
                                                        )
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                );
                              }
                            }
                            if (snapshot.docs.length >= 1 && cekData >= 1) {
                              return Responsive(children: listWidget);
                            }
                            if(snapshot.docs.length <= 0 || cekData <= 0){
                              return Container(
                                height: 550,
                                child: Center(
                                  child: Text(
                                    'Project not made yet!',
                                    style: TextStyle(
                                      fontSize: 26,
                                      color: Colors.white
                                    ),
                                  )
                                ),
                              );
                            }
                          }
                          return Container(
                            height: 550,
                            child: Center(
                              child: CircularProgressIndicator()
                            ),
                          );
                        }
                      ),
                    ),

                    // Laravel
                    SingleChildScrollView(
                      child: FirebaseDatabaseQueryBuilder(
                        query: FirebaseDatabase.instance.ref().child('Projects'),
                        builder: (BuildContext context, FirebaseQueryBuilderSnapshot snapshot, Widget? child) { 
                          int cekData = 0;
                          if (snapshot.hasData) {
                            var data = snapshot.docs;
                            List<Widget> listWidget = [];
                            for (var i = 0;i < data.length;i++) {
                              final val = data[i].value as Map<Object?,Object?>;
                              val['key'] = data[i].key;
                              if(val['category'] == 'laravel'){
                                cekData++;
                                listWidget.add(
                                  Div(
                                    divison: Division(
                                      colXL: 3,
                                      colL: 4,
                                      colM: 6,
                                      colS: 12,
                                      colXS: 12
                                    ),
                                    child: Container(
                                      margin: EdgeInsets.all(5),
                                      child: Card(
                                        elevation: 0,
                                        color: Colors.white12,
                                        child: Container(
                                          margin: EdgeInsets.all(20),
                                          width: 300,
                                          height: 350,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                width: 300,
                                                height: 150,
                                                child: Center(
                                                  child: Image.network(
                                                    "${val['thumbnail']}",
                                                    width: 300,
                                                    height: 150,
                                                    
                                                  ),
                                                ),
                                              ),
                                              Divider(
                                                color: Colors.white30,
                                                height: 10,
                                              ),
                                              SizedBox(
                                                width: 300,
                                                height: 120,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${val['title']}",
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                        color: Colors.white70,
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.w800
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      "${val['description']}",
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 4,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w700
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () async {
                                                      final url = val['link'];
                                                      final uri = Uri.parse(url.toString());
                                                      if (await canLaunchUrl(uri)) {
                                                        await launchUrl(
                                                          uri,
                                                          mode: LaunchMode.externalApplication,
                                                        );
                                                      } else {
                                                        throw 'Could not launch $url';
                                                      }
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.blue[600],
                                                        borderRadius: BorderRadius.circular(5)
                                                      ),
                                                      padding: EdgeInsets.all(3),
                                                      child: RichText(
                                                        text: TextSpan(
                                                          children: [
                                                            WidgetSpan(child: Container(margin: EdgeInsets.only(right: 2), child: Icon(Icons.link))),
                                                            WidgetSpan(
                                                              alignment: PlaceholderAlignment.middle,
                                                              child: Text("Go to link")
                                                            )
                                                          ]
                                                        )
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      _modalDetail(context,val['key']);
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.white24,
                                                        borderRadius: BorderRadius.circular(5)
                                                      ),
                                                      padding: EdgeInsets.all(3),
                                                      child: RichText(
                                                        text: TextSpan(
                                                          children: [
                                                            WidgetSpan(child: Container(margin: EdgeInsets.only(right: 2), child: Icon(Icons.zoom_in))),
                                                            WidgetSpan(
                                                              alignment: PlaceholderAlignment.middle,
                                                              child: Text("See Detail")
                                                            )
                                                          ]
                                                        )
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                );
                              }
                            }
                            if (snapshot.docs.length >= 1 && cekData >= 1) {
                              print(1);
                              return Responsive(children: listWidget);
                            }
                            if(snapshot.docs.length <= 0 || cekData <= 0){
                              return Container(
                                height: 550,
                                child: Center(
                                  child: Text(
                                    'Project not made yet!',
                                    style: TextStyle(
                                      fontSize: 26,
                                      color: Colors.white
                                    ),
                                  )
                                ),
                              );
                            }
                          }

                          return Container(
                            height: 550,
                            child: Center(
                              child: CircularProgressIndicator()
                            ),
                          );
                        }
                      ),
                    ),
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}