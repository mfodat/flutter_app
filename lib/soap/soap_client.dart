import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:dio/dio.dart';
import 'package:xml/xml.dart';
import '../services/dio_client.dart';
class SoapClient {
  DioClient _dioClient;
  //String baseUrl = "http://192.168.100.39:8080/";
  String baseUrl =  "http://192.168.100.91:8089/";
 // String baseUrl =  "https://tapis.fasah.sa/api/Test";
  SoapClient( ){
  var dio = Dio();
  final String contentType = "text/xml;charset=UTF-8";

  var authorizationHeaderValue = "oauth_consumer_key=mobapitwnpduser;oauth_consumer_secret=mGo6ape155pODUrs9gre;oauth_timestamp=1610117172;oauth_nonce=522263234667L1lV6xn;oauth_version=1.0;";
  final Map<String, dynamic>  headers=
                 {HttpHeaders.contentTypeHeader:contentType  ,
                   HttpHeaders.authorizationHeader:authorizationHeaderValue};
  _dioClient = DioClient(baseUrl, dio ,headers: headers  );

}


  Future<XmlDocument> post(XmlElement xmlRequest) async {


     String  request = _soapEnvelope(xmlRequest).toString();
      final  response = await _dioClient.post('',data:request );
     XmlDocument document = XmlDocument.parse(response);

   // return ApiResult.success(data: document);
     return document;

  }


  String xmlElementToString(XmlElement request){
    return _soapEnvelope(request).toString();
  }

  XmlNode _soapEnvelope(Object body) {
    final uri = "http://schemas.xmlsoap.org/soap/envelope/";
    final xml = XmlBuilder();
    xml.element("Envelope", namespace: uri, nest: () {
      xml.namespace(uri, 'soapenv');
      xml.element("Header", namespace: uri);
      xml.element("Body", namespace: uri, nest: body);
    });
    return xml.buildDocument();
  }
}
