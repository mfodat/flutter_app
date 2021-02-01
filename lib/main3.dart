import 'package:flutter/material.dart';
import 'package:flutter_app/providers/auth.dart';
import 'package:provider/provider.dart';
import './localization/demo_localization.dart';
import './router/custom_router.dart';
import './router/route_constants.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app/page/about.dart';
import 'app/page/login.dart';
import 'localization/language_constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;
  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (this._locale == null) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[800])),
        ),
      );
    } else {
      // new MaterialApp(lo);
      var fontSize = TextStyle(fontSize: 4.0);
      return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Auth(),
          ),
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Flutter Localization Demo",
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            locale: _locale,
            supportedLocales: [
              Locale("en", "US"),
              Locale("ar", "SA"),
              Locale("fa", "IR"),
              Locale("hi", "IN")
            ],
            localizationsDelegates: [
              DemoLocalization.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            localeResolutionCallback: (locale, supportedLocales) {
              for (var supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale.languageCode &&
                    supportedLocale.countryCode == locale.countryCode) {
                  return supportedLocale;
                }
              }
              return supportedLocales.first;
            },
            onGenerateRoute: CustomRouter.generatedRoute,
            home:  Login(),
           // home: auth.isAuth ?,
          ),
        ),
      );
    }
  }
}
