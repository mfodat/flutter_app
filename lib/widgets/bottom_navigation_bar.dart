import 'package:flutter/material.dart';
import '../screens/show_history_screen.dart';

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
    return BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            activeIcon: ImageIcon(
              AssetImage("images/group.png"),
              color: Colors.deepPurple,
              size: imageSize,

            ),
            icon: ImageIcon(
              AssetImage("images/group.png"),
              color: Colors.green,
              size: imageSize,
            ),
            // label: 'telemedicine',
            title: Text(
              'Login',
              style: TextStyle(fontSize: fontSize, color: Colors.black),
            ),

            backgroundColor: barItemBGColor,
          ),
          BottomNavigationBarItem(

            icon: ImageIcon(
              AssetImage("images/request.png"),
              color: imageIconColor,
              size: imageSize,
            ),
            // label: 'Approvals',
            title: Text(
              'request',
              style: TextStyle(fontSize: fontSize),
            ),
            backgroundColor: barItemBGColor,
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("images/location.png"),
              color: imageIconColor,
              size: imageSize,
            ),
            //   label: 'dwaee',
            title: Text(
              'location',
              style: TextStyle(fontSize: fontSize),
            ),
            backgroundColor: barItemBGColor,
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("images/customer_service.png"),
              color: imageIconColor,
              size: imageSize,
            ),
            //  label: 'Eligibility',
            title: Text(
              'Contact us',
              style: TextStyle(fontSize: fontSize),
            ),
            backgroundColor: barItemBGColor,
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("images/cart.png"),
              color: imageIconColor,
              size: imageSize,
            ),
            // label: 'Benefits',
            title: Text(
              'cart',
              style: TextStyle(fontSize: fontSize),
            ),
            backgroundColor: barItemBGColor,
          ),
        ],
       backgroundColor: barBgColor,
        type: BottomNavigationBarType.shifting,
        currentIndex: currentTab,

        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.deepPurple,
        iconSize: 40,
        onTap: (int index) {
          setState(() {
            currentTab = index;
          });
        },
        elevation: 5);
  }
}
