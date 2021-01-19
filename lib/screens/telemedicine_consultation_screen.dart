import 'dart:math';

import 'package:flutter/material.dart';
import '../providers/policies.dart';
import '../providers/tele_medicine.dart';
import '../soap/model/medical_policy_details_client.dart';
import '../util/exception_handler.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../models/http_exception.dart';

class TelemedicineConsultation extends StatefulWidget {
  static const routeName = '/auth';

  @override
  _TelemedicineConsultationState createState() => _TelemedicineConsultationState();
}

class _TelemedicineConsultationState extends State<TelemedicineConsultation> {
  MedicalPolicy _medicalPolicy;
  final GlobalKey<FormState> _formKey = GlobalKey();
  final myController = TextEditingController();
  var _isLoading = false;
  String _gender;
  final String _policyNumber ='19173684';
  Map<String, String> _MedicineData = {
    'langId': 'E',
    'question': '',
    'phone': '',
    'memberName': '',
    'lastName': '',
    'memberCode': '',
    'policyNumber': '',
    'memberGender': '',
  };

  List<MedicalPolicy> _friendsName = [
    MedicalPolicy(memberName: '  Faisal  ', gender: 'Malesdd'),
    MedicalPolicy(memberName: 'Mohammad    ', gender: 'Males'),
    MedicalPolicy(memberName: '    Alodat', gender: 'FeMale'),

  ];

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
        // Log user in
        await Provider.of<TeleMedicine>(context, listen: false).createTeleMedicine(
          _MedicineData,
        ).then((value) => setState(() {
          _isLoading = false;
          //_showDialog(content: 'Success',title: 'Success');
          Navigator.pop(context);
        })).catchError((error){
          setState(() {
            _isLoading = false;
          });
          var errorMessage = ExceptionHandler.handelException(error);
          _showDialog(content: errorMessage,title: 'An Error Occurred!');
        });
  }
  void _showDialog({String title,  String content}) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
      final productsData = Provider.of<Policies>(context);
      final teleMedicine =  Provider.of<TeleMedicine>(context);
      final String   phone = teleMedicine.phone;
      final medicalPolicyList =  productsData?.medicalPolicyDetailsResponse?.medicalPolicyList;
    _gender = _medicalPolicy == null ? '' : _medicalPolicy.gender;

    print(_gender);
    myController.text = _gender;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                DropdownButtonFormField(
                  value: _medicalPolicy,
                  hint: Text('Please Select Member Name'),
                  //style: TextStyle(color: Colors.black, fontSize: 22.0),
                  items: medicalPolicyList
                      .map((medicalPolicy) =>
                      DropdownMenuItem(
                        child: Text(makeTextfit(medicalPolicy.memberName)),
                        value: medicalPolicy,
                      ))
                      .toList(),
                  onChanged: (selectedValue) {

                    setState(() {
                      _medicalPolicy = selectedValue;
                      _gender = _medicalPolicy.gender;
                    });
                    _MedicineData['memberName'] = _medicalPolicy.memberName;
                    _MedicineData['memberCode'] = _medicalPolicy.memberCode;
                    _MedicineData['policyNumber'] = _policyNumber;


                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Gender'),
                    enabled: false,
                    controller:myController,
                  onSaved: (value) {
                    _MedicineData['memberGender'] = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Mobile Number'),
                  keyboardType: TextInputType.phone,
                  initialValue: phone,
                  validator: (value) {
                    if (value.isEmpty || !value.startsWith('9665')) {
                      return 'Invalid number must start with 9665';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _MedicineData['phone'] = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Consultation Request Up to 150 Charchter'),
                  //keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  validator: (value) {
                    if (value.isEmpty ) {
                      return 'Consultation is empty';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _MedicineData['question'] = value;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (_isLoading)
                          CircularProgressIndicator()
                        else RaisedButton(
                          child: Text('SubMit'),
                          onPressed: _submit,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 8.0),
                          color: Theme
                              .of(context)
                              .primaryColor,
                          textColor:
                          Theme
                              .of(context)
                              .primaryTextTheme
                              .button
                              .color,
                        ), SizedBox(
                          width: 20,
                        ),RaisedButton(
                          child: Text('Cancel'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 8.0),
                          color: Theme
                              .of(context)
                              .primaryColor,
                          textColor:
                          Theme
                              .of(context)
                              .primaryTextTheme
                              .button
                              .color,
                        ),
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String makeTextfit(String memberName) {
    if(memberName.length > 20 )
      return memberName.substring(0,20)+'..';
    else
      return memberName;
  }
}
