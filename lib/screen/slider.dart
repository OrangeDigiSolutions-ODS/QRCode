import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bottom_navigation.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
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
    final double height = MediaQuery.of(context).size.height * 0.70;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Stack(children: [
              CarouselSlider(
                carouselController: _controller,
                options: CarouselOptions(
                    height: height,
                    autoPlay: true,
                    enlargeCenterPage: false,
                    viewportFraction: 1.0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
                items: imgList
                    .map((item) => Container(
                          child: Center(
                              child: Image.network(
                            item,
                            fit: BoxFit.cover,
                            height: height,
                            width: MediaQuery.of(context).size.width,
                          )),
                        ))
                    .toList(),
              ),
              Container(
                  child: Image.asset("assets/images/logo.png"),
                  width: 60.0,
                  height: 60.0,
                  margin: EdgeInsets.only(top: 32, left: 24)),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imgList.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4.0, left: 4.0),
                    child: Container(
                      width: MediaQuery.of(context).size.height * 0.01,
                      height: MediaQuery.of(context).size.height * 0.01,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black)
                              .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.0,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ConstrainedBox(
                  constraints: BoxConstraints.tightFor(
                      width: MediaQuery.of(context).size.width * 0.80,
                      height: MediaQuery.of(context).size.height * 0.07),
                  child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: Color(0xffDD4C00)),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => buttomNav()));
                      },
                      child: Text(
                        "Get Started >",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.09,
            )
          ],
        ),
      ),
    );
  }
}

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          child: Container(
            child: ClipRRect(
                child: Stack(
              children: <Widget>[
                Image.network(
                  item,
                  fit: BoxFit.cover,
                  width: 1000.0,
                ),
              ],
            )),
          ),
        ))
    .toList();
