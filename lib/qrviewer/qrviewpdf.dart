import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:syncfusion_flutter_pdfviewer/pdfviewer.dart";
import "/colors/colorcode.dart";

// ignore: must_be_immutable
class ViewQRPdf extends StatefulWidget {
  ViewQRPdf({
    this.uri,
    Key? key,
  }) : super(key: key);
  String? uri;
  @override
  // ignore: no_logic_in_create_state
  _ViewQRPdfState createState() => _ViewQRPdfState(uri!);
}

class _ViewQRPdfState extends State<ViewQRPdf> {
  _ViewQRPdfState(this.uri);
  String uri;

  CollectionReference<Object> pdf =
      FirebaseFirestore.instance.collection("pdf");

  @override
  Widget build(BuildContext context) {
    String? urisplit;
    // print(uri);
    setState(() {
      urisplit = uri.split("=").last;
    });
    // print(urisplit);
    if (urisplit!.contains(uri) == true) {
      return Container(
        alignment: Alignment.center,
        color: ColorCode.black,
        child: Builder(
          builder: (_) => FutureBuilder<DocumentSnapshot<Object>>(
            future: pdf.doc(urisplit).get(),
            builder: (_, __) {
              List<dynamic> imageurl1 = <dynamic>[];
              if (__.connectionState == ConnectionState.done) {
                final Map<String, dynamic> data1 =
                    // ignore: cast_nullable_to_non_nullable
                    __.data!.data() as Map<String, dynamic>;
                imageurl1 = data1.values.toList();
                return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.9,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: SfPdfViewer.network(
                      "${imageurl1[0]}",
                    ));
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      );
    }
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
