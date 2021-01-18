import 'package:flutter/material.dart';
import '../screens/show_history_screen.dart';

const Color imageIconColor = Colors.white;
const Color barItemBGColor= Colors.red;
const Color barBgColor = Colors.blueGrey;
const double imageSize = 30;
const double fontSize = 10;

class MedicalPolicesBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(

        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(

            icon: ImageIcon(
              AssetImage("images/telemedicine.png"),
              color: imageIconColor,
              size: imageSize,
            ),
            // label: 'telemedicine',
            title: Text('telemedicine',style: TextStyle(fontSize: fontSize),),
            backgroundColor: barItemBGColor,
          ),
          BottomNavigationBarItem(

            icon: ImageIcon(
              AssetImage("images/my_claim.png"),
              color: imageIconColor,
              size: imageSize,
            ),
            // label: 'Approvals',
            title: Text('Approvals',style: TextStyle(fontSize: fontSize),),
            backgroundColor: barItemBGColor,
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("images/policy_dwaee.png"),
              color: imageIconColor,
              size: imageSize,
            ),
            //   label: 'dwaee',
            title: Text('dwaee',style: TextStyle(fontSize: fontSize),),
            backgroundColor: barItemBGColor,
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("images/policy_eligibility.png"),
              color: imageIconColor,
              size: imageSize,
            ),
            //  label: 'Eligibility',
            title: Text('Eligibility',style: TextStyle(fontSize: fontSize),),
            backgroundColor: barItemBGColor,
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("images/policy_benefits.png"),
              color: imageIconColor,
              size: imageSize,
            ),
            // label: 'Benefits',
            title: Text('Benefits',style: TextStyle(fontSize: fontSize),),
            backgroundColor: barItemBGColor,
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("images/policy_provider.png"),
              color: imageIconColor,
              size: imageSize,
            ),
            //label: 'provider',
            title: Text('provider',style: TextStyle(fontSize: fontSize),),
            backgroundColor: barItemBGColor ,
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("images/policy_reimburse.png"),
              color: imageIconColor,
              size: imageSize,
            ),
            //label: 'reimburse',
            title: Text('reimburse',style: TextStyle(fontSize: fontSize),),

            backgroundColor: imageIconColor,
          )
        ],
        backgroundColor:barBgColor ,
        type: BottomNavigationBarType.fixed,
        currentIndex: 1,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        iconSize: 40,
        onTap: (int index) {
          Navigator.push(
            context,
            new MaterialPageRoute(builder: (context) {
              return ShowHistoryScreen();
            }),
          );

        },
        elevation: 5);
  }
}
