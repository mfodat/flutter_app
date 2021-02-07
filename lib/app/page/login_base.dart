import 'package:flutter/material.dart';
import 'package:flutter_app/app/core/app_session.dart';
import 'package:flutter_app/app/core/autoLoginType.dart';
import 'package:flutter_app/classes/language.dart';
import 'package:flutter_app/database/user_credentails.dart';
import 'package:flutter_app/providers/auth.dart';
import 'package:flutter_app/util/exception_handler.dart';
import 'package:flutter_app/widgets/bottom_navigation_bar.dart';
import 'package:provider/provider.dart';
import '../../localization/language_constants.dart';
import '../../main3.dart';
import '../../router/route_constants.dart';
import 'login.dart';

abstract class LoginBase extends State<Login> {



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
        AppSession.instance.getRemmberMe().then((rememberMe  ) {
       // if (!mounted) return;
        if(rememberMe ){
          submit(isFromLogin: false);
        }
      });

    getLocale().then((locale) {
      setState(() {
        this.locale = locale;
      });
    });
    super.didChangeDependencies();

  }
 /* Map<String, dynamic> authData = {
    Auth.USERNAME: '',
    Auth.PASSWORD: '',
    Auth.IS_USING_BIOMETRIC: false,
    Auth.IS_REMEMBER_ME: false,
    Auth.IS_FINGER_BIOMETRIC_SUPPORTED: false,

  };*/
  String userName ='';
  String password ='';
  bool rememberMe = false;
  var isLoading = false;
  Future<void> submit( {bool isFromLogin=true}) async {
    if(isFromLogin) {
      if (!formKey.currentState.validate()) {
        // Invalid!
        return;
      }
      formKey.currentState.save();
      AppSession.instance.credential = Credential(userName: userName,password:password );
      AppSession.instance.autoLoginType = rememberMe ? AutoLoginType.rememberMe:AutoLoginType.none;
      AppSession.instance.isLogin = false;
      AppSession.instance.prefRead = false;
    }
    setState(() {
      isLoading = true;
    });
    try {
      // Log user in
      await Provider.of<Auth>(context, listen: false).login2(isFromLogin: isFromLogin);
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