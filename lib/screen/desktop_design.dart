// import 'dart:ui';

// import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:qrcode/screen/category.dart';
import 'package:qrcode/screen/topNavbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DesktopDesign extends StatefulWidget {
  const DesktopDesign({Key? key}) : super(key: key);

  @override
  _DesktopDesignState createState() => _DesktopDesignState();
}

class _DesktopDesignState extends State<DesktopDesign> {
  List? path1;
  DateTime dateToday = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      DateTime.now().hour,
      DateTime.now().minute,
      DateTime.now().second,
      DateTime.now().millisecond,
      DateTime.now().microsecond);
  bool success = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Expanded(flex: 1, child: TopNavBar()),
          Expanded(
            flex: 5,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30),
              child: Container(
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0)),
                          child: path1 != null
                              ? Container(
                                
                                  height:
                                      MediaQuery.of(context).size.height * 0.50,
                                  width:
                                      MediaQuery.of(context).size.width * 0.30,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: path1!.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Column(
                                          children: [
                                            Image.memory(
                                              path1![index],
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.40,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.30,
                                            ),
                                          ],
                                        );
                                      }),
                                )
                              : Image.asset(
                                  "assets/images/img2.png",
                                  height:
                                      MediaQuery.of(context).size.height * 0.40,
                                  width:
                                      MediaQuery.of(context).size.height * 0.40,
                                ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 7.0),
                          child: Builder(builder: (context) {
                            String imtext;
                            if (path1 == null) {
                              imtext = "Image Preview";
                            } else {
                              imtext = "<-- swipe -->";
                            }
                            return Text("$imtext");
                          }),
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.10,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 18.0),
                      child: Container(
                        height:MediaQuery.of(context).size.height * 0.70,
                        width: MediaQuery.of(context).size.width * 0.50,
                        alignment: Alignment.center,
                        child: Column(
                            // mainAxisAlignment: MainAxisAlignment.end,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.40,
                                width: MediaQuery.of(context).size.width ,
                                // constraints: BoxConstraints(
                                //     maxWidth: MediaQuery.of(context).size.width,
                                //     maxHeight:
                                //         MediaQuery.of(context).size.height),
                                margin: EdgeInsets.only(top: 20),
                                child: AutoSizeText(
                                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Iaculis at sed facilisis duis hac laoreet ipsum malesuada enim. Suspendisse pulvinar at iaculis urna integer ultrices sagittis rhoncus. Euismod faucibus vitae sed asdfsdafasdfasdfasdfasdfasdfasdfkfbasdkljhsdjlkafhljajs;hdflasdhuhjskldbfgfahflskjfhadsljfhlfhladsfhladshflkashflkahflhf;la;dfhaldfhlf suspendisse fames. Urna dictum aliquam donec semper.",
                                  overflow: TextOverflow.clip,
                                  // maxLines: 10,
                                  minFontSize: 20.0,
                                  // wrapWords: true,
                                  // softWrap: true,
                                  
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width ,
                                height: MediaQuery.of(context).size.height *
                                            0.04,
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  // crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 35, vertical: 10),
                                          primary: Colors.white,
                                          side: BorderSide(
                                              color: HexColor("#b0afae"))
                                          ),
                                     
                                      onPressed: () => multipleimage(),
                                      child: Container(
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.insert_drive_file,
                                            ),
                                            Text("Browse",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: HexColor("#000000"))),
                                          ],
                                        ),
                                      ),
                                      
                                    ),
                                    SizedBox(
                                        width: 10),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 35, vertical: 10),
                                          primary: Color(0xffDD4C00)
                            
                                          ),
                                      onPressed: () {
                                        if (path1 != null) {
                                          for (int i = 0;
                                              i < path1!.length;
                                              i++) {
                                            imageUpload1(path1![i], dateToday)
                                                .whenComplete(() {
                                              setState(() {
                                                success = true;
                                              });
                                            });
                                          }
                                        } else {
                                          print("no image selected");
                                        }
                                      },
                                      child: Container(
                                        child: Row(
                                          children: [
                                            Icon(Icons.check,
                                                color: HexColor("#ffffff")),
                                            Text("Generate",
                                                
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: HexColor("#ffffff")))
                                          ],
                                        ),
                                      ),
                                    ),
                                    success == true
                                        ? Text("upload successful")
                                        : SizedBox.shrink(),
                                  ],
                                ),
                              )
                            ]),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: Container(
                child: ButtonOptions(),
              ))
        ],
      )),
    );
  }

  Future<void> multipleimage() async {
    FilePickerResult? bytesFromPicker = await FilePicker.platform
        .pickFiles(allowMultiple: true, type: FileType.image);

    if (bytesFromPicker != null) {
      setState(() {
        path1 = bytesFromPicker.files.map((e) => e.bytes).toList();
      });
    }
  }

  int iii = 0;
  List<String> durl = [];
  Map<String, String> all = {};
  String downUrl = "";
  Future imageUpload1(images, dateToday) async {
    // print(images.length);
    List image = [];
    image.add(await images);

    Reference firebaseStorage =
        FirebaseStorage.instance.ref().child("$dateToday").child("$iii.png");
    UploadTask uploadTask;
    iii++;
    for (var img in image) {
      final metadata = SettableMetadata(contentType: 'image/jpeg');
      uploadTask = firebaseStorage.putData(img, metadata);
      await uploadTask.whenComplete(() async {
        downUrl = await firebaseStorage.getDownloadURL();
        durl.add(downUrl);
      });

      for (int ii = 0; ii < durl.length; ii++) {
        all.addAll({"$ii": durl[ii]});

        // print(all);
      }

      await FirebaseFirestore.instance
          .collection("images")
          .doc("$dateToday")
          .collection("value")
          .doc("links")
          .set(all);
      await FirebaseFirestore.instance
          .collection("images")
          .doc("$dateToday")
          .set({"image": iii});
      String date = dateToday.toString();
      String replacesp = date.replaceAll(" ", "%20");
      String replaceo = replacesp.replaceAll(":", "%3A");
      await FirebaseFirestore.instance
          .collection("id")
          .doc("$replaceo")
          .set({"datetime": "$dateToday"});
    }
  }
}
