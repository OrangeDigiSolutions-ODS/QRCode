import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:qrscan/qrscan.dart' as scanner;
//put this line manually

//apply this class on home: attribute at MaterialApp()

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ScanPage(); //create state
  }
}

class _ScanPage extends State<ScanPage> {
  String result = "Hello World...!";
  Future _scanQR() async {
    try {
      String? cameraScanResult = await scanner.scan();
      setState(() {
        result =
            cameraScanResult!; // setting string result with cameraScanResult
      });
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Scanner Example In Flutter"),
      ),
      body: Center(
        child: Text(result), // Here the scanned result will be shown
      ),
      floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.camera_alt),
          onPressed: () {
            _scanQR(); // calling a function when user click on button
          },
          label: Text("Scan")),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
