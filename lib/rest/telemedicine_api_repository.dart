import 'dart:io';

import 'package:dio/dio.dart';
import '../models/telemedicine_request.dart';
import '../models/member_history_response.dart';
import '../models/movie_response.dart';

import '../services/api_result.dart';
import '../services/dio_client.dart';
import '../services/network_exceptions.dart';
import '../services/dio_client.dart';

class TelephoneMedicineAPIRepository {
  DioClient _dioClient;
  final String _apiKey = "22190e43-14cf-4b4c-90f2-ec18d2e1ad63";
  //final String _baseUrl = "https://webapis.tawuniya.com.sa:5556/gateway/telemedicine/V1.0/TawnTeleMedicine/restful";
 // "final String _baseUrl = 'http://192.168.100.39:8089/gateway/telemedicine/V1.0/TawnTeleMedicine/restful';
  final String _baseUrl = 'https://tapis.fasah.sa/api/resrt';
  final String contentType ='application/json; charset=UTF-8';
  TelephoneMedicineAPIRepository() {
    var dio = Dio();


    final Map<String, dynamic>  headers= {HttpHeaders.contentTypeHeader:contentType
                                            ,  'twanapikey':_apiKey};
    _dioClient = DioClient(_baseUrl, dio ,headers: headers  );


  }

  Future<MemberHistoryResponse> fetchMemberHistory(MemberHistoryRequest request) async {

      Map<String, dynamic> requestMap = request.toJson();
      final response = await _dioClient
          .post("/memberHistory", data:requestMap);
      MemberHistoryResponse memberHistoryResponse = MemberHistoryResponse.fromJson(response);
      return  memberHistoryResponse ;

  }

  Future<TelemedicineResponse> createMemberConsultation(TelemedicineRequest request) async {

    Map<String, dynamic> requestMap = request.toJson();
    final response = await _dioClient
        .post("/memberConsultation", data:requestMap);
    TelemedicineResponse telemedicineResponse = TelemedicineResponse.fromJson(response);
    return  telemedicineResponse ;

  }
}
