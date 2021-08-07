import "package:flutter/material.dart";
import "/category/category.dart";
import "/colors/colorcode.dart";
import "/screen/scanpage.dart";

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final Color _selectedItemColor = ColorCode.white;
  final Color _unselectedItemColor = ColorCode.white;
  final Color _selectedBgColor = ColorCode.orange;
  final Color _unselectedBgColor = ColorCode.grey;
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Category(),
    ScanPage(),
    // ViewQRPDF()
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

  Widget _buildIcon(IconData iconData, String text, int index) => SizedBox(
        width: double.infinity,
        height: kBottomNavigationBarHeight,
        child: Material(
          color: _getBgColor(index),
          child: InkWell(
            onTap: () => _onItemTapped(index),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(iconData),
                Text(text,
                    style:
                        TextStyle(fontSize: 12, color: _getItemColor(index))),
              ],
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(child: LayoutBuilder(
          builder: (_, __) {
            if (__.maxWidth < 768) {
              return _widgetOptions.elementAt(_selectedIndex);
            } else {
              return Container();
            }
          },
        )),
        bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 0,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: _buildIcon(Icons.extension, "Create", 0),
              label: "Create",
            ),
            BottomNavigationBarItem(
              icon: _buildIcon(Icons.camera_enhance, "Scan", 1),
              // title: SizedBox.shrink(),
              label: "Scan",
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: _selectedItemColor,
          unselectedItemColor: _unselectedItemColor,
        ),
      );
}
