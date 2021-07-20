import 'dart:async';
import 'package:flutter/material.dart';
import 'package:qrcode/screen/slider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 1),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => CarouselWithIndicatorDemo())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
              child: Padding(
            padding:
                const EdgeInsets.only(top: 37, bottom: 38, left: 20, right: 20),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(width: 1.0, style: BorderStyle.solid),
                  boxShadow: [
                    BoxShadow(
                      // color: Colors.greenAccent[200],
                      offset: const Offset(
                        1.0,
                        1.0,
                      ),
                      blurRadius: 2.0,
                      spreadRadius: 0.0,
                    ), //BoxShadow
                    BoxShadow(
                      color: Colors.white,
                      // offset: const Offset(0.0, 0.0),
                      blurRadius: 0.0,
                      spreadRadius: 0.0,
                    ), //BoxShadow
                  ]),
              child: Center(child: Text("QRange")),
              height: 103,
              width: 103,
            ),
          )),
          Stack(
            children: [
              Column(
                children: [
                  Image(
                    image: AssetImage(
                      "assets/images/logo.png",
                    ),
                    fit: BoxFit.fill,
                    width: 117,
                    height: 117,
                  ),
                  Text(
                    "Orange",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 36.0,
                    ),
                  ),
                  Text(
                    "DigiSolution",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
