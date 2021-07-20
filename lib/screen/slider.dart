import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qrcode/screen/landingpage.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1600147131759-880e94a6185f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cXIlMjBjb2RlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
];

final themeMode = ValueNotifier(1);

class CarouselWithIndicatorDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Column(children: [
              Expanded(
                child: CarouselSlider(
                  items: imageSliders,
                  carouselController: _controller,
                  options: CarouselOptions(
                      height: height,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      viewportFraction: 1.0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      }),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: imgList.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _controller.animateToPage(entry.key),
                    child: Container(
                      margin: EdgeInsets.only(top: 5.0),
                      width: 6.0,
                      height: 6.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black)
                              .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                    ),
                  );
                }).toList(),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LandingPage()),
                  );
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(67.0, 60.0, 65.0, 144.0),
                  width: 243.0,
                  height: 52.0,
                  padding: EdgeInsets.fromLTRB(43.0, 15.0, 45.84, 11.48),
                  child: Center(
                    child: Text(
                      "Get Started >",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xffDD4C00),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ]),
            Container(
                child: Image.asset("assets/images/logo.png"),
                width: 60.0,
                height: 60.0,
                margin: EdgeInsets.only(top: 32, left: 24)),
            Container(
              width: 269.0,
              height: 9.5,
              color: Colors.white,
              margin: EdgeInsets.only(top: 374, left: 53, right: 53),
            ),
            Container(
              width: 269.0,
              height: 9.5,
              color: Colors.white,
              margin: EdgeInsets.only(top: 394, left: 53, right: 53),
            ),
            Container(
              width: 269.0,
              height: 9.5,
              color: Colors.white,
              margin: EdgeInsets.only(top: 414, left: 86, right: 86),
            )
          ],
        ),
      ),
    );
  }
}

final List<Widget> imageSliders = imgList
    .map(
      (item) => Container(
        child: Container(
          child: ClipRRect(
              child: Stack(
            children: <Widget>[
              Image.network(
                item,
                fit: BoxFit.cover,
                height: 553.0,
                width: 1000.0,
              ),
            ],
          )),
        ),
      ),
    )
    .toList();
