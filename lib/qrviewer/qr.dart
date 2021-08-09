import "dart:convert";
import "dart:io";
import "dart:typed_data";
import "dart:ui" as ui;
import "package:top_snackbar_flutter/custom_snack_bar.dart";
import "package:top_snackbar_flutter/top_snack_bar.dart";
import "package:universal_html/html.dart" as html;
import "package:auto_size_text_pk/auto_size_text_pk.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/rendering.dart";
import "package:path_provider/path_provider.dart";
import "package:qr_flutter/qr_flutter.dart";
import "package:screenshot/screenshot.dart";
import "package:share_plus/share_plus.dart";

import "/colors/colorcode.dart";
import "/components/topbar.dart";

// ignore: must_be_immutable
class QRPage extends StatefulWidget {
  String url;
  // ignore: sort_constructors_first
  QRPage({required this.url, Key? key}) : super(key: key);

  @override
  _QRPageState createState() => _QRPageState();
}

class _QRPageState extends State<QRPage> {
  final DateTime dateToday = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      DateTime.now().hour,
      DateTime.now().minute,
      DateTime.now().second);

  double matrix4 = ui.window.devicePixelRatio;

  final GlobalKey _globalKey = GlobalKey();
  Future<dynamic> saveImage(Uint8List bytes) async {
    Directory? directory = await getExternalStorageDirectory();
    String newPath = "";
    // print(directory);
    final List<String> paths = directory!.path.split("/");
    for (int x = 1; x < paths.length; x++) {
      final String folder = paths[x];
      if (folder != "Android") {
        newPath += "/$folder";
      } else {
        break;
      }
    }
    newPath = "$newPath/QRange";
    directory = Directory(newPath);
    // ignore: avoid_slow_async_io
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
    // ignore: avoid_slow_async_io
    if (await directory.exists()) {
      final File file = File("${directory.path}${"/$dateToday.png"}");
      debugPrint("$dateToday");
      file.writeAsBytesSync(bytes);
      return file;
    }
  }

  Future<dynamic> saveAndShare(Uint8List bytes) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File image = File("${directory.path}/flutter.png");
    final String text = widget.url;
    image.writeAsBytesSync(bytes);
    await Share.shareFiles(<String>[image.path], text: text);
  }

  final ScreenshotController controller = ScreenshotController();
  Uint8List? pngBytes;

  Widget buildQR() => Container(
        color: ColorCode.white,
        child: Center(
          child: QrImage(
            data: widget.url,
          ),
        ),
      );
  MediaQueryData? queryData;
  @override
  Widget build(BuildContext context) => Scaffold(
        // floatingActionButton: Align(
        //   child: FloatingActionButton(
        //     onPressed: () {},
        //     backgroundColor: Color(0xffDD4C00),
        //     child: Icon(
        //       Icons.edit,
        //       color: Colors.white,
        //     ),
        //   ),
        //   alignment: Alignment(1, 0.6),
        // ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              const TopBar(title: "QR Code"),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                // width: MediaQuery.of(context).size.width * 0.4,
                child: RepaintBoundary(key: _globalKey, child: buildQR()),
              ),
              Container(
                // padding: const EdgeInsets.fromLTRB(5, 9, 5, 10),
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width,
                color: ColorCode.lightgrey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          final RenderRepaintBoundary boundary =
                              _globalKey.currentContext!.findRenderObject()!
                                  as RenderRepaintBoundary;
                          final ui.Image image1 = await boundary.toImage(pixelRatio: ui.window.devicePixelRatio);
                          final ByteData? byteData = await image1.toByteData(
                              format: ui.ImageByteFormat.png);
                          pngBytes = byteData!.buffer.asUint8List();
                          debugPrint(widget.url);
                        // ignore: avoid_catches_without_on_clauses
                        } catch (e) {
                          debugPrint("hello");
                        }
                        if (kIsWeb) {
                          html.Blob(
                              <dynamic>[base64Encode(pngBytes!)], "image/png");
                          html.AnchorElement()
                            // ignore: unsafe_html
                            ..href =
                                "${Uri.dataFromBytes(pngBytes!, mimeType: "image/png")}"
                            ..download = "$dateToday.png"
                            ..click();
                        } else if (Platform.isAndroid) {
                          final Uint8List image =
                              await controller.captureFromWidget(buildQR());
                          await saveImage(image);
                        }
                        setState(() {
                          showTopSnackBar(
                            context,
                            const CustomSnackBar.success(
                              message: "Download complete",
                            ),
                          );
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          side: const BorderSide(
                            width: 0.9,
                          ),
                          primary: ColorCode.orange,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          textStyle: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: Row(
                          children: const <Widget>[
                            Icon(
                              Icons.cloud_download,
                              color: Colors.white,
                            ),
                            AutoSizeText(
                              "Download",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    if (kIsWeb)
                      const SizedBox.shrink()
                    else
                      GestureDetector(
                        child: ElevatedButton(
                          onPressed: () async {
                            final Uint8List image =
                                await controller.captureFromWidget(buildQR());
                            saveAndShare(image);
                          },
                          style: ElevatedButton.styleFrom(
                              side: const BorderSide(width: 0.9),
                              primary: ColorCode.orange,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              textStyle: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                            child: Row(
                              children: const <Widget>[
                                Icon(
                                  Icons.share,
                                  color: Colors.white,
                                ),
                                AutoSizeText(
                                  "Share",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
