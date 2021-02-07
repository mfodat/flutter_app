import 'package:flutter_app/app/dto/pref_dto.dart';
import 'package:flutter_app/database/user_credentails.dart';

import 'bioManager.dart';

import 'autoLoginType.dart';
import 'pref_manager.dart';

class AppSession{
  AppSession._privateConstructor();
  static final AppSession _instance = AppSession._privateConstructor();
  static AppSession get instance => _instance;
  bool  prefRead = false;
    String _languageCode='E';
  bool _isLogin = false;
  Credential _credential = Credential();
  AutoLoginType _autoLoginType  = AutoLoginType.none;
  BioManager _bioManager = BioManager();
  PrefManager _prefManager = PrefManager();


  String get languageCode=>_languageCode;
  set languageCode (String languageCode)=>this._languageCode=languageCode;

  bool get isLogin=>_isLogin;
  set isLogin (bool login)=>this._isLogin=login;


  Credential get credential=>_credential;
   set credential(Credential credential)=>   _credential = credential;


  AutoLoginType get autoLoginType=>_autoLoginType;
  set autoLoginType(AutoLoginType autoLoginType)=>   _autoLoginType = autoLoginType;

  //BioManager get bioManager=>_bioManager;
  // PrefManager get prefManager=>_prefManager;

  Future<void> store( )   async {
    PrefDto prefDto = PrefDto(credential: _credential,autoLoginType: _autoLoginType);
    _prefManager.store(prefDto);
  }

  Future<PrefDto> getpref( )   async {
   // PrefDto prefDto = PrefDto(credential: _credential,autoLoginType: _autoLoginType);
    PrefDto prefDto ;
    if(! prefRead )
      prefDto = await _prefManager.load();
    if( prefDto != null)
      prefRead = true;
   return prefDto;
  }

  Future<bool> getRemmberMe( )   async {

    if(! prefRead && ! _isLogin) {
      PrefDto prefDto = await _prefManager.load();
      _credential = prefDto.credential;
      _autoLoginType =prefDto.autoLoginType;
    }
    return  _autoLoginType == AutoLoginType.rememberMe;
  }
}

