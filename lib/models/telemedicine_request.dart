
class TelemedicineResponse{
  String statusCode;
  String statusDescription;
  String referenceNumber;
  TelemedicineResponse.telemedicineResponse({this.statusCode, this.statusDescription,  this.referenceNumber});
  TelemedicineResponse.fromJson(Map<String, dynamic> json) {
    var consultationResponse = json['consultationResponse'];
    var status = consultationResponse['status'];
    statusCode = status['statusCode'];
    statusDescription = status['statusDescription'];
      referenceNumber = consultationResponse['referenceNumber'];
    }
}

class TelemedicineRequest{
  final String langId;
  final String question;
  final String phone;
  final String memberName;
  final String lastName;
  final String memberCode;
  final  String policyNumber;
  final String memberGender;


  TelemedicineRequest({this.policyNumber,this.memberCode,this.langId
  ,this.memberName,this.question,this.phone,this.lastName,this.memberGender});
  Map<String, dynamic> toJson() {


    final Map<String, dynamic>  jsonObject = new  Map<String, dynamic> ();
    final Map<String, dynamic>  jsonObject2 = new  Map<String, dynamic> ();
    final Map<String, dynamic>  jsonObject3 = new  Map<String, dynamic> ();

    jsonObject2["langId"] ="E";
    jsonObject2["question"] = question;
    jsonObject2["channel"] = "PORTAL";
    jsonObject2["status"] = "O";

    jsonObject3["phone"] = phone;
    jsonObject3["firstName"] =  memberName;
    jsonObject3["lastName"] =  lastName;
    jsonObject3["gender"] = memberGender;
    jsonObject3["memberCode"] =  memberCode;
    jsonObject3["policyNumber"] =  policyNumber;
    jsonObject2["memberInfo"] = jsonObject3;
    jsonObject["consultationRequest"] =jsonObject2;
    return jsonObject;
  }
}
