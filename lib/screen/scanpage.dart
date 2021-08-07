import "dart:async";
import "package:barcode_scan2/barcode_scan2.dart";
import "package:flutter/services.dart";
import "package:flutter/material.dart";
import "package:images_picker/images_picker.dart";
import "package:scan/scan.dart";
import "package:url_launcher/url_launcher.dart";
import "/qrviewer/qrviewimage.dart";
import "/qrviewer/qrviewpdf1.dart";

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  ScanResult? scanResult;
  final TextEditingController _flashOnController =
      TextEditingController(text: "Flash on");
  final TextEditingController _flashOffController =
      TextEditingController(text: "Flash off");
  final TextEditingController _cancelController =
      TextEditingController(text: "Cancel");

  final double _aspectTolerance = 0;
  // int _numberOfCameras = 0;
  final int _selectedCamera = -1;
  final bool _useAutoFocus = true;
  final bool _autoEnableFlash = false;
  String? scanr;

  static final List<BarcodeFormat> _possibleFormats = BarcodeFormat.values
      .toList()
        ..removeWhere((_) => _ == BarcodeFormat.unknown);

  List<BarcodeFormat> selectedFormats = <BarcodeFormat>[..._possibleFormats];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ScanResult? scanResult = this.scanResult;
    return Scaffold(
      appBar: AppBar(
        title: const Text("QRange"),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            ElevatedButton(onPressed: _scan, child: const Text("scan QR")),
            ElevatedButton(
                onPressed: () async {
                  final List<Media>? res = await ImagesPicker.pick();
                  if (res != null) {
                    final String? str = await Scan.parse(res[0].path);
                    if (str != null) {
                      setState(() {
                        scanr = str;
                      });
                    }
                  }
                },
                child: const Text("Gallery")),
            if (scanResult != null)
              Card(
                child: Column(
                  children: <Widget>[
                    ListTile(title: Builder(builder: (_) {
                      if (scanResult.rawContent != null) {
                        const Text("Data:-");
                      }
                      return const SizedBox.shrink();
                    }), subtitle: Builder(
                      builder: (_) {
                        if ((scanResult.rawContent).contains("images")) {
                          return ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute<dynamic>(
                                        builder: (_) => ViewQRImage(
                                              uri: scanResult.rawContent,
                                            )));
                              },
                              child: const Text("press me"));
                        } else if (scanr!.contains("/o/pdf")) {
                          return ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute<dynamic>(
                                        builder: (_) => ViewQRPDF(
                                              url: scanResult.rawContent,
                                            )));
                              },
                              child: const Text("press me"));
                        } else if ((scanResult.rawContent).contains("http") &&
                            !scanResult.rawContent.contains("/o/pdf")) {
                          return ElevatedButton(
                              onPressed: () {
                                launch(scanResult.rawContent);
                              },
                              child: Text(scanResult.rawContent));
                        }
                        return SizedBox(
                          child: Text(scanResult.rawContent),
                        );
                      },
                    )),
                  ],
                ),
              ),
            if (scanr != null)
              Card(
                child: Column(
                  children: <Widget>[
                    ListTile(
                        title: const Text("Data:-"),
                        subtitle: Builder(
                          builder: (_) {
                            if (scanr!.contains("images")) {
                              return ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute<dynamic>(
                                            builder: (_) => ViewQRImage(
                                                  uri: scanr,
                                                )));
                                  },
                                  child: const Text("press me"));
                            } else if (scanr!.contains("/o/pdf")) {
                              return ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute<dynamic>(
                                            builder: (_) => ViewQRPDF(
                                                  url: "$scanr",
                                                )));
                                  },
                                  child: const Text("press me"));
                            } else if (scanr!.contains("http") &&
                                !scanr!.contains("/o/pdf")) {
                              return ElevatedButton(
                                  onPressed: () {
                                    launch(scanr!);
                                  },
                                  child: Text(scanr!));
                            }
                            return SizedBox(
                              child: Text(scanr!),
                            );
                          },
                        )),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _scan() async {
    try {
      final ScanResult result = await BarcodeScanner.scan(
        options: ScanOptions(
          strings: <String, String>{
            "cancel": _cancelController.text,
            "flash_on": _flashOnController.text,
            "flash_off": _flashOffController.text,
          },
          restrictFormat: selectedFormats,
          useCamera: _selectedCamera,
          autoEnableFlash: _autoEnableFlash,
          android: AndroidOptions(
            aspectTolerance: _aspectTolerance,
            useAutoFocus: _useAutoFocus,
          ),
        ),
      );
      setState(() => scanResult = result);
    } on PlatformException catch (e) {
      setState(() {
        scanResult = ScanResult(
          type: ResultType.Error,
          rawContent: e.code == BarcodeScanner.cameraAccessDenied
              ? "The user did not grant the camera permission!"
              : "Unknown error: $e",
        );
      });
    }
  }
}
