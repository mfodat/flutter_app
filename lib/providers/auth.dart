import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../services/api_result.dart';
import '../soap/model/customer_login_client.dart';

import '../models/http_exception.dart';

class Auth with ChangeNotifier {

  static const  SUCCESS_CODE = "0";
  String _token;
  DateTime _expiryDate;
  String _userId;
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

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
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
