import 'package:flutter/material.dart';
import 'package:flutter_app/classes/language.dart';
import 'package:flutter_app/providers/auth.dart';
import 'package:flutter_app/util/exception_handler.dart';
import 'package:flutter_app/widgets/bottom_navigation_bar.dart';
import 'package:provider/provider.dart';
import '../../localization/language_constants.dart';
import '../../main3.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool prefRead = false;

  void _changeLanguage(Language language) async {
    Locale _locale = await setLocale(language.languageCode);
    MyApp.setLocale(context, _locale);

  }

  @override
  void initState() {


    super.initState();
  }
  @override
  void didChangeDependencies() {
   print('prefRead $prefRead');
    if(!prefRead) {
      Provider.of<Auth>(context, listen: false).getLoginInfoFromPref().then((
          authData) {
        if (!mounted) return;
        print('prefRead $prefRead');
        setState(() {
          _authData = authData;
          _userNameController.text = _authData[Auth.USERNAME];
          _passwordController.text = _authData[Auth.PASSWORD];
          prefRead = true;
        });

      });
    }
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();

  }
  Map<String, dynamic> _authData = {
    Auth.USERNAME: '',
    Auth.PASSWORD: '',
    Auth.IS_USING_BIOMETRIC: false,
    Auth.IS_REMEMBER_ME: false,
  };
  var _isLoading = false;
  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {

        // Log user in
        await Provider.of<Auth>(context, listen: false).login( _authData);


    } catch (error) {
      var errorMessage = ExceptionHandler.handelException(error);
      _showErrorDialog(errorMessage);
    }


    setState(() {
      _isLoading = false;
    });
  }
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }
  Locale _locale ;

  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHight = MediaQuery.of(context).size.height;

    return Container(
      color: Color.fromRGBO(88, 141, 162, 1),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Form(
          key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 23.0, top: 0.0,right: 23.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          //    color: Colors.red,
                          padding: const EdgeInsets.only(left: 0.0, top: 22.0),
                          child: Image(
                            image: AssetImage('images/icon3x.png'),
                            fit: BoxFit.cover,
                            width: screenWidth * .166,
                            height: screenHight * 0.074,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: GestureDetector(
                            onTap: () {
                              print("Tapped on container GestureDetector");
                              if(_locale?.languageCode == 'en') {
                                _changeLanguage(Language.languageList()[1]);
                              }else{
                                _changeLanguage(Language.languageList()[0]);
                              }
                              print(_locale.languageCode);
                            },
                            child: Container(
                              alignment:  _locale?.languageCode == 'en'?
                              Alignment.centerRight : Alignment.centerLeft ,

                              // color: Colors.red,
                              padding: const EdgeInsets.only(right: 0.0),
                              child: Container(
                                margin: const EdgeInsets.only(top: 18.0),
                                alignment: Alignment.topCenter,
                                decoration: BoxDecoration(
                                  //  color: Colors.white,
                                  border: Border.all(
                                    width: 2,
                                    color: Color.fromRGBO(88, 141, 162, 1),
                                  ),
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(5.0),
                                    bottomLeft: Radius.circular(5.0),
                                    topRight: Radius.circular(5.0),
                                    topLeft: Radius.circular(5.0),
                                  ),
                                ),
                                width: 32,
                                height: 36,
                                child: Text(
                                  getTranslated(context, 'login_lanaguageLabel'),
                                 // 'ع',
                                  // 'Roboto Mono sample',
                                  style: TextStyle(
                                      fontFamily: 'Geeza Pro',
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold, //FF015271
                                      color: Color.fromRGBO(88, 141, 162, 1)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ), //Logo Bar
                    Container(
                      padding: const EdgeInsets.only(left: 0.0, top: 10.0),
                      width: double.infinity,
                      child: Text( getTranslated(context, 'login_welcomeLabel'),
                        //'Welcome back,',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16.0,
                          fontWeight: FontWeight.w300,
                          color: Color.fromRGBO(75, 75, 75, 1),
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ), // Welcome Label
                    Container(
                      padding: const EdgeInsets.only(left: 0.0, top: 1.0),
                      width: double.infinity,
                      child: Text(
                        getTranslated(context, 'login_loginLabel'),
                       // 'Login',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 32.0,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(75, 75, 75, 1),
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ), // Login Label
                    Container(
                      padding: const EdgeInsets.only(left: 5.0, top: 10.0),
                      width: double.infinity,
                      child: Text(
                        getTranslated(context, 'login_usernameLabel'),
                      //  'Username',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(75, 75, 75, 1),
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ), //UserName Label
                    Container(
                      width: double.infinity,
                      // color: Colors.red,
                      padding:
                          const EdgeInsets.only(left: 5.0, right: 0.0, top: 5.0),
                      child: TextFormField(
                        controller: this._userNameController,
                        validator: (value) {
                          if (value.isEmpty ) {
                            return 'Invalid email!';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _authData[ Auth.USERNAME] = value;
                        },
                        decoration: InputDecoration(
                          hintText:  getTranslated(context, 'login_usernameHint'),//'Enter your Username',
                          focusColor: Colors.amber,
                          isDense: true, // Added this
                          contentPadding: EdgeInsets.all(13),


                          // filled: true,
                          //  fillColor: Color(0xFFDBEDFF),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(9.0)),
                            borderSide: BorderSide(color: Colors.grey[400]),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(6.0)),
                            borderSide: BorderSide(color: Colors.amber),
                          ),
                          //   decoration: InputDecoration(labelText: 'Password'),
                          // obscureText: true,
                        ),
                      ),
                    ), //UserName TextField
                    Container(
                      padding: const EdgeInsets.only(left: 5.0, top: 10.0),
                      width: double.infinity,
                      child: Text(getTranslated(context, 'login_passwordLabel'),
                       // 'Password',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.normal),
                        textAlign: TextAlign.start,
                      ),
                    ), //Password Label
                    Container(
                      width: double.infinity,
                      // color: Colors.red,
                      padding:
                          const EdgeInsets.only(left: 5.0, right: 0.0, top: 5.0),
                      child: TextFormField(
                        controller: this._passwordController,
                        validator: (value) {
                          if (value.isEmpty || value.length < 2) {
                            return 'Password is too short!';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _authData[ Auth.PASSWORD] = value;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                                    Icons.visibility,
                              color: Theme.of(context).primaryColorDark,
                            ),
                            onPressed: () {
                            },
                          ),
                          /*icon: const Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: const Icon(Icons.lock)),*/
                          isDense: true, // Added this
                          contentPadding: EdgeInsets.all(13),
                          hintText: getTranslated(context, 'login_passwordHint'),
                          //hintText: 'Enter your password',
                          focusColor: Colors.amber,
                          // filled: true,
                          //  fillColor: Color(0xFFDBEDFF),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(9.0)),
                            borderSide: BorderSide(color: Colors.grey[400]),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(6.0)),
                            borderSide: BorderSide(color: Colors.amber),
                          ),
                          //   decoration: InputDecoration(labelText: 'Password'),
                          // obscureText: true,
                        ),
                      ),
                    ), //Password TextField
                    Container(
                      width: double.infinity,
                      //color: Colors.red,
                      padding:
                          const EdgeInsets.only(left: 0.0, right: 0.0, top: 5.0),
                      // margin: const EdgeInsets.only(left: 00.0, right: 15.0, top: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Checkbox(
                            checkColor: Colors.greenAccent,
                            activeColor: Colors.red,
                            value: _authData[ Auth.IS_REMEMBER_ME] ,
                            onChanged: (bool value) {
                              setState(() {
                                _authData[ Auth.IS_REMEMBER_ME] = value;
                              });
                            },
                          ),
                          //
                          Text(
                            getTranslated(context, 'login_rememberLabel'),
                            style: TextStyle(fontSize: 15.0),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                              getTranslated(context, 'login_forgetPasswordLabel'),
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.amber,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.start),
                        ],
                      ),
                    ), //Remember Me and forget Label
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          print("Tapped on fingerprint ");
                           setState(() {
                             _authData[ Auth.IS_USING_BIOMETRIC]=!_authData[ Auth.IS_USING_BIOMETRIC];
                           });
                        },  child: Container(
                          //height: 30.0,
                          //     alignment: Alignment.center,
                            //  color: Colors.red,
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Image(
                            image:  _authData[ Auth.IS_USING_BIOMETRIC] ? AssetImage('images/fingerprint2.png') :AssetImage('images/fingerprint.png'),
                            fit: BoxFit.fill,
                            width: screenWidth * .19,
                            height: screenHight * 0.12,
                          ),
                        ),
                      ),
                    ), //finger print
                    Center(
                      child: Container(
                        width: double.infinity,
                        //  height: 30.0,
                        padding: const EdgeInsets.only(
                            right: 20.0, left: 20.0, top: 20.0),
                        // color: Colors.green,
                        child:  _isLoading ?
                        CircularProgressIndicator()
                  : RaisedButton(
                          child: Text(getTranslated(context, 'login_submitButtonLabel'),),
                          onPressed: _submit,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 8.0),
                          color: Color.fromRGBO(02, 53, 73, 1),
                          textColor:
                              Theme.of(context).primaryTextTheme.button.color,
                        ),
                      ),
                    ), //Login Button
                    Container(
                      width: double.infinity,
                      //  color: Colors.red,
                      padding: const EdgeInsets.only(
                          left: 0.0, right: 15.0, top: 10.0),
                      // margin: const EdgeInsets.only(left: 00.0, right: 15.0, top: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          //
                          Text(
                            getTranslated(context, 'login_areYouNewLabel'),
                            style: TextStyle(fontSize: 15.0),
                            textAlign: TextAlign.start,
                          ),

                          Text( getTranslated(context, 'login_createAccountLabel'),
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.amber,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.start),
                        ],
                      ),
                    ), //Create Account Label
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: MedicalPolicesBottomNavigationBar(),
        ),
      ),
    );
  }
}
