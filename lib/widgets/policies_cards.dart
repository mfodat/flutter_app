import 'package:flutter/material.dart';
import '../models/policy_card_dto.dart';
import '../widgets/policy_card.dart';
import 'package:provider/provider.dart';

import '../providers/policies.dart';


class PoliciesCards extends StatelessWidget {
  //final bool showFavs;

  //PoliciesCards();

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Policies>(context);
    final policies =  productsData.policyInformationResponse.policies;
   return  Scrollbar(
      child: ListView(
        padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
        children: [
          for (final policy in policies   )
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: TappableTravelDestinationItem(
              destination: PolicyCardDTO.convert(policy) ),
            ) ,
        ],
      ),
    );
  }
}
