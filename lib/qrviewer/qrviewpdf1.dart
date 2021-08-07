import "dart:io";
import "dart:typed_data";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:path_provider/path_provider.dart";
import "package:syncfusion_flutter_pdfviewer/pdfviewer.dart";

// ignore: must_be_immutable
class ViewQRPDF extends StatefulWidget {
  ViewQRPDF({required this.url, Key? key}) : super(key: key);
  String url;

  @override
  _ViewQRPDFState createState() => _ViewQRPDFState();
}

class _ViewQRPDFState extends State<ViewQRPDF> {
  @override
  void initState() {
    super.initState();
    _downloadFile(widget.url, "ssc.pdf");
  }

  File? ssc;
  HttpClient httpClient = HttpClient();
  Future<File> _downloadFile(String url, String filename) async {
    final HttpClientRequest request = await httpClient.getUrl(Uri.parse(url));
    final HttpClientResponse response = await request.close();
    final Uint8List bytes = await consolidateHttpClientResponseBytes(response);
    final String dir = (await getApplicationDocumentsDirectory()).path;
    final File file = File("$dir/$filename");
    await file.writeAsBytes(bytes);
    setState(() {
      ssc = file;
    });
    return file;
  }

  @override
  Widget build(BuildContext context) => Builder(builder: (_) {
        if (ssc != null) {
          return SfPdfViewer.file(ssc!);
        }
        return const Center(child: CircularProgressIndicator());
      });
  // Container(child: SfPdfViewer.file(ssc!));
}
