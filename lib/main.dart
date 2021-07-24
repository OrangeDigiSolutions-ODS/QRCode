import 'dart:async';
import 'package:flutter/material.dart';
import 'package:qrcode/screen/desktop_design.dart';
import 'package:qrcode/screen/slider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screen/bottom_navigation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        backgroundColor: Color(0xffDD4C00),
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
    asynmethod();
  }

  Future<void> asynmethod() async {
    int? initScreen;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    initScreen = preferences.getInt('initScreen');
    await preferences.setInt('initScreen', 1);
    Timer(
        Duration(seconds: 1),
        () => Navigator.pushReplacement(context, MaterialPageRoute(
                // builder: (context) {
                //   return initScreen == 1
                //     ? LandingPage()
                //     : CarouselWithIndicatorDemo();
                // }
                builder: (context) {
              if (initScreen == 1) {
                return LayoutBuilder(builder: (context, constraint) {
                  if (constraint.maxWidth < 768) {
                    return buttomNav();
                  } else {
                    return DesktopDesign();
                  }
                });
              } else {
                return LayoutBuilder(builder: (context, constraint) {
                  if (constraint.maxWidth < 768) {
                    return CarouselWithIndicatorDemo();
                  } else {
                    return DesktopDesign();
                  }
                });
              }
            })));
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
