import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'dart:io' as android;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:images_picker/images_picker.dart';
// import 'package:qrcode/screen/bottom_navigation.dart';
import 'package:qrcode/screen/category.dart';
import 'package:qrcode/screen/desktop_design.dart';
import 'package:qrcode/screen/topNavbar.dart';

import 'imageUpload.dart';
import 'view.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  DateTime dateToday = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      DateTime.now().hour,
      DateTime.now().minute,
      DateTime.now().second,
      DateTime.now().millisecond,
      DateTime.now().microsecond);
  List? path1;
  List? path2;
  List<Media>? res;
  bool? success;
  String? upload;
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 850) {
              return OrientationBuilder(
                builder: (BuildContext context, Orientation orientation) {
                  return Container(
                    child: FrontPageMobileView(context),
                  );
                },
              );
            } else {
              return DesktopDesign();
            }
          },
        )
            //  ,
            ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  FrontPageMobileView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Stack(
          children: [
            TopNavBar(),
            Container(
              margin: EdgeInsets.only(top: 90.0),
              child: Center(
                child: Column(
                  children: [
                    path1 != null
                        ? Container(
                            height: MediaQuery.of(context).size.height * 0.40,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                                itemCount: res!.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  // imageUpload(android.File(path1![index]));
                                  return Column(
                                    children: [
                                      Image.file(
                                        android.File(path1![index]),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.35,
                                        width:
                                            MediaQuery.of(context).size.width,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      )
                                    ],
                                  );
                                }),
                          )
                        : SizedBox.shrink(),
                    path2 != null
                        ? Container(
                            height: MediaQuery.of(context).size.height * 0.40,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                                itemCount: path2!.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  // print(path2![index]);
                                  return Column(
                                    children: [
                                      Image.memory(
                                        path2![index],
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.35,
                                        width:
                                            MediaQuery.of(context).size.width,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      )
                                    ],
                                  );
                                }),
                          )
                        : SizedBox.shrink(),
                    path1 == null && path2 == null
                        ? Container(
                            height: MediaQuery.of(context).size.height * 0.40,
                            width: MediaQuery.of(context).size.width,
                            child: Image.asset("assets/images/img2.png"))
                        : SizedBox.shrink(),
                    Text(
                      "Image Preview",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  kIsWeb==false?
                  ElevatedButton.icon(
                    onPressed: () async {
                      res = await ImagesPicker.openCamera(
                        pickType: PickType.image,
                        quality: 0.5,
                      );
                      if (res != null) {
                        setState(() {
                          path1 = res!.map((e) => e.path).toList();
                        });
                      }
                    },
                    icon: Icon(Icons.camera_enhance),
                    label: Text("Camera"),
                    style: ElevatedButton.styleFrom(
                        side: BorderSide(width: 0.9, color: Colors.black),
                        primary: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        textStyle: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ):SizedBox.shrink(),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      if (kIsWeb) {
                        multipleimage();
                      } else if (android.Platform.isAndroid) {
                        res = await ImagesPicker.pick(
                          count: 15,
                          pickType: PickType.image,
                          language: Language.System,
                          // maxSize: 500,
                          cropOpt: CropOption(
                            aspectRatio: CropAspectRatio.custom,
                          ),
                        );
                        if (res != null) {
                          print(res!.map((e) => e.path).toList());
                          setState(() {
                            // path = res[0].thumbPath;
                            path1 = res!.map((e) => e.path).toList();
                            print("helooo $path1");
                          });
                        }
                      }
                    },
                    icon: Icon(Icons.photo_camera_back_outlined),
                    label: kIsWeb==false? 
                    Text("Gallery"):Text("Browse"),
                    style: ElevatedButton.styleFrom(
                        side: BorderSide(width: 0.9, color: Colors.black),
                        primary: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        textStyle: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: Color(0xffDD4C00)),
                      onPressed: () {
                        if (kIsWeb) {
                          if (path2 != null) {
                            setState(() {
                              success = false;
                            });
                            if (upload == "View") {
                              for (int i = 0; i < path2!.length; i++) {
                                imageUpload1(path2![i], dateToday)
                                    .whenComplete(() {
                                  setState(() {
                                    success = true;
                                  });
                                });
                              }
                            } else if (upload == "success") {
                              setState(() {
                                success = true;
                              });
                            }
                          } else {
                            print("no image selected");
                          }
                        } else if (android.Platform.isAndroid) {
                          if (path1 != null) {
                            setState(() {
                              success = false;
                            });
                             if (upload == "View") {
                            for (int i = 0; i < path1!.length; i++) {
                              imageUpload(android.File(path1![i]))
                                  .whenComplete(() {
                                setState(() {
                                  success = true;
                                  print("success");
                                });
                              });
                            }
                          } else if (upload == "success") {
                              setState(() {
                                success = true;
                              });
                            }
                          }else {
                            print("no image selected");
                          }
                        }
                      },
                      child: Container(
                          color: Color(0xffDD4C00),
                          width: MediaQuery.of(context).size.width * 0.66,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.check,
                                color: Colors.white,
                              ),
                              Builder(builder: (context) {
                                if (success == true) {
                                  upload = "success";
                                  Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ViewImages(datetime: dateToday);
                          }));
                                } else if (success == false) {
                                  upload = "waiting....";
                                } else {
                                  upload = "View";
                                }
                                return Text(
                                  "$upload",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                );
                              }),
                            ],
                          )))
                ],
              ),
            ],
          ),
        ),
        // Row(
        //   children: [
        Container(alignment: Alignment.bottomCenter, child: ButtonOptions())
//                   Expanded(
//                     child: Container(
//                       width: MediaQuery.of(context).size.width,
//                       height: MediaQuery.of(context).size.height * .163,
//                       color: HexColor("#C6C6C6"),
//                       child: ListView(scrollDirection: Axis.horizontal,
//                         children: [
//                           Container(
//                             child: Text("Utkarsh"),
//                             width: MediaQuery.of(context).size.width *0.45,
//                             color: Colors.red,
//                           ),
//                           SizedBox(
// width: MediaQuery.of(context).size.width *0.1 ,
//                           ),
//                           Container(
//                             width: MediaQuery.of(context).size.width *0.45,
//                             child: Text("Utkarsh"),
//                             color: Colors.yellow,
//                           ),
//                         ],
//                       ),
//                     ),
//                   )
//         ],
//         )
      ],
    );
  }

  int iii = 0;
  List<String> durl = [];
  Map<String, String> all = {};
  Future imageUpload(images) async {
    List image = [];
    image.add(await images);
    print(image.length);
    Reference firebaseStorage =
        FirebaseStorage.instance.ref().child("$dateToday").child("$iii.png");
    UploadTask uploadTask;
    iii++;
    for (var img in image) {
      uploadTask = firebaseStorage.putFile(img);
      print("${image.length} $iii");
      // print(firebaseStorage.putFile(img));
      await uploadTask.whenComplete(() async {
        String downUrl = await firebaseStorage.getDownloadURL();
        durl.add(downUrl);
        print("hello1234 $durl");
        print(all.length);
        for (int ii = 0; ii < durl.length; ii++) {
          all.addAll({"$ii": durl[ii]});
          print(all);
        }

        await FirebaseFirestore.instance
            .collection("images")
            .doc("$dateToday")
            .collection("value")
            .doc("links")
            .set(all);
        print("helooooooo $iii");
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
      });
    }
  }

  Future<void> multipleimage() async {
    FilePickerResult? bytesFromPicker = await FilePicker.platform
        .pickFiles(allowMultiple: true, type: FileType.image);
    // await ImagePickerWeb.getMultiImages(outputType: ImageType.bytes);

    if (bytesFromPicker != null) {
      setState(() {
        path2 = bytesFromPicker.files.map((e) => e.bytes).toList();
      });
    }
  }
}
