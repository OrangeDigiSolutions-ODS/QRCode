import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ButtonOptions extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ButtonOptionsState();
  }
}

class ButtonOptionsState extends State<ButtonOptions> {
  @override
  Widget build(BuildContext context) {
    return
        // Row(
        //   children: [
        Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            color: HexColor("#C6C6C6"),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .163,
            child: Center(
              child: new ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: 2,
                  // itemExtent: 10.0,
                  // reverse: true, //makes the list appear in descending order
                  itemBuilder: (BuildContext context, int index) {
                    return _buildItems(index);
                  }),
            )),
        // Center(
        //     child: RangeSlider(
        //   values: RangeValues(1, 3),
        //   onChanged: (RangeValues value) {},
        // ))
        // ],
      ],
    );
  }
}

Widget _buildItems(int index) {
  String ext;
  Icon icons;
  if (index == 0) {
    ext = "Image";

    icons = Icon(
      Icons.image_outlined,
      color: Color(0xffDD4C00),
      size: 36,
    );
  } else {
    ext = "Pdf";
    icons = Icon(
      Icons.picture_as_pdf,
      color: Color(0xffDD4C00),
      size: 36,
    );
  }
  return new Container(
    // color: Colors.blue,
    padding: const EdgeInsets.only(left: 10.0),
    child: Row(
      children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FittedBox(
                child: Container(
                  width: 80.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3.5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: const Offset(2.0, 2.0),
                          blurRadius: 1.0,
                          spreadRadius: 0.7,
                        ),
                      ],
                      color: Colors.white,
                      border: Border.all(color: Color(0xffDD4C00) //orange color
                          )),
                  // width: MediaQuery.of(context).size.width*0.2,
                  // padding: EdgeInsets.only(left: 17, top: 13, right: 17),
                  padding: EdgeInsets.fromLTRB(17, 13, 17, 0),

                  child: Column(
                    children: [
                      icons,
                      Padding(
                        padding: const EdgeInsets.only(top: 3.0, bottom: 3.0),
                        child: Text(
                          ext,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff353535)),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ])
      ],
    ),
  );
}
