import "dart:typed_data";
import "package:carousel_slider/carousel_slider.dart";
import "package:file_picker/file_picker.dart";
import "package:flutter/material.dart";
import "package:top_snackbar_flutter/custom_snack_bar.dart";
import "package:top_snackbar_flutter/top_snack_bar.dart";
import "package:uuid/uuid.dart";
import "/colors/colorcode.dart";
import "/components/topbar.dart";
import "/firebase/imageuploader.dart";

class DesktopViewImage extends StatefulWidget {
  const DesktopViewImage({
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
  _DesktopViewImageState createState() => _DesktopViewImageState();
}

class _DesktopViewImageState extends State<DesktopViewImage> {
  Uuid uuid = const Uuid();
  List<Uint8List> path1 = <Uint8List>[];
  GlobalKey<CarouselSliderState> sslKey = GlobalKey();
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
                        if (path1.isNotEmpty)
                          Card(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.50,
                              width: MediaQuery.of(context).size.width,
                              child: slider(sslKey),
                            ),
                          )
                        else
                          Image.asset(
                            "assets/images/img2.png",
                            height: MediaQuery.of(context).size.height * 0.50,
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
                                onPressed: multipleimage,
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
                                  if (path1.isNotEmpty) {
                                    final String v4 = uuid.v4();
                                    for (int i = 0; i < path1.length; i++) {
                                      imageUpload1(v4, path1[i]);
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
  FilePickerResult? bytesFromPicker;
  List<Uint8List?> img = <Uint8List?>[];
  Future<void> multipleimage() async {
    bytesFromPicker = await FilePicker.platform
        .pickFiles(allowMultiple: true, type: FileType.image);
    // await ImagePickerWeb.getMultiImages(outputType: ImageType.bytes);

    if (bytesFromPicker != null) {
      img =
          bytesFromPicker!.files.map((_) => _.bytes).cast<Uint8List>().toList();
      setState(() {
        for (int i = 0; i < img.length; i++) {
          path1.add(img[i]!);
        }
      });
    }
  }

  Widget slider(GlobalKey<CarouselSliderState> sslkey) =>
      CarouselSlider.builder(
        options: CarouselOptions(
          enableInfiniteScroll: false,
          viewportFraction: 0.9,
          aspectRatio: 1,
        ),
        itemCount: path1.length,
        key: sslkey,
        // carouselController: _controller,
        itemBuilder: (context, int index, int pageViewIndex) =>
            Column(
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
                            path1[index],
                            // fit: BoxFit.contain,
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
                        debugPrint("${path1.length}");
                        setState(() {
                          path1.remove(path1[index]);
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
      );
}
