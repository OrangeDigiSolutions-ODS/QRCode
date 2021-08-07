import "dart:io";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:path_provider/path_provider.dart";
import "package:syncfusion_flutter_pdfviewer/pdfviewer.dart";

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
  var httpClient = HttpClient();
  Future<File> _downloadFile(String url, String filename) async {
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File("$dir/$filename");
    await file.writeAsBytes(bytes);
    print(file);
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
