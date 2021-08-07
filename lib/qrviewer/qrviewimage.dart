import "package:carousel_slider/carousel_options.dart";
import "package:carousel_slider/carousel_slider.dart";
import "package:flutter/material.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "/colors/colorcode.dart";

// ignore: must_be_immutable
class ViewQRImage extends StatefulWidget {
  ViewQRImage({
    this.uri,
    Key? key,
  }) : super(key: key);
  String? uri;
  @override
  // ignore: no_logic_in_create_state
  _ViewQRImageState createState() => _ViewQRImageState(uri!);
}

class _ViewQRImageState extends State<ViewQRImage> {
  _ViewQRImageState(this.uri);
  String uri;
  final GlobalKey<CarouselSliderState> sslKey = GlobalKey();

  CollectionReference<Object> images =
      FirebaseFirestore.instance.collection("images");
  CollectionReference<Object> id = FirebaseFirestore.instance.collection("id");

  @override
  Widget build(BuildContext context) {
    String? urisplit;
    setState(() {
      urisplit = uri.split("=").last;
    });
    // if (urisplit!.contains(uri) == true) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("QRange"),
      ),
      body: Container(
        alignment: Alignment.center,
        color: ColorCode.black,
        child: Builder(
          builder: (_) => FutureBuilder<DocumentSnapshot<Object>>(
            future: images.doc(urisplit).get(),
            builder: (_, __) {
              if (__.connectionState == ConnectionState.done &&
                  __.hasData &&
                  __.data != null) {
                final List<int> itemabx = <int>[];
                List<dynamic> imageurl1 = <dynamic>[];
                final int data = int.parse(__.data!["image"].toString());
                // print(data);

                return FutureBuilder<DocumentSnapshot<Object>>(
                    future: images
                        .doc(urisplit)
                        .collection("value")
                        .doc("links")
                        .get(),
                    builder: (_, __) {
                      if (__.connectionState == ConnectionState.done) {
                        final Map<String, dynamic> data1 =
                            // ignore: cast_nullable_to_non_nullable
                            __.data!.data() as Map<String, dynamic>;

                        imageurl1 = data1.values.toList();
                        for (int item = 0; item < data; item++) {
                          itemabx.add(item);
                        }

                        return SizedBox(
                          height: double.infinity,
                          width: double.infinity,
                          child: CarouselSlider.builder(
                            options: CarouselOptions(
                              height: MediaQuery.of(context).size.height * 0.9,
                              viewportFraction: 1,
                              aspectRatio: 1,
                            ),
                            itemCount: imageurl1.length,
                            key: sslKey,
                            itemBuilder: (_, __, ___) => Card(
                              margin: const EdgeInsets.all(5),
                              color: ColorCode.orange,
                              child: Stack(children: <Widget>[
                                Center(
                                  child: GestureDetector(
                                    child:
                                        // Image.network("${imageurl1[__]}",
                                        Image(
                                            image: NetworkImage(
                                                "${imageurl1[__]}"),
                                            // fit: BoxFit.cover,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: const EdgeInsets.fromLTRB(2, 0, 0, 0),
                                  child: IconButton(
                                      onPressed: () {
                                        sslKey.currentState!.pageController!
                                            .previousPage(
                                                duration: const Duration(
                                                    milliseconds: 300),
                                                curve: Curves.linear);
                                      },
                                      icon: const Icon(
                                          Icons.keyboard_arrow_left)),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  margin: const EdgeInsets.fromLTRB(0, 0, 2, 0),
                                  child: IconButton(
                                      onPressed: () {
                                        sslKey.currentState!.pageController!
                                            .nextPage(
                                                duration: const Duration(
                                                    milliseconds: 300),
                                                curve: Curves.linear);
                                      },
                                      icon: const Icon(
                                          Icons.keyboard_arrow_right)),
                                ),
                              ]),
                            ),
                          ),
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    });
                // : Image.asset("assets/Artboard.png");
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
    // }
    // return const Text("hello");
    // Center(
    //   child: CircularProgressIndicator(),
    // );
  }
}
