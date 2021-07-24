// import 'dart:ui';

// import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:qrcode/screen/category.dart';
import 'package:qrcode/screen/topNavbar.dart';

class DesktopDesign extends StatefulWidget {
  const DesktopDesign({Key? key}) : super(key: key);

  @override
  _DesktopDesignState createState() => _DesktopDesignState();
}

class _DesktopDesignState extends State<DesktopDesign> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Expanded(flex: 1, child: TopNavBar()),
          Expanded(
            flex: 5,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30),
              child: Container(
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0)),
                          child: Image.asset(
                            "assets/images/img2.png",
                            width: 450,
                            height: 450,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 7.0),
                          child: Text("Image Preview"),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18.0),
                      child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              child: Container(
                                constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width *
                                            0.45,
                                    minHeight:
                                        MediaQuery.of(context).size.height *
                                            0.50),

                                // margin: EdgeInsets.only(top: 20),
                                child: Text(
                                  """Lorem ipsum dolor sit amet, consectetur adipiscing elit. Iaculis at sed facilisis duis hac laoreet ipsum malesuada enim. Suspendisse pulvinar 
                                
at iaculis urna integer ultrices sagittis rhoncus. Euismod faucibus vitae sed 
                                
suspendisse fames. Urna dictum aliquam donec semper.
                                                          
                                                          """,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 10,
                                  softWrap: false,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ElevatedButton.icon(
                                    style: ButtonStyle(
                                        padding: MaterialStateProperty.all(
                                            EdgeInsets.only(
                                                top: 15,
                                                bottom: 17,
                                                left: 72,
                                                right: 72)),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.white),
                                        textStyle: MaterialStateProperty.all(
                                            TextStyle(fontSize: 20)),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                side: BorderSide(color: HexColor("#b0afae"))))),
                                    onPressed: () {},
                                    icon: Icon(Icons.insert_drive_file),
                                    label: Text("Browse")),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.03),
                                ElevatedButton.icon(
                                    style: ButtonStyle(
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.only(
                                              top: 15,
                                              bottom: 17,
                                              left: 72,
                                              right: 72)),
                                      // backgroundColor: MaterialStateProperty.all(
                                      //     Colors.white),
                                      textStyle: MaterialStateProperty.all(
                                          TextStyle(fontSize: 20)),
                                    ),
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.check,
                                      color: HexColor("#ffffff"),
                                    ),
                                    label: Text(
                                      "Generate",
                                      style:
                                          TextStyle(color: HexColor("#ffffff")),
                                    )),
                              ],
                            )
                          ]),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: Container(
                child: ButtonOptions(),
              ))
        ],
      )),
    );
  }
}
