import 'package:flutter/foundation.dart';
import '../../services/network_exceptions.dart';
import '../../services/api_result.dart';
import 'package:xml/xml.dart';
import '../soap_client.dart';

class MedicalPolicyDetailsClient  extends SoapClient{


  Future<MedicalPolicyDetailsResponse> getMedicalPolicyDetails(
      MedicalPolicyDetailsRequest medicalPolicyDetailsRequest) async {


       XmlElement xmlElementReq =  medicalPolicyDetailsRequest.toXml();
       XmlDocument  result = await post(xmlElementReq);

         MedicalPolicyDetailsResponse medicalPolicyDetailsResponse = MedicalPolicyDetailsResponse
             .fromXml(result);

  return medicalPolicyDetailsResponse;
  }

}

@immutable
class MedicalPolicyDetailsResponse {
  final List<MedicalPolicy> medicalPolicyList;
  final String resultCode;
  final String resultDescription;

  MedicalPolicyDetailsResponse(this.medicalPolicyList,this.resultCode,this.resultDescription);

  factory MedicalPolicyDetailsResponse.fromXml(XmlDocument document) {
    final MedicalPolicys = List<MedicalPolicy>();
    final customerNode = document.findAllElements('data').first;
    String resultCode = customerNode.findElements('resultCode').first.text;
   String resultDescription = customerNode.findElements('resultDescription').first.text;
    for (final policyNode in document.findAllElements('medicalMemberList')) {
      MedicalPolicys.add(MedicalPolicy.fromXml(policyNode));
    }
    return MedicalPolicyDetailsResponse(MedicalPolicys,resultCode,resultDescription);
  }
}

@immutable
class MedicalPolicy {

  String  premium;
  String  cchIStatus;
  String  classNo;
  String empId;
  String endtNo;
  String  gender;
  String  memberCode;
  String  memberName;
  String  relation;
  String  riskNo;
  String  sponsorID;
  String  type;
  String  dob;
  String  inceptionDate;


  MedicalPolicy({this.premium,this.cchIStatus,this.classNo,this.dob
  ,this.empId,this.endtNo,this.gender,this.inceptionDate,this.memberCode,this.memberName
  ,this.relation,this.riskNo,this.sponsorID,this.type});

  factory MedicalPolicy.fromXml(XmlElement xmlElement) {
    final uri = '';
    return MedicalPolicy(
      cchIStatus:  xmlElement.findElements('s_CCHIStatus').first.text,
      classNo: xmlElement.findElements('s_ClassNo').first.text,
     premium: xmlElement.findElements('d_Premium').first.text,
     dob: xmlElement.findElements('t_DOB').first.text,
      empId:  xmlElement.findElements('s_EmpId').first.text,
     endtNo:  xmlElement.findElements('s_EndtNo').first.text,
     gender: xmlElement.findElements('s_Gender').first.text,
      inceptionDate: xmlElement.findElements('t_InceptionDate').first.text,
      memberCode: xmlElement.findElements('s_MemberCode').first.text,
      memberName:xmlElement.findElements('s_MemberName').first.text ,
      relation: xmlElement.findElements('s_Relation').first.text,
      riskNo: xmlElement.findElements('s_RiskNo').first.text,
      sponsorID: xmlElement.findElements('s_SponsorID').first.text,
      type: xmlElement.findElements('s_Type').first.text,



    );
  }
}

@immutable
class MedicalPolicyDetailsRequest {
  String  customerId;
  String  idNumber;
  String  langCode;
  String  medicalCustomerId;
  String  password;
  String  policyNumber;
  String  username;

  MedicalPolicyDetailsRequest({this.username, this.password, this.langCode
  , this.customerId, this.idNumber, this.medicalCustomerId, this.policyNumber});
  String xmlToString(){
    var request = toXml();
     String s = SoapClient().xmlElementToString(request);

     return s;
  }
  XmlElement toXml() {
    final uri = 'http://ws.mobileservice.tawuniya.com/';
    final xml = XmlBuilder();
    xml.element('getMedicalPolicyDetails', namespace: uri, nest: () {
      xml.namespace(uri, 'ws');
    //  arg0
      xml.element('arg0', nest: ()
      {
        xml.element('customerId', nest: customerId);
        xml.element('idNumber', nest: idNumber);
        xml.element('langCode', nest: langCode);
        xml.element('medicalCustomerId', nest: medicalCustomerId);
        xml.element('password', nest: password);
        xml.element('policyNumber', nest: policyNumber);
        xml.element('username', nest: username);

      });

    });
    return (xml.buildDocument()).rootElement;
  }
}
