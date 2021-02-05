import 'bioManager.dart';
import 'credential.dart';
import 'autoLoginType.dart';
import 'pref_manager.dart';

class AppSession{
  AppSession._privateConstructor();
  static final AppSession _instance = AppSession._privateConstructor();
  static AppSession get instance => _instance;

  bool _isLogin = false;
  Credential _credential = Credential();
  AutoLoginType _autoLoginType  ;
  BioManager _bioManager = BioManager();
  PrefManager _prefManager = PrefManager();

  bool get isLogin=>_isLogin;
  set isLogin (bool login)=>this._isLogin=login;


  Credential get credential=>_credential;
   set credential(Credential credential)=>   _credential = credential;


  AutoLoginType get autoLoginType=>_autoLoginType;
  set autoLoginType(AutoLoginType credential)=>   _autoLoginType = autoLoginType;

  //BioManager get bioManager=>_bioManager;
  // PrefManager get prefManager=>_prefManager;


}

