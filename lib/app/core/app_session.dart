import 'bioManager.dart';
import 'credential.dart';
import 'autoLoginType.dart';

class AppSession{
  AppSession._privateConstructor();
  static final AppSession _instance = AppSession._privateConstructor();
  static AppSession get instance => _instance;

  bool _isLogin = false;
  bool get isLogin=>_isLogin;
  set isLogin (bool login)=>this._isLogin=login;

  Credential _credential = Credential();
  Credential get credential=>_credential;
   set credential(Credential credential)=>   _credential = credential;

  AutoLoginType _autoLoginType  ;
  AutoLoginType get autoLoginType=>_autoLoginType;
  set autoLoginType(AutoLoginType credential)=>   _autoLoginType = autoLoginType;

BioManager bioManager;
}

