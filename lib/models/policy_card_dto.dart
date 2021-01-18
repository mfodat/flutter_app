import '../soap/model/medical_policy_details_client.dart';

import '../widgets/policy_card.dart';

import '../soap/model/policy_information_client.dart';

class PolicyCardDTO {

  static TravelDestination convert(Policy policy) {
    String assetName = 'assets/images/SANAD.png';
    if (policy.lob == 'MD')
      assetName = 'assets/images/MD.jpg';
    return TravelDestination(assetName: assetName,
        assetPackage: '',
        city: policy.policyNo,
        description: policy.expireDate,
        location: policy.glob + '_' + policy.lob,
        title: policy.product,
        type: CardDemoType.tappable);
  }



  static TravelDestination convertMedicalPolicy(MedicalPolicy medicalPolicy) {

   /* String  premium;
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
    String  inceptionDate;*/


     final String assetName = 'assets/images/MD.jpg';
    return TravelDestination(assetName: assetName,
        assetPackage: '',
        city: medicalPolicy.sponsorID,
        description: medicalPolicy.memberCode,
        location: medicalPolicy.relation + '_' + medicalPolicy.gender,
        title: medicalPolicy.memberName ,
        type: CardDemoType.tappable);
  }
}
//images/places/india_thanjavur_market.png