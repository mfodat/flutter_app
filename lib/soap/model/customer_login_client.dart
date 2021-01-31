import 'package:flutter/foundation.dart';
import 'package:flutter_app/database/user_credentails.dart';
import 'package:xml/xml.dart';
import '../soap_client.dart';

class CustomerLoginClient  extends SoapClient{


  Future<CustomerLoginResponse> customerLogin(
      CustomerLoginRequest customerLoginReq) async {
       XmlElement xmlElementReq =  customerLoginReq.toXml();
       XmlDocument  result = await post(xmlElementReq);
         CustomerLoginResponse customerLoginResponse = CustomerLoginResponse
             .fromXml(result);
       return customerLoginResponse;
 }

}

@immutable
class CustomerLoginResponse {
  final Customer  customer;

  CustomerLoginResponse(this.customer);

  factory CustomerLoginResponse.fromXml(XmlDocument document) {
    final people = List<Customer>();

    Customer customer =  Customer.fromXml(document.findAllElements('data').first);

    return CustomerLoginResponse(customer);
  }
}

@immutable
class Customer {
  final String fullName;
  final String birthYear;
  final String eMail;
  final String nationality;
  final String address;
  final String birthDate;
  final String zipCode;
  final String customerID;
  final String resultDescription;
  final String resultCode;
  final String preferredLanguage;
  final String passChange;
  final String preferredContact;
  final String mobile;
  final String medCustomerID;
  final String iqamahID;
 // final String EMail;
  final String phone;
  final String telNumber1;




  Customer({this.fullName, this.birthYear , this.eMail, this.nationality,
  this.address,this.birthDate,this.customerID,this.iqamahID,
  this.medCustomerID,this.mobile,this.passChange,this.preferredContact,
  this.preferredLanguage,this.resultCode,this.resultDescription,this.zipCode,this.phone,this.telNumber1
  });

  factory Customer.fromXml(XmlElement CustomerNode) {
    final uri = '';
    return Customer(
      fullName: CustomerNode.findElements('fullName').first.text,
      birthYear:   CustomerNode.findElements('birthYear').first.text,
      eMail:  CustomerNode.findElements('EMail').first.text,
      nationality: CustomerNode.findElements('nationality').first.text,
      zipCode:CustomerNode.findElements('zipcode').first.text,
      address: CustomerNode.findElements('address').first.text,
      birthDate: CustomerNode.findElements('birthDate').first.text,
      customerID: CustomerNode.findElements('customerID').first.text,

      iqamahID: CustomerNode.findElements('iqamahID').first.text,
      medCustomerID: CustomerNode.findElements('medCustomerID').first.text,
      mobile: CustomerNode.findElements('mobile').first.text,
      passChange: CustomerNode.findElements('passChange').first.text,
      preferredContact: CustomerNode.findElements('preferredContact').first.text,
      preferredLanguage: CustomerNode.findElements('preferredLanguage').first.text,
      resultCode: CustomerNode.findElements('resultCode').first.text,
      resultDescription: CustomerNode.findElements('resultDescription').first.text,
      phone: CustomerNode.findElements('phone').first.text,
      telNumber1: CustomerNode.findElements('telNumber1').first.text,
    );
  }
}

@immutable
class CustomerLoginRequest {
  final  String langCode;
  final UserCredentials userCredentials;

  CustomerLoginRequest({this.userCredentials, this.langCode});
  String xmlToString(){
    var request = toXml();
     String s = SoapClient().xmlElementToString(request);

     return s;
  }
  XmlElement toXml() {
    final uri = 'http://ws.mobileservice.tawuniya.com/';
    final xml = XmlBuilder();
    xml.element('customerLogin', namespace: uri, nest: () {
      xml.namespace(uri, 'ws');
    //  arg0
      xml.element('arg0', nest: ()
      {
        xml.element('langCode', nest: langCode);
        xml.element('password', nest: userCredentials.password);
        xml.element('username', nest: userCredentials.userName);
      });

    });
    return (xml.buildDocument()).rootElement;
  }
}
