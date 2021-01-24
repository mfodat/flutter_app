import 'package:flutter/material.dart';
import './custom.dart';

const Color imageIconColor = Colors.blue;
const Color barItemBGColor =Colors.grey;
const Color barBgColor =  Colors.red;
const double imageSize = 70;
const double fontSize = 20;

class MedicalPolicesBottomNavigationBar extends StatefulWidget {

  @override
  _MedicalPolicesBottomNavigationBarState createState() => _MedicalPolicesBottomNavigationBarState();
}

class _MedicalPolicesBottomNavigationBarState extends State<MedicalPolicesBottomNavigationBar> {
  int currentTab=0;
  @override
  Widget build(BuildContext context) {
    return FABBottomAppBar(
      centerItemText: 'test',
      color: Colors.grey,
      backgroundColor: Colors.white,
      selectedColor: Colors.red,
      notchedShape: CircularNotchedRectangle(),
      onTabSelected: (int i) {} ,
      items: [
        FABBottomAppBarItem(iconData: Icons.home, text: 'home'),
        FABBottomAppBarItem(iconData: Icons.search, text: 'search'),
        FABBottomAppBarItem(iconData: Icons.account_circle, text: 'account'),
        FABBottomAppBarItem(iconData: Icons.more_horiz, text: 'more'),
      ],
    );
  }
}
