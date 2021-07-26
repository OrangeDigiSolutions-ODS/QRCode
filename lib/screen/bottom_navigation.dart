import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

// import 'ScanPage.dart';
import 'image_to_qr.dart';

// ignore: camel_case_types
class buttomNav extends StatefulWidget {
  buttomNav({Key? key}) : super(key: key);

  @override
  _buttomNavState createState() => _buttomNavState();
}

// ignore: camel_case_types
class _buttomNavState extends State<buttomNav> {
  final _selectedItemColor = Colors.white;
  final _unselectedItemColor = Colors.white;
  final _selectedBgColor = HexColor("#DD4C00");
  final _unselectedBgColor = HexColor("#353535");
  int _selectedIndex = 0;
  // static const TextStyle optionStyle =
  //     TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    LandingPage(),
    // ScanPage(),
    Text("hello")
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Color _getBgColor(int index) =>
      _selectedIndex == index ? _selectedBgColor : _unselectedBgColor;

  Color _getItemColor(int index) =>
      _selectedIndex == index ? _selectedItemColor : _unselectedItemColor;

  Widget _buildIcon(IconData iconData, String text, int index) => Container(
        width: double.infinity,
        height: kBottomNavigationBarHeight,
        child: Material(
          color: _getBgColor(index),
          child: InkWell(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(iconData),
                Text(text,
                    style:
                        TextStyle(fontSize: 12, color: _getItemColor(index))),
              ],
            ),
            onTap: () => _onItemTapped(index),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: LayoutBuilder(
        builder: (context, constraint) {
          if (constraint.maxWidth < 768) {
            return _widgetOptions.elementAt(_selectedIndex);
          } else {
            return Container();
          }
        },
      )
          //  _widgetOptions.elementAt(_selectedIndex),
          ),
      bottomNavigationBar:kIsWeb==false? BottomNavigationBar(
        selectedFontSize: 0,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.extension, 'Create', 0),
            label: "create",
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.camera_enhance, 'Scan', 1),
            // title: SizedBox.shrink(),
            label: "scan",
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: _selectedItemColor,
        unselectedItemColor: _unselectedItemColor,
      ):SizedBox.shrink(),
    );
  }
}
