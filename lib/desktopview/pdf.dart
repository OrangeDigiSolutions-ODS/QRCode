import "dart:typed_data";
import "package:auto_size_text_pk/auto_size_text_pk.dart";
import "package:file_picker/file_picker.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:syncfusion_flutter_pdfviewer/pdfviewer.dart";
import "package:top_snackbar_flutter/custom_snack_bar.dart";
import "package:top_snackbar_flutter/top_snack_bar.dart";
import "package:uuid/uuid.dart";
import "/colors/colorcode.dart";
import "/components/topbar.dart";
import "/firebase/pdfuploader.dart";
import "/qrviewer/qr.dart";

class DesktopViewPdf extends StatefulWidget {
  const DesktopViewPdf({
    required this.browse,
    required this.generate,
    required this.icon1,
    required this.icon2,
    required this.title,
    Key? key,
  }) : super(key: key);
  final String browse;
  final String generate;
  final IconData icon1;
  final IconData icon2;
  final String title;

  @override
  _DesktopViewPdfState createState() => _DesktopViewPdfState();
}

class _DesktopViewPdfState extends State<DesktopViewPdf> {
  Uuid uuid = const Uuid();
  Uint8List? path1;
  bool waiting = false;
  String createQR = "Create QR";
  @override
  Widget build(BuildContext context) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.82,
        child: Column(
          children: <Widget>[
            TopBar(title: widget.title),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.56,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.38,
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: Column(
                            children: <Widget>[
                              if (path1 != null)
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.50,
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(children: <Widget>[
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.50,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.40,
                                          child: SfPdfViewer.memory(
                                            path1!,
                                            enableDoubleTapZooming: false,
                                          ))
                                    ]))
                              else
                                Image.asset(
                                  "assets/images/img2.png",
                                  height:
                                      MediaQuery.of(context).size.height * 0.50,
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
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: AutoSizeText(
                            "Select a pdf file with max size of 10MB",
                            wrapWords: false,
                            maxLines: 10,
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                color: ColorCode.black,
                                fontSize: 20,
                                fontWeight: FontWeight.normal)),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: ColorCode.white,
                                  side: BorderSide(color: ColorCode.black)),
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
                                }
                              },
                              child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.15,
                                  child: Stack(
                                    children: <Widget>[
                                      Icon(
                                        widget.icon1,
                                        color: ColorCode.black,
                                      ),
                                      Center(
                                        child: Text(
                                          widget.browse,
                                          style: TextStyle(
                                            color: ColorCode.black,
                                            fontSize: 18,
                                          ),
                                        ),
                                      )
                                    ],
                                  ))),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.01,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: ColorCode.orange,
                              ),
                              onPressed: () {
                                if (path1 != null && waiting==false) {
                                  final String v4 = uuid.v4();
                                  setState(() {
                                    waiting = true;
                                    createQR = "waiting..";
                                  });
                                  pdfUpload(v4, path1!).then((__) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute<dynamic>(
                                            builder: (_) => QRPage(url: __)));
                                    showTopSnackBar(
                                      context,
                                      const CustomSnackBar.success(
                                        message: "File upload successfully",
                                      ),
                                    );
                                  });
                                } else {
                                  if (waiting == true) {
                                    showTopSnackBar(
                                      context,
                                      const CustomSnackBar.error(
                                        message: "wait until file upload",
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
                              child: Container(
                                  color: ColorCode.orange,
                                  width:
                                      MediaQuery.of(context).size.width * 0.15,
                                  child: Stack(
                                    // mainAxisAlignment:
                                    //     MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        widget.icon2,
                                        color: ColorCode.white,
                                      ),
                                      Center(
                                        child: Text(
                                          createQR,
                                          style: TextStyle(
                                            color: ColorCode.white,
                                            fontSize: 18,
                                          ),
                                        ),
                                      )
                                    ],
                                  )))
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      );
}
