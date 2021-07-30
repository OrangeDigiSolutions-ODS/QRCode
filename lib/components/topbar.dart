import "package:flutter/material.dart";
import "/colors/colorcode.dart";

//creating logo and writing text image to qr
class TopBar extends StatelessWidget {
  const TopBar({required this.title, Key? key}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.only(left: 18),
        height: MediaQuery.of(context).size.height * 0.15,
        width: double.infinity,
        color: ColorCode.grey,
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/images/logo.png",
              height: MediaQuery.of(context).size.height * 0.12,
              width: MediaQuery.of(context).size.width * 0.12,
            ),
            const SizedBox(
              width: 18,
            ),
            Text(
              title,
              style: TextStyle(
                  color: ColorCode.white,
                  fontSize: 20,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
}
