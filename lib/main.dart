import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

import 'widgets/bottom_navigation_bar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // reference to our single class that manages the database
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHight = MediaQuery.of(context).size.height;
    double radius = screenWidth *5/4;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(

              top: 5.0 ,
              //height: 200.0,
              left: 5.0,
              child: Container(
                color: Colors.white,
                width: radius,
                height: radius,
                child: Text('by'),
               /* decoration: BoxDecoration(
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(radius),
                    bottomLeft: Radius.circular(radius),
                    topRight:  Radius.circular(radius),
                    topLeft:  Radius.circular(radius),

                  ),
                ),*/
              ),
            ),
            Positioned(

              top: screenWidth *-0.6,
              //height: 200.0,
              left: screenWidth *-1/8,
              child: Container(
              //  color: Colors.yellow,
                width: radius-5,
                height: radius-5,
                child: Text('by'),
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(radius),
                    bottomLeft: Radius.circular(radius),
                    topRight:  Radius.circular(radius),
                    topLeft:  Radius.circular(radius),

                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
