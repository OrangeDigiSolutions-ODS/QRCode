import "dart:io";
import "dart:typed_data";
import "package:carousel_slider/carousel_slider.dart";
import "package:file_picker/file_picker.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:images_picker/images_picker.dart";
import "package:top_snackbar_flutter/custom_snack_bar.dart";
import "package:top_snackbar_flutter/top_snack_bar.dart";
import "package:uuid/uuid.dart";
import "/colors/colorcode.dart";
import "/components/topbar.dart";
import "/desktopview/image.dart";
import "/firebase/imageuploader.dart";

class ImageToQr extends StatefulWidget {
  const ImageToQr({Key? key}) : super(key: key);

  @override
  _ImageToQrState createState() => _ImageToQrState();
}

class _ImageToQrState extends State<ImageToQr> {
  Uuid uuid = const Uuid();
  List<String> path1 = <String>[];
  List<Media>? res;
  List<Uint8List> path2 = <Uint8List>[];
  @override
  Widget build(BuildContext context) => SafeArea(
    child: LayoutBuilder(
          builder: (_, __) {
            if (__.maxWidth < 768) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.77,
                child: Column(
                  children: <Widget>[
                    MobileView(path1: path1, path2: path2, res: res),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: <Widget>[
                          if (kIsWeb)
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: ColorCode.white,
                                    side: BorderSide(color: ColorCode.black)),
                                onPressed: multipleimage,
                                child: SizedBox(
                                    width: 250,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.insert_drive_file,
                                          color: ColorCode.black,
                                        ),
                                        Text(
                                          "Browse",
                                          style: TextStyle(
                                            color: ColorCode.black,
                                            fontSize: 18,
                                          ),
                                        )
                                      ],
                                    )))
                          else if (Platform.isAndroid)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ElevatedButton(
                                  onPressed: () async {
                                    List<String> img = <String>[];
                                    res = await ImagesPicker.openCamera(
                                      quality: 0.5,
                                      cropOpt: CropOption(),
                                    );
                                    if (res != null) {
                                      img = res!.map((_) => _.path).toList();
                                      setState(() {
                                        for (int i = 0; i < img.length; i++) {
                                          path1.add(img[i]);
                                        }
                                      });
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      side: const BorderSide(
                                        width: 0.9,
                                      ),
                                      primary: ColorCode.white,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 10),
                                      textStyle: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.camera_enhance,
                                        color: ColorCode.grey,
                                      ),
                                      Text(
                                        "Camera",
                                        style: TextStyle(color: ColorCode.grey),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      List<String> img = <String>[];
                                      res = await ImagesPicker.pick(
                                        count: 15,
                                        maxSize: 1000000,
                                        cropOpt: CropOption(),
                                      );
                                      if (res != null) {
                                        img = res!.map((_) => _.path).toList();
                                        setState(() {
                                          for (int i = 0; i < img.length; i++) {
                                            path1.add(img[i]);
                                          }
                                        });
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        side: const BorderSide(width: 0.9),
                                        primary: ColorCode.white,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 10),
                                        textStyle: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.image_outlined,
                                          color: ColorCode.grey,
                                        ),
                                        Text(
                                          "Gallery",
                                          style: TextStyle(color: ColorCode.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: ColorCode.orange),
                                  onPressed: () {
                                    if (path1.isNotEmpty) {
                                      final String v4 = uuid.v4();
                                      for (int i = 0; i < path1.length; i++) {
                                        imageUpload(v4, path1[i]);
                                      }
                                      showTopSnackBar(
                                        context,
                                        const CustomSnackBar.success(
                                          message: "File upload successfully",
                                        ),
                                      );
                                    } else if (path2.isNotEmpty) {
                                      final String v4 = uuid.v4();
                                      for (int i = 0; i < path2.length; i++) {
                                        imageUpload1(v4, path2[i]);
                                      }
                                      showTopSnackBar(
                                        context,
                                        const CustomSnackBar.success(
                                          message: "File upload successfully",
                                        ),
                                      );
                                    } else {
                                      showTopSnackBar(
                                        context,
                                        const CustomSnackBar.error(
                                          message:
                                              "Please select a image file first.",
                                        ),
                                      );
                                    }
                                  },
                                  child: Container(
                                      color: ColorCode.orange,
                                      width: 250,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            Icons.check,
                                            color: ColorCode.white,
                                          ),
                                          Text(
                                            "Create Qr",
                                            style: TextStyle(
                                              color: ColorCode.white,
                                              fontSize: 18,
                                            ),
                                          )
                                        ],
                                      )))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } 
            else {
              return const DesktopViewImage(
                title: "IMAGE TO QR CODE",
                browse: "Browse",
                generate: "Generate",
                icon1: Icons.insert_drive_file,
                icon2: Icons.check,
              );
            }
          },
        ),
  );
  FilePickerResult? bytesFromPicker;
  List<Uint8List?> img = <Uint8List?>[];
  Future<void> multipleimage() async {
    bytesFromPicker = await FilePicker.platform
        .pickFiles(allowMultiple: true, type: FileType.image);

    if (bytesFromPicker != null) {
      img =
          bytesFromPicker!.files.map((_) => _.bytes).cast<Uint8List>().toList();
      setState(() {
        for (int i = 0; i < img.length; i++) {
          path2.add(img[i]!);
        }
      });
    }
  }
}

// ignore: must_be_immutable
class MobileView extends StatefulWidget {
  MobileView({
    required this.path1,
    required this.path2,
    required this.res,
    Key? key,
  }) : super(key: key);
  List<String> path1 = <String>[];
  List<Media>? res;
  List<Uint8List> path2 = <Uint8List>[];

  @override
  _MobileViewState createState() => _MobileViewState();
}

class _MobileViewState extends State<MobileView> {
  GlobalKey<CarouselSliderState> sslKey = GlobalKey();
  @override
  Widget build(BuildContext context) => Stack(
        children: <Widget>[
          const TopBar(title: "IMAGE TO QR CODE"),
          Container(
            margin: const EdgeInsets.only(top: 100),
            child: Center(
              child: Column(
                children: <Widget>[
                  if (widget.path1.isNotEmpty)
                    Card(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.40,
                        width: MediaQuery.of(context).size.width,
                        child: slider(sslKey),
                      ),
                    )
                  else if (widget.path2.isNotEmpty)
                    Card(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.40,
                        width: MediaQuery.of(context).size.width,
                        child: slider1(sslKey),
                      ),
                    )
                  else
                    Image.asset(
                      "assets/images/img2.png",
                      height: MediaQuery.of(context).size.height * 0.40,
                      width: MediaQuery.of(context).size.width,
                    ),
                  Text(
                    "Image Preview",
                    style: TextStyle(
                      color: ColorCode.black,
                      fontSize: 20,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );

  Widget slider(GlobalKey<CarouselSliderState> sslkey) => SizedBox(
      height: MediaQuery.of(context).size.height * 0.40,
      width: MediaQuery.of(context).size.width * 0.40,
      child: CarouselSlider.builder(
        options: CarouselOptions(
          enableInfiniteScroll: false,
          viewportFraction: 0.9,
          aspectRatio: 1,
        ),
        itemCount: widget.path1.length,
        key: sslkey,
        itemBuilder: (_, __, ___) => Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.38,
              width: MediaQuery.of(context).size.width,
              child: Stack(children: <Widget>[
                Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          child: Image.file(
                            File(widget.path1[___]),
                            height: MediaQuery.of(context).size.height * 0.40,
                            width: MediaQuery.of(context).size.width * 0.40,
                          ),
                        ),
                      ]),
                ),
                Container(
                  alignment: Alignment.topRight,
                  margin: const EdgeInsets.fromLTRB(0, 20, 20, 0),
                  child: IconButton(
                      onPressed: () {
                        debugPrint("${widget.path1.length}");
                        setState(() {
                          widget.path1.remove(widget.path1[__]);
                        });
                      },
                      icon: const Icon(Icons.close)),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: IconButton(
                      onPressed: () {
                        sslkey.currentState!.pageController!.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.linear);
                      },
                      icon: const Icon(Icons.keyboard_arrow_left)),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: IconButton(
                      onPressed: () {
                        sslkey.currentState!.pageController!.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.linear);
                      },
                      icon: const Icon(Icons.keyboard_arrow_right)),
                ),
              ]),
            ),
          ],
        ),
      ));

  Widget slider1(GlobalKey<CarouselSliderState> sslkey) => SizedBox(
      height: MediaQuery.of(context).size.height * 0.40,
      width: MediaQuery.of(context).size.width * 0.40,
      child: CarouselSlider.builder(
        options: CarouselOptions(
          enableInfiniteScroll: false,
          viewportFraction: 0.9,
          aspectRatio: 1,
        ),
        itemCount: widget.path2.length,
        key: sslkey,
        // carouselController: _controller,
        itemBuilder: (_, __, ___) => Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.38,
              width: MediaQuery.of(context).size.width,
              child: Stack(children: <Widget>[
                Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          child: Image.memory(
                            widget.path2[___],
                            height: MediaQuery.of(context).size.height * 0.40,
                            width: MediaQuery.of(context).size.width * 0.40,
                          ),
                        ),
                      ]),
                ),
                Container(
                  alignment: Alignment.topRight,
                  margin: const EdgeInsets.fromLTRB(0, 20, 20, 0),
                  child: IconButton(
                      onPressed: () {
                        debugPrint("${widget.path2.length}");
                        setState(() {
                          widget.path2.remove(widget.path2[__]);
                        });
                      },
                      icon: const Icon(Icons.close)),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: IconButton(
                      onPressed: () {
                        sslkey.currentState!.pageController!.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.linear);
                      },
                      icon: const Icon(Icons.keyboard_arrow_left)),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: IconButton(
                      onPressed: () {
                        sslkey.currentState!.pageController!.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.linear);
                      },
                      icon: const Icon(Icons.keyboard_arrow_right)),
                ),
              ]),
            ),
          ],
        ),
      ));
}




















































// import "dart:io";
// import "package:carousel_slider/carousel_options.dart";
// import "package:carousel_slider/carousel_slider.dart";
// import "package:flutter/material.dart";
// import "package:images_picker/images_picker.dart";
// import "package:top_snackbar_flutter/custom_snack_bar.dart";
// import "package:top_snackbar_flutter/top_snack_bar.dart";
// import "package:uuid/uuid.dart";
// import "/colors/colorcode.dart";
// import "/components/topbar.dart";
// import "/firebase/imageuploader.dart";

// class ImageToQr extends StatefulWidget {
//   const ImageToQr({Key? key}) : super(key: key);

//   @override
//   _ImageToQrState createState() => _ImageToQrState();
// }

// class _ImageToQrState extends State<ImageToQr> {
//   Uuid uuid = const Uuid();
//   List<String> path1 = <String>[];
//   List<Media>? res;
//   GlobalKey<CarouselSliderState> sslKey = GlobalKey();

//   @override
//   Widget build(BuildContext context) => Expanded(
//       flex: 5,
//       child: SizedBox(
//         height: MediaQuery.of(context).size.height * 0.75,
//         child: Column(
//           children: <Widget>[
//             Stack(
//               children: <Widget>[
//                 const TopBar(title: "IMAGE TO QR CODE"),
//                 Container(
//                   margin: const EdgeInsets.only(top: 100),
//                   child: Center(
//                     child: Column(
//                       children: <Widget>[
//                         if (path1.isNotEmpty)
//                           SizedBox(
//                             height: MediaQuery.of(context).size.height * 0.40,
//                             width: MediaQuery.of(context).size.width,
//                             child: slider(sslKey),
//                           )
//                         else
//                           Image.asset(
//                             "assets/images/img1.jpg",
//                             height: MediaQuery.of(context).size.height * 0.40,
//                             width: MediaQuery.of(context).size.width,
//                           ),
//                         Text(
//                           "Image Preview",
//                           style: TextStyle(
//                             color: ColorCode.black,
//                             fontSize: 20,
//                             decoration: TextDecoration.none,
//                             fontWeight: FontWeight.normal,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8),
//               child: Column(
//                 children: <Widget>[
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       ElevatedButton(
//                         onPressed: () async {
//                           List<String> img = <String>[];
//                           res = await ImagesPicker.openCamera(
//                             quality: 0.5,
//                             cropOpt: CropOption(),
//                           );
//                           if (res != null) {
//                             img = res!.map((_) => _.path).toList();
//                             setState(() {
//                               for (int i = 0; i < img.length; i++) {
//                                 path1.add(img[i]);
//                               }
//                             });
//                           }
//                         },
//                         style: ElevatedButton.styleFrom(
//                             side: const BorderSide(
//                               width: 0.9,
//                             ),
//                             primary: ColorCode.white,
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 30, vertical: 10),
//                             textStyle: const TextStyle(
//                                 fontSize: 16, fontWeight: FontWeight.bold)),
//                         child: Row(
//                           children: <Widget>[
//                             Icon(
//                               Icons.camera_enhance,
//                               color: ColorCode.grey,
//                             ),
//                             Text(
//                               "Camera",
//                               style: TextStyle(color: ColorCode.grey),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                       GestureDetector(
//                         child: ElevatedButton(
//                           onPressed: () async {
//                             List<String> img = <String>[];
//                             res = await ImagesPicker.pick(
//                               count: 15,
//                               maxSize: 1000000,
//                               cropOpt: CropOption(),
//                             );
//                             if (res != null) {
//                               img = res!.map((_) => _.path).toList();
//                               setState(() {
//                                 for (int i = 0; i < img.length; i++) {
//                                   path1.add(img[i]);
//                                 }
//                               });
//                             }
//                           },
//                           style: ElevatedButton.styleFrom(
//                               side: const BorderSide(width: 0.9),
//                               primary: ColorCode.white,
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 30, vertical: 10),
//                               textStyle: const TextStyle(
//                                   fontSize: 16, fontWeight: FontWeight.bold)),
//                           child: Row(
//                             children: <Widget>[
//                               Icon(
//                                 Icons.image_outlined,
//                                 color: ColorCode.grey,
//                               ),
//                               Text(
//                                 "Gallery",
//                                 style: TextStyle(color: ColorCode.grey),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                               primary: ColorCode.orange),
//                           onPressed: () {
//                             if (path1.isNotEmpty) {
//                               final String v4 = uuid.v4();
//                               for (int i = 0; i < path1.length; i++) {
//                                 imageUpload(v4, path1[i]);
//                               }
//                               showTopSnackBar(
//                                 context,
//                                 const CustomSnackBar.success(
//                                   message: "File upload successfully",
//                                 ),
//                               );
//                             } else {
//                               showTopSnackBar(
//                                 context,
//                                 const CustomSnackBar.error(
//                                   message: "Please select a image file first.",
//                                 ),
//                               );
//                             }
//                           },
//                           child: Expanded(
//                             child: Container(
//                                 color: ColorCode.orange,
//                                 width: 250,
//                                 // width: MediaQuery.of(context).size.width * 0.66,
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: <Widget>[
//                                     Icon(
//                                       Icons.check,
//                                       color: ColorCode.white,
//                                     ),
//                                     Text(
//                                       "Create Qr",
//                                       style: TextStyle(
//                                         color: ColorCode.white,
//                                         fontSize: 18,
//                                       ),
//                                     )
//                                   ],
//                                 )),
//                           ))
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );

//   Widget slider(GlobalKey<CarouselSliderState> sslkey) =>
//       CarouselSlider.builder(
//         options: CarouselOptions(
//           enableInfiniteScroll: false,
//           viewportFraction: 0.9,
//           aspectRatio: 1,
//         ),
//         itemCount: path1.length,
//         key: sslkey,
//         // carouselController: _controller,
//         itemBuilder: (BuildContext context, int index, int pageViewIndex) =>
//             Column(
//           children: <Widget>[
//             SizedBox(
//               height: MediaQuery.of(context).size.height * 0.38,
//               width: MediaQuery.of(context).size.width,
//               child: Stack(children: <Widget>[
//                 Center(
//                   child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         GestureDetector(
//                           child: Image.file(
//                             File(path1[pageViewIndex]),
//                             // fit: BoxFit.contain,
//                             height: MediaQuery.of(context).size.height * 0.40,
//                             width: MediaQuery.of(context).size.width * 0.40,
//                           ),
//                         ),
//                       ]),
//                 ),
//                 Container(
//                   alignment: Alignment.topRight,
//                   margin: const EdgeInsets.fromLTRB(0, 20, 20, 0),
//                   child: IconButton(
//                       onPressed: () {
//                         debugPrint("${path1.length}");
//                         setState(() {
//                           path1.remove(path1[index]);
//                         });
//                       },
//                       icon: const Icon(Icons.close)),
//                 ),
//                 Container(
//                   alignment: Alignment.centerLeft,
//                   margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
//                   child: IconButton(
//                       onPressed: () {
//                         sslkey.currentState!.pageController!.previousPage(
//                             duration: const Duration(milliseconds: 300),
//                             curve: Curves.linear);
//                       },
//                       icon: const Icon(Icons.keyboard_arrow_left)),
//                 ),
//                 Container(
//                   alignment: Alignment.centerRight,
//                   margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
//                   child: IconButton(
//                       onPressed: () {
//                         sslkey.currentState!.pageController!.nextPage(
//                             duration: const Duration(milliseconds: 300),
//                             curve: Curves.linear);
//                       },
//                       icon: const Icon(Icons.keyboard_arrow_right)),
//                 ),
//               ]),
//             ),
//           ],
//         ),
//       );
// }
