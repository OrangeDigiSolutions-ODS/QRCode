import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:qrorange/screen/image_to_qr.dart';

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
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    LandingPage(),
    Text(
      'Index 1: Scan Satu',
      style: optionStyle,
    ),
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
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 0,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.extension, 'Create', 0),
            title: SizedBox.shrink(),
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.camera_enhance, 'Scan', 1),
            title: SizedBox.shrink(),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: _selectedItemColor,
        unselectedItemColor: _unselectedItemColor,
      ),
    );
  }
}
