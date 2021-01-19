import 'package:flutter/material.dart';
import '../soap/model/medical_policy_details_client.dart';
import '../soap/model/policy_information_client.dart';
import '../models/http_exception.dart';
import 'auth.dart';

class Policies with ChangeNotifier {


  final Auth auth;

  Policies(this.auth);



  static const  SUCCESS_CODE = "0";
final _policyInformation = PolicyInformation();
final _medicalPolicyDetailsClient = MedicalPolicyDetailsClient();
  MedicalPolicyDetailsRequest _medicalPolicyDetailsRequest;
  PolicyInformationResponse _policyInformationResponse;
  MedicalPolicyDetailsResponse _medicalPolicyDetailsResponse;

  MedicalPolicyDetailsResponse get medicalPolicyDetailsResponse {
    return _medicalPolicyDetailsResponse ;
  }
  MedicalPolicyDetailsRequest get medicalPolicyDetailsRequest {
    return _medicalPolicyDetailsRequest ;
  }


  Future<void> fetchAndSetMedicalPolicyDetails(String policyNumber) async {
    if(_medicalPolicyDetailsResponse != null  ){
      String resultCode = _medicalPolicyDetailsResponse.resultCode;
      if (resultCode.isEmpty ||   resultCode != Policies.SUCCESS_CODE){
            print('call api');
      }else{
        print('do not call api');
        return;
      }
    }

    String username = this.auth.customerLoginRequest.username;
    String password = this.auth.customerLoginRequest.password;
    String langCode = this.auth.customerLoginRequest.langCode;
    String  medicalCustomerId=this.auth.customerLoginResponse.customer.medCustomerID;
    String idNumber = this.auth.customerLoginResponse.customer.iqamahID;
    String  customerId = this.auth.customerLoginResponse.customer.customerID;


    try{
         _medicalPolicyDetailsRequest = MedicalPolicyDetailsRequest(
         username: username,
         policyNumber: policyNumber,
         medicalCustomerId: medicalCustomerId,
         idNumber: idNumber,
         customerId: customerId,
         password: password,
         langCode: langCode,
       );
       _medicalPolicyDetailsResponse = await _medicalPolicyDetailsClient.getMedicalPolicyDetails(_medicalPolicyDetailsRequest);

      String resultCode = _medicalPolicyDetailsResponse.resultCode;
      if (resultCode.isEmpty ||   resultCode != Policies.SUCCESS_CODE){
        throw HttpException(_medicalPolicyDetailsResponse.resultDescription);
      }else{

      }
      notifyListeners();
    } catch (error) {
      throw error;
    }

  }


  Future<void> fetchAndSetPolicies() async {
   String username = this.auth.customerLoginRequest.username;
   String password = this.auth.customerLoginRequest.password;
   String langCode = this.auth.customerLoginRequest.langCode;
    try{
    PolicyInformationRequest policyInformationReq = PolicyInformationRequest(
                  username: username,password:password,langCode:langCode  ) ;
   _policyInformationResponse = await _policyInformation.getPolicyInformation(policyInformationReq);

    String resultCode = _policyInformationResponse.resultCode;
   if (resultCode.isEmpty ||   resultCode != Policies.SUCCESS_CODE){
     throw HttpException(_policyInformationResponse.resultDescription);
   }else{

   }
   notifyListeners();
  } catch (error) {
  throw error;
  }

  }

  PolicyInformationResponse get policyInformationResponse {
    return _policyInformationResponse ;
  }




}
