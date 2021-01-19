import 'package:flutter/widgets.dart';
import '../soap/model/customer_login_client.dart';
import '../models/http_exception.dart';

class Auth with ChangeNotifier {

  static const  SUCCESS_CODE = "0";

   bool _isAuth = false;

  final  _customerLoginClient  =  CustomerLoginClient();
  CustomerLoginRequest _customerLoginRequest ;
  CustomerLoginResponse _customerLoginResponse;

  bool get isAuth {
    return _isAuth ;
  }

  CustomerLoginResponse get customerLoginResponse {
    return _customerLoginResponse ;
  }

  CustomerLoginRequest get customerLoginRequest {
    return _customerLoginRequest ;
  }



  Future<void> _authenticate(
      String email, String password, String langCode) async {
    try{
    _customerLoginRequest = CustomerLoginRequest(username:email,password:password,langCode:langCode   );
    _customerLoginResponse =  await  _customerLoginClient.customerLogin(_customerLoginRequest);
    String resultCode = _customerLoginResponse.customer.resultCode;
    if (resultCode.isEmpty ||   resultCode != Auth.SUCCESS_CODE){
      throw HttpException(_customerLoginResponse.customer.resultDescription);
    }else{
      _isAuth = true;
    }
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'E');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'E');
  }
}
