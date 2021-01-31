import 'package:flutter/widgets.dart';
import 'package:flutter_app/database/user_credentails.dart';
import 'package:flutter_app/database/user_orm.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../soap/model/customer_login_client.dart';
import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  static const USERNAME = 'userName';
  static const PASSWORD = 'password';
  static const IS_USING_BIOMETRIC = 'isUsingBiometric';
  static const IS_REMEMBER_ME = 'isRememberMe';

  static const  SUCCESS_CODE = "0";
  UserORM userORM = new UserORM();
   bool _isAuth = false;

  final  _customerLoginClient  =  CustomerLoginClient();
  CustomerLoginRequest _customerLoginRequest ;
  CustomerLoginResponse _customerLoginResponse;

   bool  get isAuth   {

    /*if(!_isAuth){
      Map<String, dynamic>  map = await getLoginInfoFromPref();
  }*/

    return _isAuth ;
  }

  CustomerLoginResponse get customerLoginResponse {
    return _customerLoginResponse ;
  }

  CustomerLoginRequest get customerLoginRequest {
    return _customerLoginRequest ;
  }



  Future<void> _authenticate( Map<String, dynamic> authData,String langCode,bool isFromLogin) async {
  String username = authData[Auth.USERNAME];
  String password= authData[Auth.PASSWORD];
    try{
      UserCredentials userCredentials = UserCredentials(userName: username,password:password);
    _customerLoginRequest = CustomerLoginRequest(userCredentials:userCredentials, langCode:langCode   );
    _customerLoginResponse =  await  _customerLoginClient.customerLogin(_customerLoginRequest);
    String resultCode = _customerLoginResponse.customer.resultCode;
    if (resultCode.isEmpty ||   resultCode != Auth.SUCCESS_CODE){
      throw HttpException(_customerLoginResponse.customer.resultDescription);
    }else{
      _isAuth = true;
    }
      notifyListeners();
    if(isFromLogin ) {
      setLoginInfoIntoPref(authData);
      userORM.clearUser();
      userORM.insertUser(_customerLoginResponse.customer, userCredentials);
      Customer customr = await userORM.getUser();
      print('customr '+ customr.fullName.toString());
    }

    } catch (error) {
      throw error;
    }
  }

   Future<void> signup(Map<String, dynamic> authData) async {
    return _authenticate(authData, 'E',true);
  }

  Future<void> login( Map<String, dynamic> authData ,{bool isFromLogin=true} ) async {
   final String languageCode='E';
   //setLoginInfoIntoPref(_authData);
   if(!isFromLogin){
     authData = await getLoginInfoFromPref();
   }
    return _authenticate(authData , languageCode,isFromLogin);
  }


  Future<void> setLoginInfoIntoPref(Map<String, dynamic> _authData) async {
    SharedPreferences.getInstance().then((SharedPreferences _prefs){

      _prefs.setString(Auth.USERNAME, _authData[Auth.USERNAME]);
      _prefs.setString(Auth.PASSWORD, _authData[Auth.PASSWORD]);
      _prefs.setBool(Auth.IS_REMEMBER_ME, _authData[Auth.IS_REMEMBER_ME]);
      _prefs.setBool(Auth.IS_USING_BIOMETRIC, _authData[Auth.IS_USING_BIOMETRIC]);

    });
  }


  Future<Map<String, dynamic>> getLoginInfoFromPref() async {

    Map<String, dynamic> authData = {
      Auth.USERNAME: '',
      Auth.PASSWORD: '',
      Auth.IS_USING_BIOMETRIC: false,
      Auth.IS_REMEMBER_ME: false,
    };
    SharedPreferences _prefs = await SharedPreferences.getInstance();



    authData[Auth.IS_REMEMBER_ME]=   _prefs.getBool(Auth.IS_REMEMBER_ME) ?? false;
    authData[Auth.IS_USING_BIOMETRIC]=  _prefs.getBool(Auth.IS_USING_BIOMETRIC) ?? false;
    if(authData[Auth.IS_REMEMBER_ME] || authData[Auth.IS_USING_BIOMETRIC]){

      authData[Auth.USERNAME]=   _prefs.getString(Auth.USERNAME);
      authData[Auth.PASSWORD]=   _prefs.getString(Auth.PASSWORD);

    }

  return authData;

  }
}
