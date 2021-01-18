import 'package:flutter/material.dart';
import '../models/policy_card_dto.dart';
import '../widgets/policy_card.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';


class MedicalPolicyDetailsCards extends StatefulWidget {
  //final bool showFavs;

  //PoliciesCards();

  @override
  _MedicalPolicyDetailsCardsState createState() => _MedicalPolicyDetailsCardsState();
}

class _MedicalPolicyDetailsCardsState extends State<MedicalPolicyDetailsCards> {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final medicalPolicyList =  productsData.medicalPolicyDetailsResponse.medicalPolicyList;
   return  Scrollbar(
      child: ListView(
        padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
        children: [
          for (final medicalPolicy in medicalPolicyList   )
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: TappableTravelDestinationItem(
              destination: PolicyCardDTO.convertMedicalPolicy(medicalPolicy) ),
            ) ,
        ],
      ),
    );
  }
}
