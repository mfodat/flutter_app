import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
  final List  _colors = [
    Colors.blue,
    Colors.green,
    Colors.red,
  ];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHight = MediaQuery.of(context).size.height;
    final backgroundColor = Colors.red;
    //double radius = screenWidth * 5 / 4;

    double radius = 800 * screenWidth / (screenHight - 100);
    print('screenWidth $screenWidth');
    print('screenHight $screenHight');
    print('radius $radius');
    final top = (screenWidth * -0.7);
    print('top $top');
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: MedicalPolicesBottomNavigationBar(),
        // backgroundColor: backgroundColor,
        body: Stack(
          children: [
            Positioned(
              top: radius + top + 25,
              //height: 200.0,
              left: 2,
              child: Column(
                children: [
                  Container(
                    color: _colors[selectedIndex],
                    width: screenWidth - 4,
                    height: (screenHight - 125 - radius - top) / 3,
                    child: Text('by'),
                  ),
                  Container(
                    color: _colors[selectedIndex],
                    width: screenWidth - 4,
                    height: (screenHight - 125 - radius - top) / 3,
                    child: Text('by'),
                  ),
                  Container(
                    color: _colors[selectedIndex],
                    width: screenWidth - 4,
                    height: (screenHight - 125 - radius - top) / 3,
                    child: Text('by'),
                  ),
                ],
              ),
            ),
            Positioned(
              top: screenWidth * -0.6,
              //height: 200.0,
              left: screenWidth * -1 / 8,
              child: Container(
                //  color: Colors.yellow,
                width: radius,
                height: radius,
                child: Text('by'),
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(radius),
                    bottomLeft: Radius.circular(radius),
                    topRight: Radius.circular(radius),
                    topLeft: Radius.circular(radius),
                  ),
                ),
              ),
            ),
            Positioned(
              top: radius / 7,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  CarouselSlider(
                    onPageChanged: (index) { print(' index $index');
                    setState(() {
                      selectedIndex = (index+1)%3;
                    });
                    },
                    enlargeCenterPage: true,
                    viewportFraction: 0.9,
                    items: _colors.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: screenWidth ,
                            margin: EdgeInsets.symmetric( horizontal: 5),
                            height: radius / 3,
                            child: Text(' '),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 8.0,
                                  spreadRadius: 3,
                                  offset: Offset(0, 10),
                                ),
                              ],
                              color: i,//Colors.white,
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                topLeft: Radius.circular(10),
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
/*
            Positioned(
              top: radius/6,
              //height: 200.0,
              left: screenWidth-15,
             // right: -screenWidth,
              child: Column(
                children: [
                  Container(
                    //  color: Colors.black,
                    width: radius ,
                    height: radius/3-15,
                    child: Text(' '),
                    decoration: BoxDecoration(
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05),
                        blurRadius: 8.0,spreadRadius: 3,offset: Offset(0,10),),],
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                       //bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      //  topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                      ),
                    ),
                  ),

                ],
              ),
            ),
            Positioned(
              top: radius/6,
              //height: 200.0,
              left: -15,
              right: screenWidth-15,
              child: Column(
                children: [
                  Container(
                    //  color: Colors.black,
                    width: radius ,
                    height: radius/3-15,
                    child: Text(' '),
                    decoration: BoxDecoration(
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05),
                        blurRadius: 8.0,spreadRadius: 3,offset: Offset(0,10),),],
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10),
                       // bottomLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      //  topLeft: Radius.circular(10),
                      ),
                    ),
                  ),

                ],
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
