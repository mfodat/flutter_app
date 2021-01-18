class MemberHistoryResponse {
  String statusCode;
  String statusDescription;

  List<MemberHistory> memberHistoryList;

  MemberHistoryResponse({this.statusCode, this.statusDescription,  this.memberHistoryList});

  MemberHistoryResponse.fromJson(Map<String, dynamic> json) {
    var memberHistoryResponse = json['memberHistoryResponse'];

    var status = memberHistoryResponse['status'];

      statusCode = status['statusCode'];
    statusDescription = status['statusDescription'];
    var memberHistory = memberHistoryResponse['memberHistory'];
    if (memberHistory != null) {
      memberHistoryList = new List<MemberHistory>();
      memberHistory.forEach((v) {
        memberHistoryList.add(new MemberHistory.fromJson(v));
      });
    }
  }

  /*Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['total_results'] = this.totalResults;
    data['total_pages'] = this.totalPages;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }*/
}
class MemberHistoryRequest{
  String policyNumber;
  String memberCode;
  String langId;
  MemberHistoryRequest({this.policyNumber,this.memberCode,this.langId});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> request = new Map<String, dynamic>();
    final Map<String, dynamic> memberHistoryRequest = new Map<String, dynamic>();
    memberHistoryRequest['policyNumber'] = this.policyNumber;
    memberHistoryRequest['memberCode'] = this.memberCode;
    memberHistoryRequest['langId'] = this.langId;
    request["memberHistoryRequest"]= memberHistoryRequest;
    return request;
  }
}
class MemberHistory {

  String referenceNumber;
  String memberName;
  String status;

  String submissionDate;
  String question;
  String recommendation;
  MemberHistory(
      {this.memberName,this.status,this.question,
        this.recommendation,this.referenceNumber,this.submissionDate});

  MemberHistory.fromJson(Map<String, dynamic> json) {
    referenceNumber = json['referenceNumber'];
    memberName = json['memberName'];
    status = json['status'];
    question = json['question'];
    recommendation = json['recommendation'];
    submissionDate = json['submissionDate'];
  }


}