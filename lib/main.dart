import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SQFlite Demo',
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
  LocalAuthentication auth = new LocalAuthentication();
  bool valuefirst = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 5.0, top: 10.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(
              alignment: Alignment.centerLeft,
              // color: Colors.red,
              padding: const EdgeInsets.only(left:10.0, top: 10.0),
              child: Hero(
                tag: 'test',
                child: Image(
                  image: AssetImage('images/icon3x.png'),
                  fit: BoxFit.cover,
                  width: 53.0,
                  height: 55.0,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.only(left: 10.0, top: 10.0),
              width: double.infinity,
              child: Text(
                'Welcome Back, Login Now!',
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.only(left: 5.0, top: 10.0),
              width: double.infinity,
              child: Text(
                'Username',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: double.infinity,
              // color: Colors.red,
              padding: const EdgeInsets.only(left: 5.0, right: 15.0, top: 5.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter your Username',
                  focusColor: Colors.amber,

                  // filled: true,
                  //  fillColor: Color(0xFFDBEDFF),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    borderSide: BorderSide(color: Colors.grey[400]),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.amber),
                  ),
                  //   decoration: InputDecoration(labelText: 'Password'),
                  // obscureText: true,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 5.0, top: 10.0),
              width: double.infinity,
              child: Text(
                'Password',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: double.infinity,
              // color: Colors.red,
              padding: const EdgeInsets.only(left: 5.0, right: 15.0, top: 5.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  focusColor: Colors.amber,
                  // filled: true,
                  //  fillColor: Color(0xFFDBEDFF),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    borderSide: BorderSide(color: Colors.grey[400]),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.amber),
                  ),
                  //   decoration: InputDecoration(labelText: 'Password'),
                  // obscureText: true,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: double.infinity,
              //color: Colors.red,
               padding: const EdgeInsets.only(left: 0.0,right: 15.0, top: 5.0),
             // margin: const EdgeInsets.only(left: 00.0, right: 15.0, top: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Checkbox(
                    checkColor: Colors.greenAccent,
                    activeColor: Colors.red,
                    value: this.valuefirst,
                    onChanged: (bool value) {
                      setState(() {
                        this.valuefirst = value;
                      });
                    },
                  ),
                  //
                  Text(
                    'Remember me',
                    style: TextStyle(fontSize: 15.0),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    width: 30.0,
                  ),
                  Text('Forgot Password',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
