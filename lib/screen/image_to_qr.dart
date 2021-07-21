import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:qrorange/screen/test_slider_utkarsh.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 18),
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: double.infinity,
                    color: Color(0xff353535),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          height: 43,
                          width: 43,
                        ),
                        SizedBox(
                          width: 18,
                        ),
                        Text(
                          "Image To Qr Code",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 90.0),
                      child: Center(
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/images/menu.png",
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.40,
                            ),
                            Text(
                              "Image Preview",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.camera_enhance),
                          label: Text("Camera"),
                          style: ElevatedButton.styleFrom(
                              side: BorderSide(width: 0.9, color: Colors.black),
                              primary: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              textStyle: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.photo_camera_back_outlined),
                          label: Text("Gallery"),
                          style: ElevatedButton.styleFrom(
                              side: BorderSide(width: 0.9, color: Colors.black),
                              primary: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              textStyle: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style:ElevatedButton.styleFrom(
                            primary: Color(0xffDD4C00)
                          ),
                            onPressed: () {},
                            child: Expanded(flex: 1,
                              child: Container(
                                  color: Color(0xffDD4C00),
                                  width:
                                      MediaQuery.of(context).size.width * .66,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        "Create Qr",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      )
                                    ],
                                  )),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  ButtonOptions()
//                   Expanded(
//                     child: Container(
//                       width: MediaQuery.of(context).size.width,
//                       height: MediaQuery.of(context).size.height * .163,
//                       color: HexColor("#C6C6C6"),
//                       child: ListView(scrollDirection: Axis.horizontal,
//                         children: [
//                           Container(
//                             child: Text("Utkarsh"),
//                             width: MediaQuery.of(context).size.width *0.45,
//                             color: Colors.red,
//                           ),
//                           SizedBox(
// width: MediaQuery.of(context).size.width *0.1 ,
//                           ),
//                           Container(
//                             width: MediaQuery.of(context).size.width *0.45,
//                             child: Text("Utkarsh"),
//                             color: Colors.yellow,
//                           ),
//                         ],
//                       ),
//                     ),
//                   )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
