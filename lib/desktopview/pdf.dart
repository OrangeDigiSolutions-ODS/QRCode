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
import "/firebase/pdfuploader.dart";

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
  @override
  Widget build(BuildContext context) => Expanded(
          child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.85,
        child: Column(
          children: <Widget>[
            TopBar(title: widget.title),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.56,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
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
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                            """Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem 
Ipsum has been the industry"s standard dummy text ever since the 1500s, when an unknown
printer took a galley of type and scrambled it to make a type specimen book""",
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                color: ColorCode.black,
                                fontSize: 20,
                                fontWeight: FontWeight.normal)),
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
                                          path1 =
                                              res.first!.buffer.asUint8List();
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
                                child: Expanded(
                                  child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            widget.icon1,
                                            color: ColorCode.black,
                                          ),
                                          Text(
                                            widget.browse,
                                            style: TextStyle(
                                              color: ColorCode.black,
                                              fontSize: 18,
                                            ),
                                          )
                                        ],
                                      )),
                                )),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.01,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: ColorCode.orange,
                                ),
                                onPressed: () {
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
                                },
                                child: Expanded(
                                  child: Container(
                                      color: ColorCode.orange,
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            widget.icon2,
                                            color: ColorCode.white,
                                          ),
                                          Text(
                                            widget.generate,
                                            style: TextStyle(
                                              color: ColorCode.white,
                                              fontSize: 18,
                                            ),
                                          )
                                        ],
                                      )),
                                ))
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ));
}
