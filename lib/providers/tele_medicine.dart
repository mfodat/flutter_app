import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../models/member_history_response.dart';
import '../models/telemedicine_request.dart';
import '../rest/telemedicine_api_repository.dart';
import '../soap/model/customer_login_client.dart';

import '../models/http_exception.dart';

class TeleMedicine with ChangeNotifier {
  static const  SUCCESS_CODE = "S";
  final String policyNumber;
  final String memberCode;
  final String langId;
  final String phone;

  TeleMedicine({this.langId,this.memberCode,this.policyNumber,this.phone});

  List<MemberHistory>  _memberHistoryList ;

  List<MemberHistory>  get memberHistoryList {
    return _memberHistoryList ;
  }

  MemberHistoryResponse _memberHistoryResponse;

  TelephoneMedicineAPIRepository _teleApi = TelephoneMedicineAPIRepository();

  Future<void> fetchHistory() async {
    MemberHistoryRequest request = new MemberHistoryRequest(
        memberCode:memberCode,
      policyNumber: policyNumber,
      langId: langId
    );
    try{
      _memberHistoryResponse = await _teleApi.fetchMemberHistory(request);

      String resultCode = _memberHistoryResponse.statusCode;
      if (resultCode.isEmpty ||   resultCode != TeleMedicine.SUCCESS_CODE){
        throw HttpException(_memberHistoryResponse.statusDescription);
      }else{//S
          _memberHistoryList = _memberHistoryResponse.memberHistoryList;
      }
      notifyListeners();
    } catch (error) {
      throw error;
    }

  }

  Future<void> createTeleMedicine( Map<String, String> medicineData) async {
    try{
      TelemedicineRequest telemedicineRequest = TelemedicineRequest(
        langId: langId,
        policyNumber: this.policyNumber,
        memberCode: medicineData['memberCode'],
        question: medicineData['question'],
        memberName: medicineData['memberName'],
        lastName: medicineData['lastName'],
        memberGender: medicineData['memberGender'],
        phone: phone ,
      );
      TelemedicineResponse  telemedicineResponse = await  _teleApi.createMemberConsultation(telemedicineRequest);
      String resultCode = telemedicineResponse.statusCode;
      if (resultCode.isEmpty ||   resultCode != TeleMedicine.SUCCESS_CODE){
        throw HttpException(telemedicineResponse.statusDescription);
      }else{//S

      }
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }


}