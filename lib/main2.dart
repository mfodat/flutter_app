import 'package:flutter/material.dart';
import './providers/tele_medicine.dart';
import './screens/medical_policy_details_screen.dart';
import './screens/policies_screen.dart';
import 'providers/policies.dart';
import 'package:provider/provider.dart';

import 'providers/auth.dart';
import 'screens/auth_screen.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Policies>(
          update: (ctx, auth, previousPolicies) => Policies( auth,
          ),
        ),
        ChangeNotifierProxyProvider< Policies,TeleMedicine>(
          update: (ctx, policies, _ ) => TeleMedicine(
              langId: policies?.medicalPolicyDetailsRequest?.langCode,
              policyNumber:  policies?.medicalPolicyDetailsRequest?.policyNumber,
              memberCode: policies?.medicalPolicyDetailsResponse?.medicalPolicyList?.first?.memberCode,
              phone: policies?.auth?.customerLoginResponse?.customer?.mobile
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Tawuniya',
          theme: ThemeData(
            primarySwatch: Colors.blueGrey,
            accentColor: Colors.blueAccent,
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
