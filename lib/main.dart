import 'package:flutter/material.dart';
import './providers/tele_medicine.dart';
import './screens/medical_policy_details_screen.dart';
import './screens/screen.dart';
import './screens/telemedicine_consultation_screen.dart';
import './screens/policies_screen.dart';
import 'providers/products.dart';
import 'package:provider/provider.dart';

import 'providers/auth.dart';
import 'screens/auth_screen.dart';
import 'screens/products_overview_screen.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          update: (ctx, auth, previousProducts) => Products(
            auth,
            previousProducts == null ? [] : previousProducts.items,
          ),
        ),
        ChangeNotifierProxyProvider< Products,TeleMedicine>(
          update: (ctx, products, _ ) => TeleMedicine(
              langId: products.medicalPolicyDetailsRequest.langCode,
              policyNumber:  products.medicalPolicyDetailsRequest.policyNumber,
              memberCode: products.medicalPolicyDetailsResponse.medicalPolicyList.first.memberCode,
              phone: products.auth.customerLoginResponse.customer.mobile
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Tawuniya',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
          ),
          home: auth.isAuth ?  PoliciesScreen() :AuthScreen() , //Screen2(),//
          routes: {
            MedicalPolicyDetailsScreen.routeName: (ctx) => MedicalPolicyDetailsScreen(),
          },
        ),
      ),
    );
  }
}
