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
  final notSelectedColor = Colors.grey[300];
  final selectedColor = Colors.white;
  final numberOfIcon = 5;
  final height = 70.0;
  var screenSize;
  int _selectedIndex = 3;
  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;

    return Row(
      children: [
        buildNavBarItem(
          iconAssetName: "images/login.png",
          iconLabel: 'Login',
          index: 0,
        ),
        buildNavBarItem(
          iconAssetName: "images/request.png",
          iconLabel: 'Track Claim',
          index: 1,
        ),
        buildNavBarItem(
          iconAssetName: "images/location.png",
          iconLabel: 'Find Branch',
          index: 2,
        ),
        buildNavBarItem(
          iconAssetName: "images/customer_service.png",
          iconLabel: 'Contact us',
          index: 3,
        ),
        buildNavBarItem(
          iconAssetName: "images/cart.png",
          iconLabel: 'By Insurance',
          index: 4,
        ),
      ],
    );
  }

  Widget buildNavBarItem({String iconAssetName, String iconLabel, int index}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        color: notSelectedColor, //Colors.red,
        child: Container(
          height: height,
          width: screenSize.width / numberOfIcon,
          decoration: BoxDecoration(
            color: index == _selectedIndex ? selectedColor : notSelectedColor,
            borderRadius: index == _selectedIndex
                ? BorderRadius.only(
                    bottomRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0))
                : BorderRadius.only(
                    bottomRight: Radius.circular(10.0),
                    topLeft: Radius.circular(10.0)),
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image(image: AssetImage(iconAssetName)),
            Container(
              child: Center(
                  child: Text(
                iconLabel,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12.0,fontWeight: FontWeight.bold,color:index == _selectedIndex
                    ? Colors.black: Colors.grey,),
              )),
             // color: Colors.red,
              height: 30,
              width: 63,
            ),
          ]),
        ),
      ),
    );
  }
}
