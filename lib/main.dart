import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import "package:url_strategy/url_strategy.dart";
import "/colors/colorcode.dart";
import "/components/bottombar.dart";
import "/qrviewer/qrviewpdf.dart";
import "/screen/sliderpage.dart";
import "qrviewer/qr.dart";
import "qrviewer/qrviewimage.dart";
import "screen/scanpage.dart";
import "screen/splashscreen.dart";

Future<void> main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const QRCode());
}

class QRCode extends StatelessWidget {
  const QRCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: ColorCode.orange,
          accentColor: Colors.cyan[600],
          // fontFamily: "Baloo",
        ),
        title: "QRange",
        // home: const SplashScreen(),
        initialRoute: "/",
        onGenerateRoute: (__) {
          if (__.name!.contains("images/viewqr")) {
            final Uri setttingsUri = Uri.parse(__.name!);
            final String? postid = setttingsUri.queryParameters["id"];
            return MaterialPageRoute<dynamic>(
                builder: (_) => ViewQRImage(
                      uri: postid,
                    ));
          } else if (__.name!.contains("pdf/viewqr")) {
            final Uri setttingsUri = Uri.parse(__.name!);
            final String? postid = setttingsUri.queryParameters["id"];
            return MaterialPageRoute<dynamic>(
                builder: (_) => ViewQRPdf(
                      uri: postid,
                    ));
          }
        },
        routes: <String, WidgetBuilder>{
          "/": (_) => const SplashScreen(),
          "/slider": (_) => const SliderPage(),
          "/bottombar": (_) => const BottomBar(),
          "/qrcode": (_) => QRPage(
                url: "hello",
              ),
          "/scan": (_) => const ScanPage(),
          "/viewqr": (_) => ViewQRImage()
        },
      );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        onGenerateRoute: (__) {
          if (__.name!.contains("images")) {
            final Uri setttingsUri = Uri.parse(__.name!);
            final String? postid = setttingsUri.queryParameters["id"];
            return MaterialPageRoute<dynamic>(
                builder: (_) => ViewQRImage(
                      uri: postid,
                    ));
          } else if (__.name!.contains("pdf/viewqr")) {
            final Uri setttingsUri = Uri.parse(__.name!);
            final String? postid = setttingsUri.queryParameters["id"];
            return MaterialPageRoute<dynamic>(
                builder: (_) => ViewQRPdf(
                      uri: postid,
                    ));
          }
        },
        routes: <String, WidgetBuilder>{"/": (_) => const SplashScreen()},
      );
}
