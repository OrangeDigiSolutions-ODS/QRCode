import "package:carousel_slider/carousel_slider.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "/components/bottombar.dart";

final List<String> imgList = <String>[
  "https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80",
  "https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80",
];

final ValueNotifier<int> themeMode = ValueNotifier<int>(1);

class SliderPage extends StatefulWidget {
  const SliderPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height * 0.65;
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.1,
        child: Column(
          children: <Widget>[
            Stack(children: <Widget>[
              CarouselSlider(
                carouselController: _controller,
                options: CarouselOptions(
                    height: height,
                    autoPlay: true,
                    viewportFraction: 1,
                    onPageChanged: (_, __) {
                      setState(() {
                        _current = _;
                      });
                    }),
                items: imgList
                    .map((_) => Center(
                            child: Image.network(
                          _,
                          fit: BoxFit.cover,
                          height: height,
                          width: MediaQuery.of(context).size.width,
                        )))
                    .toList(),
              ),
              Container(
                  width: 60,
                  height: 60,
                  margin: const EdgeInsets.only(top: 32, left: 24),
                  child: Image.asset("assets/images/logo.png")),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imgList
                  .asMap()
                  .entries
                  .map((_) => GestureDetector(
                        onTap: () => _controller.animateToPage(_.key),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4, left: 4),
                          child: Container(
                            width: MediaQuery.of(context).size.height * 0.01,
                            height: MediaQuery.of(context).size.height * 0.01,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: (Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black)
                                    .withOpacity(
                                        _current == _.key ? 0.9 : 0.4)),
                          ),
                        ),
                      ))
                  .toList(),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: ConstrainedBox(
                constraints: BoxConstraints.tightFor(
                    width: MediaQuery.of(context).size.width * 0.80,
                    height: MediaQuery.of(context).size.height * 0.07),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: const Color(0xffDD4C00)),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute<Widget>(
                          builder: (_) => const BottomBar()));
                    },
                    child: const Text(
                      "Get Started >",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
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

List<Widget> imageSliders = imgList
    // ignore: always_specify_types
    .map<Widget>((_) => ClipRRect(
            child: Stack(
          children: <Widget>[
            Image.network(
              _,
              fit: BoxFit.cover,
              width: 1000,
            ),
          ],
        )))
    .toList();
