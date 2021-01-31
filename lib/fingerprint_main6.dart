import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  LocalAuthentication biometricsAuth = new LocalAuthentication();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Local Auth Example'),
      ),
      body: Container(
        padding: EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text("can check biometrics $_canCheckBiometrics"),
              RaisedButton(
                child: Text('check biometrics', style: TextStyle(fontSize: 20),),
                onPressed: () {_checkBiometrics();},
              ),
              Text("Available biometrics $_availableBiometrics"),
              RaisedButton(
                child: Text('get Available biometrics', style: TextStyle(fontSize: 20),),
                onPressed: () {_getAvailableBiometrics();},
              ),
              Text("current state $_auth"),
              RaisedButton(
                child: Text('Auth', style: TextStyle(fontSize: 20),),
                onPressed: () {_Auth();},
              ),

            ],
          ),
        ),
      ),
    );
  }

bool _canCheckBiometrics;
  List<BiometricType>  _availableBiometrics ;
  String _auth = 'Not Authorized';
  Future<void> _checkBiometrics() async {
    bool canCheckBiometrics;
   try{
     canCheckBiometrics =await biometricsAuth.canCheckBiometrics;
   } on PlatformException catch(e){
     print(e);
   }
   if(! mounted) return;
  //  _canCheckBiometrics
   setState(() {
     _canCheckBiometrics=canCheckBiometrics;
   });
  }

  Future<void> _getAvailableBiometrics() async {
    List<BiometricType>   availableBiometrics ;
    try{
      availableBiometrics = await biometricsAuth.getAvailableBiometrics();
    } on PlatformException catch(e){
      print(e);
    }
    if(! mounted) return;
    //  _canCheckBiometrics
    setState(() {
      _availableBiometrics=availableBiometrics;
    });

  }

  Future<void> _Auth() async {

    bool authin =false;
    try{
      authin =await biometricsAuth.authenticateWithBiometrics(localizedReason: 'scan your fingure',
          stickyAuth: true,
      useErrorDialogs: true);
    } on PlatformException catch(e){
      print(e);
    }
    if(! mounted) return;
    //  _canCheckBiometrics
    setState(() {
      _auth =  authin ? 'Authorized':'Not Authorized';
    });
  }


}