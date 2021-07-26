import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewImages extends StatefulWidget {
  final datetime;
  ViewImages({Key? key, required this.datetime}) : super(key: key);

  @override
  _ViewImagesState createState() => _ViewImagesState(datetime);
}

class _ViewImagesState extends State<ViewImages> {
  CollectionReference images = FirebaseFirestore.instance.collection('images');
  var datetime;
  _ViewImagesState(this.datetime);
  @override
  Widget build(BuildContext context) {
    print(datetime);
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder<DocumentSnapshot>(
        future: images.doc('$datetime').get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          List itemabx = [];
          List amit = [];
          if (snapshot.connectionState == ConnectionState.done) {
            int data = snapshot.data!['image'];
            print(data);
            return
                // ignore: unnecessary_null_comparison
                data != null
                    ? FutureBuilder(
                        future: images
                            .doc("$datetime")
                            .collection("value")
                            .doc('links')
                            .get(),
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            Map<String, dynamic> data1 =
                                snapshot.data!.data() as Map<String, dynamic>;
                            amit = data1.values.toList();
                            for (int item = 0; item < data; item++) {
                              itemabx.add(item);
                              print(itemabx.length);
                            }
                            return
                                // ignore: unnecessary_null_comparison
                                data1 != null
                                    ? Container(
                                        child: ListView.builder(
                                            itemCount: itemabx.length,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                  color: Colors.white,
                                                  child: Column(
                                                    children: [
                                                      Image.network(
                                                        "${amit[index]}",alignment: Alignment.center,fit: BoxFit.fill,
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      )
                                                    ],
                                                  ));

                                              // Image.network("${amit[index]}");
                                            }),
                                      )
                                    : SizedBox.shrink();
                          }
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        })
                    : Image.asset("assets/image.png");
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
