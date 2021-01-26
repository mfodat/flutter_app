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
    Color.fromRGBO(255, 251, 247, 1),
    Color.fromRGBO(255, 251, 247, 1),
    Color.fromRGBO(255, 251, 247, 1),
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
    final backgroundColor = Color.fromRGBO(253, 253, 253, 1);
    double radius = screenHight * .6;

   // double radius = 800 * screenWidth / (screenHight - 100);
    print('screenWidth $screenWidth');
    print('screenHight $screenHight');
    print('radius $radius');
    final top = (screenWidth * -0.7);
    print('top $top');
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: MedicalPolicesBottomNavigationBar(),
         backgroundColor: backgroundColor,
        body: Stack(
          children: [
            Positioned(
              top: screenHight * .31,
              bottom: 0,
              left: 2,
              right: 2,
              child: Container(
                padding: EdgeInsets.all(8.0),
               // color: Colors.green,
               // height: double.infinity,
                child: GridView.count(

                  crossAxisCount: 2 ,
                  children: List.generate(6,(index){
                    return Container(
                      padding: EdgeInsets.all(8.0),
                      height: 20,
                      width: 280,
                      child: Card(

                        //color: Colors.blue,
                      ),
                    );
                  },growable:false,),
                ),
                ),
              ),
            Positioned(
             top: screenHight * -0.0,
              bottom: screenHight * .6,
           //   height: 700.0,
              left: -50,
              right: -50,
              child: Container(
                //  color: Colors.yellow,
                //width: radius ,
              //  height: radius,
                child: Text('by'),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(2, 83, 115, 1),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(radius),
                    bottomLeft: Radius.circular(radius),
                  //  topRight: Radius.circular(radius),
                 //   topLeft: Radius.circular(radius),
                  ),
                ),
              ),
            ),
             Positioned(
              top: screenHight * .11,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  CarouselSlider(
                    height: screenHight * .2,
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