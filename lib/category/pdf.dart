import "dart:io";
import "dart:typed_data";
import "package:file_picker/file_picker.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:syncfusion_flutter_pdfviewer/pdfviewer.dart";
import "package:top_snackbar_flutter/custom_snack_bar.dart";
import "package:top_snackbar_flutter/top_snack_bar.dart";
import "package:uuid/uuid.dart";
import "/colors/colorcode.dart";
import "/components/topbar.dart";
import "/desktopview/pdf.dart";
import "/firebase/pdfuploader.dart";

class PdfToQr extends StatefulWidget {
  const PdfToQr({Key? key}) : super(key: key);

  @override
  _PdfToQrState createState() => _PdfToQrState();
}

class _PdfToQrState extends State<PdfToQr> {
  Uint8List? path1;
  File? path2;
  Uuid uuid = const Uuid();

  @override
  Widget build(BuildContext context) => LayoutBuilder(builder: (_, __) {
        if (__.maxWidth < 768) {
          return Expanded(
            flex: 5,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.77,
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      const TopBar(title: "PDF TO QR CODE"),
                      Container(
                        margin: const EdgeInsets.only(top: 100),
                        child: Center(
                          child: Column(
                            children: <Widget>[
                              if (path1 != null || path2 != null)
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.40,
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      children: <Widget>[
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.35,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.40,
                                            child: Stack(
                                              children: <Widget>[
                                                if (path1 != null)
                                                  SfPdfViewer.memory(
                                                    path1!,
                                                    enableDoubleTapZooming:
                                                        false,
                                                  )
                                                else
                                                  const SizedBox.shrink(),
                                                if (path2 != null)
                                                  SfPdfViewer.file(
                                                    path2!,
                                                    enableDoubleTapZooming:
                                                        false,
                                                  )
                                                else
                                                  const SizedBox.shrink()
                                              ],
                                            )),
                                      ],
                                    ))
                              else
                                Image.asset(
                                  "assets/images/img2.png",
                                  height:
                                      MediaQuery.of(context).size.height * 0.40,
                                  width: MediaQuery.of(context).size.width,
                                ),
                              Text(
                                "PDF Preview",
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
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ElevatedButton(
                              onPressed: () async {
                                if (kIsWeb) {
                                  final FilePickerResult? bytesFromPicker =
                                      await FilePicker.platform.pickFiles(
                                          type: FileType.custom,
                                          allowedExtensions: <String>["pdf"]);
                                  final PlatformFile file =
                                      bytesFromPicker!.files.first;
                                  if (file.size < 10240000) {
                                    if (bytesFromPicker.isSinglePick) {
                                      setState(() {
                                        showTopSnackBar(
                                          context,
                                          const CustomSnackBar.success(
                                            message:
                                                "File selected successfully",
                                          ),
                                        );
                                        final List<Uint8List?> res =
                                            bytesFromPicker.files
                                                .map((_) => _.bytes)
                                                .toList();
                                        path1 = res.first!.buffer.asUint8List();
                                      });
                                    }
                                  } else {
                                    setState(() {
                                      showTopSnackBar(
                                        context,
                                        const CustomSnackBar.error(
                                          message:
                                              "Please select a file less than 10 mb",
                                        ),
                                      );
                                    });
                                  }
                                } else if (Platform.isAndroid) {
                                  final FilePickerResult? bytesFromPicker =
                                      await FilePicker.platform.pickFiles(
                                          type: FileType.custom,
                                          allowedExtensions: <String>["pdf"]);
                                  final PlatformFile file =
                                      bytesFromPicker!.files.first;
                                  if (file.size < 10240000) {
                                    if (bytesFromPicker.isSinglePick) {
                                      setState(() {
                                        showTopSnackBar(
                                          context,
                                          const CustomSnackBar.success(
                                            message:
                                                "File selected successfully",
                                          ),
                                        );
                                        final File file1 = File(file.path!);
                                        setState(() {
                                          path2 = file1;
                                        });
                                      });
                                    }
                                  } else {
                                    setState(() {
                                      showTopSnackBar(
                                        context,
                                        const CustomSnackBar.error(
                                          message:
                                              "Please select a file less than 10 mb",
                                        ),
                                      );
                                    });
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  side: BorderSide(
                                      width: 0.9, color: ColorCode.orange),
                                  primary: ColorCode.white,
                                  textStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.66,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.cloud_upload_rounded,
                                      color: ColorCode.orange,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Upload PDF",
                                      style: TextStyle(color: ColorCode.orange),
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
                                  if (kIsWeb) {
                                    if (path1 != null) {
                                      final String v4 = uuid.v4();
                                      pdfUpload(v4, path1!);
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
                                              "Please select a pdf file first.",
                                        ),
                                      );
                                    }
                                  } else if (Platform.isAndroid) {
                                    if (path2 != null) {
                                      final String v4 = uuid.v4();
                                      pdfUpload1(v4, path2!);
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
                                              "Please select a pdf file first.",
                                        ),
                                      );
                                    }
                                  }
                                },
                                child: Expanded(
                                  child: Container(
                                      color: ColorCode.orange,
                                      width: MediaQuery.of(context).size.width *
                                          0.66,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            Icons.check,
                                            color: ColorCode.white,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Create Qr",
                                            style: TextStyle(
                                              color: ColorCode.white,
                                              fontSize: 18,
                                            ),
                                          )
                                        ],
                                      )),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const DesktopViewPdf(
            title: "Pdf to QR",
            browse: "Upload PDF",
            generate: "Create Qr",
            icon1: Icons.cloud_upload,
            icon2: Icons.check,
          );
        }
      });
}
































































// import "dart:io";
// import "dart:typed_data";
// import "package:file_picker/file_picker.dart";
// import "package:flutter/foundation.dart";
// import "package:flutter/material.dart";
// import "package:syncfusion_flutter_pdfviewer/pdfviewer.dart";
// import "package:top_snackbar_flutter/custom_snack_bar.dart";
// import "package:top_snackbar_flutter/top_snack_bar.dart";
// import "package:uuid/uuid.dart";
// import "/colors/colorcode.dart";
// import "/components/topbar.dart";
// import "/firebase/pdfuploader.dart";

// class PdfToQr extends StatefulWidget {
//   const PdfToQr({Key? key}) : super(key: key);

//   @override
//   _PdfToQrState createState() => _PdfToQrState();
// }

// class _PdfToQrState extends State<PdfToQr> {
//   Uint8List? path1;
//   File? path2;
//   Uuid uuid = const Uuid();

//   @override
//   Widget build(BuildContext context) => Expanded(
//         flex: 5,
//         child: SizedBox(
//           height: MediaQuery.of(context).size.height * 0.75,
//           child: Column(
//             // crossAxisAlignment: CrossAxisAlignment.start,
//             // mainAxisAlignment: MainAxisAlignment.start,

//             children: <Widget>[
//               Stack(
//                 children: <Widget>[
//                   const TopBar(title: "PDF TO QR CODE"),
//                   Container(
//                     margin: const EdgeInsets.only(top: 100),
//                     child: Center(
//                       child: Column(
//                         children: <Widget>[
//                           if (path1 != null || path2 != null)
//                             SizedBox(
//                                 height:
//                                     MediaQuery.of(context).size.height * 0.40,
//                                 width: MediaQuery.of(context).size.width,
//                                 child: Column(
//                                   children: <Widget>[
//                                     SizedBox(
//                                         height:
//                                             MediaQuery.of(context).size.height *
//                                                 0.35,
//                                         width:
//                                             MediaQuery.of(context).size.width *
//                                                 0.40,
//                                         child: Stack(
//                                           children: <Widget>[
//                                             if (path1 != null)
//                                               SfPdfViewer.memory(
//                                                 path1!,
//                                                 enableDoubleTapZooming: false,
//                                               )
//                                             else
//                                               const SizedBox.shrink(),
//                                             if (path2 != null)
//                                               SfPdfViewer.file(
//                                                 path2!,
//                                                 enableDoubleTapZooming: false,
//                                               )
//                                             else
//                                               const SizedBox.shrink()
//                                           ],
//                                         )),
//                                   ],
//                                 ))
//                           else
//                             Image.asset(
//                               "assets/images/img1.jpg",
//                               height: MediaQuery.of(context).size.height * 0.40,
//                               width: MediaQuery.of(context).size.width,
//                             ),
//                           Text(
//                             "PDF Preview",
//                             style: TextStyle(
//                               color: ColorCode.black,
//                               fontSize: 20,
//                               decoration: TextDecoration.none,
//                               fontWeight: FontWeight.normal,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: Column(
//                   children: <Widget>[
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         ElevatedButton(
//                           onPressed: () async {
//                             if (kIsWeb) {
//                               final FilePickerResult? bytesFromPicker =
//                                   await FilePicker.platform.pickFiles(
//                                       type: FileType.custom,
//                                       allowedExtensions: <String>["pdf"]);
//                               final PlatformFile file =
//                                   bytesFromPicker!.files.first;
//                               if (file.size < 10240000) {
//                                 if (bytesFromPicker.isSinglePick) {
//                                   setState(() {
//                                     showTopSnackBar(
//                                       context,
//                                       const CustomSnackBar.success(
//                                         message: "File selected successfully",
//                                       ),
//                                     );
//                                     final List<Uint8List?> res = bytesFromPicker
//                                         .files
//                                         .map((_) => _.bytes)
//                                         .toList();
//                                     path1 = res.first!.buffer.asUint8List();
//                                   });
//                                 }
//                               } else {
//                                 setState(() {
//                                   showTopSnackBar(
//                                     context,
//                                     const CustomSnackBar.error(
//                                       message:
//                                           "Please select a file less than 10 mb",
//                                     ),
//                                   );
//                                 });
//                               }
//                             } else if (Platform.isAndroid) {
//                               final FilePickerResult? bytesFromPicker =
//                                   await FilePicker.platform.pickFiles(
//                                       type: FileType.custom,
//                                       allowedExtensions: <String>["pdf"]);
//                               final PlatformFile file =
//                                   bytesFromPicker!.files.first;
//                               if (file.size < 10240000) {
//                                 if (bytesFromPicker.isSinglePick) {
//                                   setState(() {
//                                     showTopSnackBar(
//                                       context,
//                                       const CustomSnackBar.success(
//                                         message: "File selected successfully",
//                                       ),
//                                     );
//                                     final File file1 = File(file.path!);
//                                     setState(() {
//                                       path2 = file1;
//                                     });
//                                   });
//                                 }
//                               } else {
//                                 setState(() {
//                                   showTopSnackBar(
//                                     context,
//                                     const CustomSnackBar.error(
//                                       message:
//                                           "Please select a file less than 10 mb",
//                                     ),
//                                   );
//                                 });
//                               }
//                             }
//                           },
//                           style: ElevatedButton.styleFrom(
//                               side: BorderSide(
//                                   width: 0.9, color: ColorCode.orange),
//                               primary: ColorCode.white,
//                               textStyle: const TextStyle(
//                                   fontSize: 16, fontWeight: FontWeight.bold)),
//                           child: SizedBox(
//                             width: MediaQuery.of(context).size.width * 0.66,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: <Widget>[
//                                 Icon(
//                                   Icons.cloud_upload_rounded,
//                                   color: ColorCode.orange,
//                                 ),
//                                 const SizedBox(
//                                   width: 10,
//                                 ),
//                                 Text(
//                                   "Upload PDF",
//                                   style: TextStyle(color: ColorCode.orange),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                                 primary: ColorCode.orange),
//                             onPressed: () {
//                               if (kIsWeb) {
//                                 if (path1 != null) {
//                                   final String v4 = uuid.v4();
//                                   pdfUpload(v4, path1!);
//                                   showTopSnackBar(
//                                     context,
//                                     const CustomSnackBar.success(
//                                       message: "File upload successfully",
//                                     ),
//                                   );
//                                 } else {
//                                   showTopSnackBar(
//                                     context,
//                                     const CustomSnackBar.error(
//                                       message:
//                                           "Please select a pdf file first.",
//                                     ),
//                                   );
//                                 }
//                               } else if (Platform.isAndroid) {
//                                 if (path2 != null) {
//                                   final String v4 = uuid.v4();
//                                   pdfUpload1(v4, path2!);
//                                   showTopSnackBar(
//                                     context,
//                                     const CustomSnackBar.success(
//                                       message: "File upload successfully",
//                                     ),
//                                   );
//                                 } else {
//                                   showTopSnackBar(
//                                     context,
//                                     const CustomSnackBar.error(
//                                       message:
//                                           "Please select a pdf file first.",
//                                     ),
//                                   );
//                                 }
//                               }
//                             },
//                             child: Expanded(
//                               child: Container(
//                                   color: ColorCode.orange,
//                                   width:
//                                       MediaQuery.of(context).size.width * 0.66,
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: <Widget>[
//                                       Icon(
//                                         Icons.check,
//                                         color: ColorCode.white,
//                                       ),
//                                       const SizedBox(
//                                         width: 10,
//                                       ),
//                                       Text(
//                                         "Create Qr",
//                                         style: TextStyle(
//                                           color: ColorCode.white,
//                                           fontSize: 18,
//                                         ),
//                                       )
//                                     ],
//                                   )),
//                             ))
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
// }
