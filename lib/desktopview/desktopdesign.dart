import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "/category/category.dart";

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
  
}
