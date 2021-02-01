import 'package:flutter/material.dart';
import 'package:flutter_app/classes/language.dart';
import 'package:flutter_app/providers/auth.dart';
import 'package:flutter_app/util/exception_handler.dart';
import 'package:flutter_app/widgets/bottom_navigation_bar.dart';
import 'package:provider/provider.dart';
import '../../localization/language_constants.dart';
import '../../main3.dart';
import '../../router/route_constants.dart';
import 'login.dart';

abstract class LoginBase extends State<Login> {

  bool prefRead = false;

  void changeLanguage(Language language) async {
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
          authData = authData;
          userNameController.text = authData[Auth.USERNAME];
          passwordController.text = authData[Auth.PASSWORD];
          prefRead = true;
        });
        if(authData[Auth.IS_REMEMBER_ME] ){
          submit();
        }else  if(authData[Auth.IS_FINGER_BIOMETRIC_SUPPORTED ] && authData[Auth.IS_USING_BIOMETRIC ] ){
          Provider.of<Auth>(context, listen: false).isFingerAuth().then((value) {
            if(value) { submit(); }
          });
        }
      });
    }
    getLocale().then((locale) {
      setState(() {
        this.locale = locale;
      });
    });
    super.didChangeDependencies();

  }
  Map<String, dynamic> authData = {
    Auth.USERNAME: '',
    Auth.PASSWORD: '',
    Auth.IS_USING_BIOMETRIC: false,
    Auth.IS_REMEMBER_ME: false,
    Auth.IS_FINGER_BIOMETRIC_SUPPORTED: false,

  };
  var isLoading = false;
  Future<void> submit() async {
    if (!formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    formKey.currentState.save();
    setState(() {
      isLoading = true;
    });
    try {

      // Log user in
      await Provider.of<Auth>(context, listen: false).login( authData);
      Navigator.pushNamed(context,  aboutRoute);

    } catch (error) {
      var errorMessage = ExceptionHandler.handelException(error);
      showErrorDialog(errorMessage);
    }


    setState(() {
      isLoading = false;
    });
  }
  void showErrorDialog(String message) {
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
  Locale locale ;

  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();
}