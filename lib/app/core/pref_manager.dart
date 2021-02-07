
import 'package:flutter_app/app/dto/pref_dto.dart';
import 'package:flutter_app/database/user_credentails.dart';
import 'package:shared_preferences/shared_preferences.dart';



class PrefManager{

  Future<void> store(PrefDto prefDto)   async {
    Map<String, String> authData =prefDto.toMap();
    SharedPreferences.getInstance().then((SharedPreferences _prefs)  {
      authData.forEach((key, value) {
        _prefs.setString(key, value);
      });
    });
  }

  Future<PrefDto> load() async {

    PrefDto prefDto = PrefDto(credential: Credential() );
    Map<String, String> authData = prefDto.toMap();
    SharedPreferences _prefs = await SharedPreferences.getInstance();

   for(String key in    authData.keys ) {
     authData[key]=   _prefs.getString(key) ?? '';
   }

    return PrefDto.toPrefDto(authData);

  }
  Future<void> clear() async {
    SharedPreferences.getInstance().then((SharedPreferences _prefs)  {
      _prefs.clear();
    });
  }

}