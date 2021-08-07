import "dart:io";
import "package:auto_size_text_pk/auto_size_text_pk.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:top_snackbar_flutter/custom_snack_bar.dart";
import "package:top_snackbar_flutter/top_snack_bar.dart";
import "/colors/colorcode.dart";
import "image.dart";
import "pdf.dart";

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => CategoryState();
}

class CategoryState extends State<Category> {
  final List<Widget> page = <Widget>[
    const ImageToQr(),
    // const Text("ssc"),
    const PdfToQr(),
  ];
  int indexpage = 0;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.09;
    double width = MediaQuery.of(context).size.height * 0.15;
    final List<IconData> icons = <IconData>[
      Icons.image_outlined,
      Icons.picture_as_pdf,
    ];
    final List<String> txt = <String>[
      "Image",
      "Pdf",
    ];
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          page[indexpage],
          Container(
            color: ColorCode.lightgrey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  // margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  height: MediaQuery.of(context).size.height * 0.14,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      itemCount: icons.length,
                      shrinkWrap: true,
                      physics: const PageScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, __) => GestureDetector(
                            onTap: () {
                              setState(() {
                                if (__ == 1) {
                                  showTopSnackBar(
                                    context,
                                    const CustomSnackBar.info(
                                      message:
                                          "Please select file by clicking upload pdf button",
                                    ),
                                  );
                                }
                                if (__ == 0) {
                                  if (kIsWeb) {
                                    showTopSnackBar(
                                      context,
                                      const CustomSnackBar.info(
                                        message:
                                            "Please select file by clicking Browse button",
                                      ),
                                    );
                                  } else if (Platform.isAndroid) {
                                    showTopSnackBar(
                                      context,
                                      const CustomSnackBar.info(
                                        message:
                                            "Please select file by clicking Camera or Gallery button",
                                      ),
                                    );
                                  }
                                }
                                if (indexpage == __) {
                                  height =
                                      MediaQuery.of(context).size.height * 0.08;
                                  width =
                                      MediaQuery.of(context).size.height * 0.15;
                                }
                                indexpage = __;
                                debugPrint("$indexpage");
                              });
                            },
                            child: indexpage == __
                                ? Container(
                                    height: height,
                                    width: width,
                                    margin:
                                        const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                            color: ColorCode.lightgrey,
                                            offset: const Offset(1, 1),
                                            blurRadius: 1,
                                            spreadRadius: 0.5,
                                          ), //BoxShadow
                                          BoxShadow(
                                            color: ColorCode.orange,
                                            blurRadius: 1,
                                            spreadRadius: 0.5,
                                          ),
                                        ]),
                                    child: SizedBox(
                                      height: height,
                                      width: width,
                                      child: Card(
                                        child: Column(
                                          children: <Widget>[
                                            Icon(
                                              icons[__],
                                              color: ColorCode.orange,
                                              size: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.06,
                                              // MediaQuery.of(context).size.width *
                                              //     0.1,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(1),
                                              child: AutoSizeText(txt[__],
                                                  wrapWords: false,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: ColorCode.black,
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.6,
                                    width: MediaQuery.of(context).size.height *
                                        0.11,
                                    margin: const EdgeInsets.fromLTRB(
                                        10, 10, 10, 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                            color: ColorCode.lightgrey,
                                            offset: const Offset(1, 1),
                                            blurRadius: 1,
                                            spreadRadius: 0.5,
                                          ), //BoxShadow
                                        ]),
                                    child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.6,
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.11,
                                      child: Card(
                                        child: Column(
                                          children: <Widget>[
                                            Icon(
                                              icons[__],
                                              color: ColorCode.orange,
                                              size: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.04,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(1),
                                              child: AutoSizeText(txt[__],
                                                  wrapWords: false,
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color: ColorCode.black,
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                          )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty("indexpage", indexpage));
  }
}
