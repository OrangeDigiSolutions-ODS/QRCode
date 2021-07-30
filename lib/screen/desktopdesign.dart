// import "package:auto_size_text_pk/auto_size_text_pk.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
// import "package:hexcolor/hexcolor.dart";
import "/category/category.dart";
// import "topbar.dart";

class DesktopDesign extends StatefulWidget {
  const DesktopDesign({Key? key}) : super(key: key);

  @override
  _DesktopDesignState createState() => _DesktopDesignState();
}

class _DesktopDesignState extends State<DesktopDesign> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
  }

  @override
  Widget build(BuildContext context) => const SafeArea(child: Category());
  //   Column(
  // children: <Widget>[
  // const Expanded(
  //     // flex: 1,
  //     child: TopBar()),
  // // TopBar(),
  // Expanded(
  //   flex: 6,
  //   child: Padding(
  //     padding:
  //         const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
  //     child: Row(
  //       children: <Widget>[
  //         Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: <Widget>[
  //             Container(
  //                 height: MediaQuery.of(context).size.height * 0.40,
  //                 width: MediaQuery.of(context).size.width * 0.40,
  //                 decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(5)),
  //                 child: ListView.builder(
  //                     scrollDirection: Axis.horizontal,
  //                     shrinkWrap: true,
  //                     itemCount: 0,
  //                     itemBuilder: (_, __) => Column(
  //                           children: <Widget>[
  //                             Image.network(
  //                               "[index]",
  //                               fit: BoxFit.scaleDown,
  //                               height: MediaQuery.of(context)
  //                                       .size
  //                                       .height *
  //                                   0.35,
  //                               width: MediaQuery.of(context)
  //                                       .size
  //                                       .width *
  //                                   0.40,
  //                             ),
  //                             const SizedBox(
  //                               height: 10,
  //                             )
  //                           ],
  //                         ))),
  //             Padding(
  //               padding: const EdgeInsets.only(top: 7),
  //               child: Builder(builder: (_) => const Text("imtext")),
  //             )
  //           ],
  //         ),
  //         SizedBox(
  //           height: MediaQuery.of(context).size.height * 0.10,
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.symmetric(vertical: 18),
  //           child: Container(
  //             height: MediaQuery.of(context).size.height * 0.70,
  //             width: MediaQuery.of(context).size.width * 0.50,
  //             alignment: Alignment.center,
  //             child: Column(
  //                 children: <Widget>[
  //                   Container(
  //                     height:
  //                         MediaQuery.of(context).size.height * 0.40,
  //                     width: MediaQuery.of(context).size.width,
  //                     margin: const EdgeInsets.only(top: 20),
  //                     child: const AutoSizeText(
  //                       "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Iaculis at sed facilisis duis hac laoreet ipsum malesuada enim. Suspendisse pulvinar at iaculis urna integer ultrices sagittis rhoncus. Euismod faucibus vitae sed asdfsdafasdfasdfasdfasdfasdfasdfkfbasdkljhsdjlkafhljajs;hdflasdhuhjskldbfgfahflskjfhadsljfhlfhladsfhladshflkashflkahflhf;la;dfhaldfhlf suspendisse fames. Urna dictum aliquam donec semper.",
  //                       overflow: TextOverflow.clip,
  //                       // maxLines: 10,
  //                       minFontSize: 20,
  //                       // wrapWords: true,
  //                       // softWrap: true,
  //                     ),
  //                   ),
  //                   Container(
  //                     width: MediaQuery.of(context).size.width,
  //                     height:
  //                         MediaQuery.of(context).size.height * 0.04,
  //                     alignment: Alignment.center,
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       // crossAxisAlignment: CrossAxisAlignment.end,
  //                       children: <Widget>[
  //                         ElevatedButton(
  //                           style: ElevatedButton.styleFrom(
  //                               padding: const EdgeInsets.symmetric(
  //                                   horizontal: 35, vertical: 10),
  //                               primary: Colors.white,
  //                               side: BorderSide(
  //                                   color: HexColor("#b0afae"))),
  //                           onPressed: () {
  //                             setState(() {});
  //                           },
  //                           child: Row(
  //                             children: <Widget>[
  //                               const Icon(
  //                                 Icons.insert_drive_file,
  //                               ),
  //                               Text("Browse",
  //                                   style: TextStyle(
  //                                       fontSize: 20,
  //                                       color: HexColor("#000000"))),
  //                             ],
  //                           ),
  //                         ),
  //                         const SizedBox(width: 10),
  //                         ElevatedButton(
  //                           style: ElevatedButton.styleFrom(
  //                               padding: const EdgeInsets.symmetric(
  //                                   horizontal: 35, vertical: 10),
  //                               primary: const Color(0xffDD4C00)),
  //                           onPressed: () {},
  //                           child: Row(
  //                             children: <Widget>[
  //                               Icon(Icons.check,
  //                                   color: HexColor("#ffffff")),
  //                               Text("Generate",
  //                                   style: TextStyle(
  //                                       fontSize: 20,
  //                                       color: HexColor("#ffffff")))
  //                             ],
  //                           ),
  //                         ),
  //                         const Text("upload successful"),
  //                         const Text("File not supported")
  //                       ],
  //                     ),
  //                   )
  //                 ]),
  //           ),
  //         )
  //       ],
  //     ),
  //   ),
  // ),
  //   Expanded(child: Category())
  // ],
  // )),
  // );
}
