import "dart:async";
import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";
import "/colors/colorcode.dart";
import "/components/bottombar.dart";
import "desktopdesign.dart";
import "sliderpage.dart";

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    asynmethod();
  }

  Future<void> asynmethod() async {
    int? initScreen;
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    initScreen = preferences.getInt("initScreen");
    await preferences.setInt("initScreen", 1);
    Timer(
        const Duration(seconds: 1),
        () => Navigator.pushReplacement(context,
                MaterialPageRoute<Widget>(builder: (_) {
              if (initScreen == 1) {
                return LayoutBuilder(builder: (_, __) {
                  if (__.maxWidth < 768) {
                    return const BottomBar();
                    // buttomNav();
                  } else {
                    return const DesktopDesign();
                  }
                });
              } else {
                return LayoutBuilder(builder: (_, __) {
                  if (__.maxWidth < 768) {
                    return const SliderPage();
                    // CarouselWithIndicatorDemo();
                  } else {
                    return const DesktopDesign();
                  }
                });
              }
            })));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: ColorCode.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 37, bottom: 38, left: 20, right: 20),
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(),
                        boxShadow: <BoxShadow>[
                          const BoxShadow(
                            offset: Offset(
                              1,
                              1,
                            ),
                            blurRadius: 2,
                          ), //BoxShadow
                          BoxShadow(
                            color: ColorCode.white,
                          ),
                        ]),
                    child: SizedBox(
                      width: 103,
                      height: 103,
                      child: Center(
                          child: Text(
                        "QRange",
                        style: TextStyle(color: ColorCode.black),
                      )),
                    )),
              ),
            ),
            Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    const Image(
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
                          fontSize: 36,
                          color: ColorCode.black),
                    ),
                    Text(
                      "DigiSolution",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: ColorCode.black),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      );
}
