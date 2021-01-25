import 'package:flutter/material.dart';
import '../screens/show_history_screen.dart';


const Color barItemBGColor = Colors.grey;
const Color barBgColor = Colors.red;
const double imageSize = 70;
const double fontSize = 20;

class MedicalPolicesBottomNavigationBar extends StatefulWidget {
  @override
  _MedicalPolicesBottomNavigationBarState createState() =>
      _MedicalPolicesBottomNavigationBarState();
}

class _MedicalPolicesBottomNavigationBarState
    extends State<MedicalPolicesBottomNavigationBar> {
  int currentTab = 0;
  final notSelectedColor =  Colors.white ;
  final selectedColor =  Colors.green ;
  final numberOfIcon = 5;
  final height = 60.0;
  var screenSize ;
  int _selectedIndex = 3;
  @override
  Widget build(BuildContext context) {
       screenSize = MediaQuery.of(context).size;


    return Row(
      children: [
        buildNavBarItem(
          iconData: Icons.home,
          index: 0,
        ), buildNavBarItem(
          iconData: Icons.card_giftcard,
          index: 1,
        ), buildNavBarItem(
          iconData: Icons.camera,
          index: 2,
        ), buildNavBarItem(
          iconData: Icons.pie_chart,
          index: 3,
        ), buildNavBarItem(
          iconData: Icons.person,
          index: 4,
        ),
      ],
    );
  }

  Widget buildNavBarItem(
      {IconData iconData,int index}) {
    return GestureDetector(
      onTap: (){ setState(() {
        _selectedIndex = index;
      });},
      child: Container(
        height: height,
        width: screenSize.width/numberOfIcon,
        decoration: BoxDecoration(
          color: index == _selectedIndex ? selectedColor:notSelectedColor,
        ),
        child: Icon(
          iconData,
        ),
      ),
    );
  }
}
