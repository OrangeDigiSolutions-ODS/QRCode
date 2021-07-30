import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import "package:url_strategy/url_strategy.dart";
import "/colors/colorcode.dart";
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
        home: const SplashScreen(),
      );
}
