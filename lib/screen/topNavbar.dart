import 'package:flutter/material.dart';

class TopNavBar extends StatelessWidget {
  const TopNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 18),
      height: MediaQuery.of(context).size.height * 0.15,
      width: double.infinity,
      color: Color(0xff353535),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logo.png',
            height: MediaQuery.of(context).size.height * 0.12,
            width: MediaQuery.of(context).size.width * 0.12,
          ),
          SizedBox(
            width: 18,
          ),
          Text(
            "Image To Qr Code",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
