import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' as android;
import 'package:flutter/material.dart';
import 'package:images_picker/images_picker.dart';
import 'package:qrcode/screen/category.dart';

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
  List<Media>? res;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 18),
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: double.infinity,
                    color: Color(0xff353535),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          height: 43,
                          width: 43,
                        ),
                        SizedBox(
                          width: 18,
                        ),
                        Text(
                          "Image To Qr Code",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 90.0),
                    child: Center(
                      child: Column(
                        children: [
                          path1 != null
                              ? Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.40,
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView.builder(
                                      itemCount: res!.length,
                                      scrollDirection: Axis.horizontal,
                                      // itemCount: images123!.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        imageUpload(
                                            android.File(path1![index]));
                                        return Column(
                                          children: [
                                            Image.file(
                                              android.File(path1![index]),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.35,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            )
                                          ],
                                        );
                                      }),
                                )
                              : Image.asset(
                                  "assets/images/img1.jpg",
                                  height:
                                      MediaQuery.of(context).size.height * 0.40,
                                  width: MediaQuery.of(context).size.width,
                                ),
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
                        // ElevatedButton.icon(
                        //   onPressed: () async {
                        //     res = await ImagesPicker.openCamera(
                        //       pickType: PickType.image,
                        //       quality: 0.5,
                        //     );
                        //     if (res != null) {
                        //       setState(() {
                        //         path1 = res!.map((e) => e.path).toList();
                        //       });
                        //     }
                        //   },
                        //   icon: Icon(Icons.camera_enhance),
                        //   label: Text("Camera"),
                        //   style: ElevatedButton.styleFrom(
                        //       side: BorderSide(width: 0.9, color: Colors.black),
                        //       primary: Colors.white,
                        //       padding: EdgeInsets.symmetric(
                        //           horizontal: 30, vertical: 10),
                        //       textStyle: TextStyle(
                        //           fontSize: 16, fontWeight: FontWeight.bold)),
                        // ),
                        // SizedBox(
                        //   width: 10,
                        // ),
                        ElevatedButton.icon(
                          onPressed: () async {
                            print("hello");
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
                          },
                          icon: Icon(Icons.photo_camera_back_outlined),
                          label: Text("Gallery"),
                          style: ElevatedButton.styleFrom(
                              side: BorderSide(width: 0.9, color: Colors.black),
                              primary: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              textStyle: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // ElevatedButton(
                        //     style: ElevatedButton.styleFrom(
                        //         primary: Color(0xffDD4C00)),
                        //     onPressed: () {},
                        //     child: Expanded(
                        //       flex: 1,
                        //       child: Container(
                        //           color: Color(0xffDD4C00),
                        //           width:
                        //               MediaQuery.of(context).size.width * .66,
                        //           child: Row(
                        //             mainAxisAlignment: MainAxisAlignment.center,
                        //             children: [
                        //               Icon(
                        //                 Icons.check,
                        //                 color: Colors.white,
                        //               ),
                        //               Text(
                        //                 "Create Qr",
                        //                 style: TextStyle(
                        //                   color: Colors.white,
                        //                   fontSize: 18,
                        //                 ),
                        //               )
                        //             ],
                        //           )),
                        //     ))
                      ],
                    ),
                  ],
                ),
              ),
              // Row(
              //   children: [
              Container(
                  alignment: Alignment.bottomCenter, child: ButtonOptions())
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
              // ],
              // )
            ],
          ),
        ),
      ),
    );
  }

  int i = 0;
  List<String> durl = [];
  Map<String, String> all = {};
  Future imageUpload(images) async {
    List image = [];
    image.add(images);
    Reference firebaseStorage =
        FirebaseStorage.instance.ref().child("$dateToday").child("$i");
    UploadTask uploadTask;
    i++;
    for (var img in image) {
      uploadTask = firebaseStorage.putFile(img);
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
            .set(all);
      });

      print(dateToday);
      return all;
      // String url = dowUrl.toString();
      // print(url);

    }
  }
}
