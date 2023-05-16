import "package:firebase_database/firebase_database.dart";
import "package:firebase_database/ui/firebase_animated_list.dart";
import "package:firebase_storage/firebase_storage.dart";
import "package:firebase_ui_database/firebase_ui_database.dart";
import "package:flutter/material.dart";
import "package:flutter_easyloading/flutter_easyloading.dart";
import "package:flutter_profile/Admin/Pages/media/mediaUpdate.dart";
import "package:responsive_ui/responsive_ui.dart";
import "package:shimmer/shimmer.dart";
import "package:url_launcher/url_launcher.dart";

import '../../../Controller/controller.dart';

class MediaPage extends StatefulWidget {
  const MediaPage({super.key});

  @override
  State<MediaPage> createState() => _MediaPageState();
}

class _MediaPageState extends State<MediaPage> {
  DatabaseReference db_media =
      FirebaseDatabase.instance.ref().child('medias');
  var shim = true;
  var perPageSelected = 10;
    
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
      child: Column(
        children: [
          FirebaseDatabaseQueryBuilder(
            query: db_media,
            builder: (context, snapshot, _) {
              if(snapshot.hasData){
                var data = snapshot.docs;
                List<Widget> listWidget = [];
                return Theme(
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
                  child: Container(
                    margin: EdgeInsets.only(right: 70,left: 15,top: 15,bottom: 15),
                    child: TableMedia(data,db_media)
                    )
                  );
              }else{
                return Shimmer.fromColors(
                  baseColor: Colors.grey,
                  highlightColor: Colors.grey.shade100,
                  enabled: shim,
                  child: Container(
                    margin: EdgeInsets.only(right: 70,left: 15,top: 15,bottom: 15),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: Colors.white
                    ),
                    child: Text('s'),
                  ),
                );
              }
            }
          ),
        ],
      ),
    );
  }
  PaginatedDataTable TableMedia(dynamic list, db_media) {
    return PaginatedDataTable(
      arrowHeadColor: Colors.white,
      header: Text("Table User Masyarakat"),
      onRowsPerPageChanged: (perPage) {
        setState(() {
          perPageSelected = perPage!;
          // perPageSelectedOnChange = perPage;
        });
      },
      columnSpacing: 50,
      rowsPerPage: perPageSelected,
      columns: <DataColumn>[
        DataColumn(
          label: Text('No'),
        ),
        DataColumn(
          label: Text('Image'),
        ),
        DataColumn(
          label: Text('Link'),
        ),
        DataColumn(
          label: Text('Action'),
        ),
      ],
      source: MyData(data: list,db:db_media,context: context),
    );
  }
}
class MyData extends DataTableSource {
  MyData({required this.data, required this.db,required this.context});
  final dynamic data;
  final dynamic db;
  final BuildContext context;
  
  @override
  DataRow? getRow(int index) {
    if(index >= data.length){
      return null;
    }
    final uid = data[index].key;
    final d = data[index].value as Map<String,dynamic>;
    return DataRow(cells: [
      DataCell(Text("${index + 1}")),
      DataCell(
        Image.network(
          "${d['image']}",
          width: 50,
        )
      ),
      DataCell(Text(d['link'])),
      DataCell(
        Row(
          children: [
            Tooltip(
              message: "Update data",
              child: IconButton(
                icon: Icon(
                  Icons.note_alt_outlined,
                  color: Colors.yellow[900],
                ),
                onPressed: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context) => MediaUpdate(uid: uid,)));
                },
              ),
            ),
            Tooltip(
              message: "Delete data",
              child: IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.red[900],
                ),
                onPressed: () {
                  delete(context,uid,db,d['image']);
                },
              ),
            ),
          ],
        )
      ),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;

  void delete(BuildContext context,String uid,DatabaseReference db_Ref,String image) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text('Please Confirm'),
          content: const Text('Are you sure want to delete?'),
          actions: [
            // The "Yes" button
            TextButton(
              onPressed: () async {
                db_Ref.child(uid).remove();
                final del = FirebaseStorage.instance.refFromURL(image);
                await del.delete();
                
                Navigator.of(context).pushReplacementNamed("/admin/media");
                EasyLoading.showSuccess('Succesfully delete data',dismissOnTap: true);
              },
              child: const Text('Yes')
            ),
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pushReplacementNamed("/admin/media");
              },
              child: const Text('No')
            )
          ],
        );
      }
    );
  }
}