import 'package:flutter_app/app/core/autoLoginType.dart';
import 'package:flutter_app/database/user_credentails.dart';

class PrefDto{
  final Credential credential;
  final AutoLoginType autoLoginType;
  PrefDto({this.credential ,this.autoLoginType = AutoLoginType.none});


  Map<String, String> toMap(){
    Map<String, String> PrefData = {
      'userName': this.credential.userName,
      'password': this.credential.password,
     'autoLoginType': this.autoLoginType.index.toString(),
    };
    return PrefData;
  }

  static PrefDto toPrefDto(Map<String, String>  PrefData){
    final Credential credential = Credential(password: PrefData['password'],
                                             userName: PrefData['userName']);
    final AutoLoginType autoLoginType = _getAutoLoginType(PrefData['autoLoginType']);

    return PrefDto(autoLoginType:autoLoginType,credential: credential );
  }
  static AutoLoginType _getAutoLoginType(String autoLoginTypeStr) {
     if(autoLoginTypeStr == '')
       return AutoLoginType.none;
    for (AutoLoginType autoLoginType in AutoLoginType.values) {
       if(autoLoginType.index.toString() == autoLoginTypeStr){
          return autoLoginType;
       }
    }

  }
}