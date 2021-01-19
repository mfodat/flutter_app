import 'package:flutter/foundation.dart';
import 'package:xml/xml.dart';
import '../soap_client.dart';

class PolicyInformation  extends SoapClient{

  Future<PolicyInformationResponse> getPolicyInformation(
      PolicyInformationRequest policyInformationReq) async {
       XmlElement xmlElementReq =  policyInformationReq.toXml();
       XmlDocument  result = await post(xmlElementReq);
       return PolicyInformationResponse  .fromXml(result);
  }
}

@immutable
class PolicyInformationResponse {
  final List<Policy> policies;
  final String resultCode;
  final String resultDescription;

  PolicyInformationResponse(this.policies,this.resultCode,this.resultDescription);

  factory PolicyInformationResponse.fromXml(XmlDocument document) {
    final policy = List<Policy>();
    final customerNode = document.findAllElements('data').first;
    String resultCode = customerNode.findElements('resultCode').first.text;
   String resultDescription = customerNode.findElements('resultDescription').first.text;
    for (final policyNode in document.findAllElements('policyList')) {
      policy.add(Policy.fromXml(policyNode));
    }
    return PolicyInformationResponse(policy,resultCode,resultDescription);
  }
}

@immutable
class Policy {
 String expireDate;
 String description;
 String glob;
 String lob;
 String policyNo;
 String premium;
 String product;
 String status;



  Policy({this.description,this.expireDate,this.glob,this.lob,this.policyNo
 ,this.premium,this.product,this.status,
  });

  factory Policy.fromXml(XmlElement PolicyNode) {
    final uri = '';
    return Policy(
      description: PolicyNode.findElements('s_Description').first.text,
      premium: PolicyNode.findElements('s_Premium').first.text,
      expireDate: PolicyNode.findElements('d_ExpireDate').first.text,
      glob: PolicyNode.findElements('s_Glob').first.text,
      lob: PolicyNode.findElements('s_Lob').first.text,
      policyNo: PolicyNode.findElements('s_PolicyNo').first.text,
      product: PolicyNode.findElements('s_Product').first.text,
      status: PolicyNode.findElements('s_Status').first.text,


    );
  }
}

@immutable
class PolicyInformationRequest {
  final String langCode;
  final String password;
  final String username;

  PolicyInformationRequest({this.username, this.password, this.langCode});
  String xmlToString(){
    var request = toXml();
     String s = SoapClient().xmlElementToString(request);

     return s;
  }
  XmlElement toXml() {
    final uri = 'http://ws.mobileservice.tawuniya.com/';
    final xml = XmlBuilder();
    xml.element('getPolicyInformation', namespace: uri, nest: () {
      xml.namespace(uri, 'ws');
    //  arg0
      xml.element('arg0', nest: ()
      {
        xml.element('langCode', nest: langCode);
        xml.element('password', nest: password);
        xml.element('username', nest: username);
      });

    });
    return (xml.buildDocument()).rootElement;
  }
}
